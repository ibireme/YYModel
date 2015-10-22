// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMDeserializer.h"

#import <CoreData/CoreData.h>

#import "FEMTypeIntrospection.h"
#import "NSArray+FEMPropertyRepresentation.h"
#import "FEMObjectStore.h"
#import "FEMRelationshipAssignmentContext+Internal.h"
#import "FEMRepresentationUtility.h"
#import "FEMManagedObjectStore.h"
#import "NSObject+FEMKVCExtension.h"

@implementation FEMDeserializer {
    struct {
        BOOL willMapObject: 1;
        BOOL didMapObject: 1;
        BOOL willMapCollection: 1;
        BOOL didMapCollection: 1;
    } _delegateFlags;
}

#pragma mark - Init

- (id)initWithStore:(FEMObjectStore *)store {
    NSParameterAssert(store != nil);
    self = [super init];
    if (self) {
        _store = store;
    }

    return self;
}

- (nonnull instancetype)init {
    return [self initWithStore:[[FEMObjectStore alloc] init]];
}

- (nonnull instancetype)initWithContext:(NSManagedObjectContext *)context {
    return [self initWithStore:[[FEMManagedObjectStore alloc] initWithContext:context]];
}

#pragma mark - Delegate

- (void)setDelegate:(id <FEMDeserializerDelegate>)delegate {
    _delegate = delegate;

    _delegateFlags.willMapObject = [_delegate respondsToSelector:@selector(deserializer:willMapObjectFromRepresentation:mapping:)];
    _delegateFlags.didMapObject = [_delegate respondsToSelector:@selector(deserializer:didMapObject:fromRepresentation:mapping:)];
    _delegateFlags.willMapCollection = [_delegate respondsToSelector:@selector(deserializer:willMapCollectionFromRepresentation:mapping:)];
    _delegateFlags.didMapCollection = [_delegate respondsToSelector:@selector(deserializer:didMapCollection:fromRepresentation:mapping:)];
}

#pragma mark - Deserialization

- (void)fulfillObjectRelationships:(id)object fromRepresentation:(NSDictionary *)representation usingMapping:(FEMMapping *)mapping {
    for (FEMRelationship *relationship in mapping.relationships) {
        @autoreleasepool {
            id relationshipRepresentation = FEMRepresentationRootForKeyPath(representation, relationship.keyPath);
            if (relationshipRepresentation == nil) continue;

            id targetValue = nil;
            if (relationshipRepresentation != NSNull.null) {
                if (relationship.isToMany) {
                    targetValue = [self _collectionFromRepresentation:relationshipRepresentation
                                                              mapping:relationship.mapping
                                                     allocateIfNeeded:!relationship.weak];

                    objc_property_t property = class_getProperty([object class], [relationship.property UTF8String]);
                    targetValue = [targetValue fem_propertyRepresentation:property];
                } else {
                    targetValue = [self _objectFromRepresentation:relationshipRepresentation
                                                          mapping:relationship.mapping
                                                 allocateIfNeeded:!relationship.weak];
                }
            }

            FEMRelationshipAssignmentContext *context = [self.store newAssignmentContext];
            context.destinationObject = object;
            context.relationship = relationship;
            context.sourceRelationshipValue = [object valueForKey:relationship.property];
            context.targetRelationshipValue = targetValue;

            id assignmentValue = relationship.assignmentPolicy(context);
            [object setValue:assignmentValue forKey:relationship.property];
        }
    }
}

- (void)setAttributeValue:(FEMAttribute *)attribute onObject:(id)object fromRepresentation:(id)representation {
    id value = FEMRepresentationValueForAttribute(representation, attribute);
    if (value == NSNull.null) {
        if (!FEMObjectPropertyTypeIsScalar(object, attribute.property)) {
            [object setValue:nil forKey:attribute.property];
        }
    } else if (value) {
        [object fem_setValueIfDifferent:value forKey:attribute.property];
    }
}

- (id)_fillObject:(id)object fromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping {
    for (FEMAttribute *attribute in mapping.attributes) {
        [self setAttributeValue:attribute onObject:object fromRepresentation:representation];
    }

    [self fulfillObjectRelationships:object fromRepresentation:representation usingMapping:mapping];

    return object;
}

- (id)_objectFromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping allocateIfNeeded:(BOOL)allocate {
    id object = [self.store registeredObjectForRepresentation:representation mapping:mapping];
    if (!object && allocate) {
        object = [self.store newObjectForMapping:mapping];
    }
    
    if (!object) {
        return nil;
    }

    if (_delegateFlags.willMapObject) {
        [self.delegate deserializer:self willMapObjectFromRepresentation:representation mapping:mapping];
    }

    [self _fillObject:object fromRepresentation:representation mapping:mapping];

    if ([self.store canRegisterObject:object forMapping:mapping]) {
        [self.store registerObject:object forMapping:mapping];
    }

    if (_delegateFlags.didMapObject) {
        [self.delegate deserializer:self didMapObject:object fromRepresentation:representation mapping:mapping];
    }

    return object;
}

- (NSArray *)_collectionFromRepresentation:(NSArray *)representation mapping:(FEMMapping *)mapping allocateIfNeeded:(BOOL)allocate {
    if (_delegateFlags.willMapCollection) {
        [self.delegate deserializer:self willMapCollectionFromRepresentation:representation mapping:mapping];
    }

    NSMutableArray *output = [[NSMutableArray alloc] initWithCapacity:representation.count];
    for (id objectRepresentation in representation) {
        @autoreleasepool {
            id object = [self _objectFromRepresentation:objectRepresentation mapping:mapping allocateIfNeeded:allocate];
            [output addObject:object];
        }
    }

    if (_delegateFlags.didMapCollection) {
        [self.delegate deserializer:self didMapCollection:output fromRepresentation:representation mapping:mapping];
    }

    return output;
}

#pragma mark - Public


- (id)objectFromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping {
    [self.store prepareTransactionForMapping:mapping ofRepresentation:@[representation]];
    [self.store beginTransaction];

    id root = FEMRepresentationRootForKeyPath(representation, mapping.rootPath);
    id object = [self _objectFromRepresentation:root mapping:mapping allocateIfNeeded:YES];

    [self.store commitTransaction];

    return object;
}

- (id)fillObject:(id)object fromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping {
    if (_delegateFlags.willMapObject) {
        [self.delegate deserializer:self willMapObjectFromRepresentation:representation mapping:mapping];
    }

    [self.store prepareTransactionForMapping:mapping ofRepresentation:@[representation]];
    [self.store beginTransaction];

    id root = FEMRepresentationRootForKeyPath(representation, mapping.rootPath);
    [self _fillObject:object fromRepresentation:root mapping:mapping];

    [self.store commitTransaction];

    if (_delegateFlags.didMapObject) {
        [self.delegate deserializer:self didMapObject:object fromRepresentation:representation mapping:mapping];
    }

    return object;
}

- (NSArray *)collectionFromRepresentation:(NSArray *)representation mapping:(FEMMapping *)mapping {
    [self.store prepareTransactionForMapping:mapping ofRepresentation:representation];
    [self.store beginTransaction];

    id root = FEMRepresentationRootForKeyPath(representation, mapping.rootPath);
    NSArray *objects = [self _collectionFromRepresentation:root mapping:mapping allocateIfNeeded:YES];

    [self.store commitTransaction];

    return objects;
}

@end

@implementation FEMDeserializer (Extension)

+ (id)objectFromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping context:(NSManagedObjectContext *)context {
    FEMManagedObjectStore *store = [[FEMManagedObjectStore alloc] initWithContext:context];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    return [deserializer objectFromRepresentation:representation mapping:mapping];
}

+ (id)objectFromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping {
    FEMObjectStore *store = [[FEMObjectStore alloc] init];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    return [deserializer objectFromRepresentation:representation mapping:mapping];
}

+ (id)fillObject:(id)object fromRepresentation:(NSDictionary *)representation mapping:(FEMMapping *)mapping {
    FEMObjectStore *store = nil;
    if ([object isKindOfClass:NSManagedObject.class]) {
        store = [[FEMManagedObjectStore alloc] initWithContext:[(NSManagedObject *)object managedObjectContext]];
    } else {
        store = [[FEMObjectStore alloc] init];
    }

    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    return [deserializer fillObject:object fromRepresentation:representation mapping:mapping];
};

+ (NSArray *)collectionFromRepresentation:(NSArray *)representation mapping:(FEMMapping *)mapping context:(NSManagedObjectContext *)context {
    FEMManagedObjectStore *store = [[FEMManagedObjectStore alloc] initWithContext:context];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    return [deserializer collectionFromRepresentation:representation mapping:mapping];
}

+ (NSArray *)collectionFromRepresentation:(NSArray *)representation mapping:(FEMMapping *)mapping {
    FEMObjectStore *store = [[FEMObjectStore alloc] init];
    FEMDeserializer *deserializer = [[FEMDeserializer alloc] initWithStore:store];
    return [deserializer collectionFromRepresentation:representation mapping:mapping];
}

@end

@implementation FEMDeserializer (FEMManagedObjectDeserializer_Deprecated)

+ (id)deserializeObjectExternalRepresentation:(NSDictionary *)externalRepresentation usingMapping:(FEMMapping *)mapping context:(NSManagedObjectContext *)context {
    return [self objectFromRepresentation:externalRepresentation mapping:mapping context:context];
}

+ (NSArray *)deserializeCollectionExternalRepresentation:(NSArray *)externalRepresentation usingMapping:(FEMMapping *)mapping context:(NSManagedObjectContext *)context {
    return [self collectionFromRepresentation:externalRepresentation mapping:mapping context:context];
}

@end

@implementation FEMDeserializer (FEMObjectDeserializer_Deprecated)

+ (id)deserializeObjectExternalRepresentation:(NSDictionary *)externalRepresentation usingMapping:(FEMMapping *)mapping {
    return [self objectFromRepresentation:externalRepresentation mapping:mapping];
}

+ (id)fillObject:(NSManagedObject *)object fromExternalRepresentation:(NSDictionary *)externalRepresentation usingMapping:(FEMMapping *)mapping {
    return [self fillObject:object fromRepresentation:externalRepresentation mapping:mapping];
}

+ (NSArray *)deserializeCollectionExternalRepresentation:(NSArray *)externalRepresentation usingMapping:(FEMMapping *)mapping {
    return [self collectionFromRepresentation:externalRepresentation mapping:mapping];
}

@end