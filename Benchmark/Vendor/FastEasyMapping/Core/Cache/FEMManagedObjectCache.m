// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMManagedObjectCache.h"

#import <CoreData/CoreData.h>

#import "FEMMapping.h"
#import "FEMRepresentationUtility.h"

@implementation FEMManagedObjectCache {
	NSManagedObjectContext *_context;

	NSDictionary *_lookupKeysMap;
	NSMutableDictionary *_lookupObjectsMap;
}

#pragma mark - Init


- (instancetype)initWithMapping:(FEMMapping *)mapping representation:(id)representation context:(NSManagedObjectContext *)context {
	NSParameterAssert(mapping);
    NSParameterAssert(representation);
	NSParameterAssert(context);

	self = [self init];
	if (self) {
		_context = context;

		_lookupKeysMap = FEMRepresentationCollectPresentedPrimaryKeys(representation, mapping);
		_lookupObjectsMap = [NSMutableDictionary new];
	}

	return self;
}

#pragma mark - Inspection

- (NSMutableDictionary *)fetchExistingObjectsForMapping:(FEMMapping *)mapping {
	NSSet *lookupValues = _lookupKeysMap[mapping.entityName];
	if (lookupValues.count == 0) return [NSMutableDictionary dictionary];

	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:mapping.entityName];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K IN %@", mapping.primaryKey, lookupValues];
	[fetchRequest setPredicate:predicate];
	[fetchRequest setFetchLimit:lookupValues.count];

	NSMutableDictionary *output = [NSMutableDictionary new];
	NSArray *existingObjects = [_context executeFetchRequest:fetchRequest error:NULL];
	for (NSManagedObject *object in existingObjects) {
		output[[object valueForKey:mapping.primaryKey]] = object;
	}

	return output;
}

- (NSMutableDictionary *)cachedObjectsForMapping:(FEMMapping *)mapping {
	NSMutableDictionary *entityObjectsMap = _lookupObjectsMap[mapping.entityName];
	if (!entityObjectsMap) {
		entityObjectsMap = [self fetchExistingObjectsForMapping:mapping];
		_lookupObjectsMap[mapping.entityName] = entityObjectsMap;
	}

	return entityObjectsMap;
}

- (id)existingObjectForRepresentation:(id)representation mapping:(FEMMapping *)mapping {
	NSDictionary *entityObjectsMap = [self cachedObjectsForMapping:mapping];

	id primaryKeyValue = FEMRepresentationValueForAttribute(representation, mapping.primaryKeyAttribute);
	if (primaryKeyValue == nil || primaryKeyValue == NSNull.null) return nil;

	return entityObjectsMap[primaryKeyValue];
}

- (id)existingObjectForPrimaryKey:(id)primaryKey mapping:(FEMMapping *)mapping {
    NSDictionary *entityObjectsMap = [self cachedObjectsForMapping:mapping];

    return entityObjectsMap[primaryKey];
}

- (void)addExistingObject:(id)object mapping:(FEMMapping *)mapping {
	NSParameterAssert(mapping.primaryKey);
	NSParameterAssert(object);

	id primaryKeyValue = [object valueForKey:mapping.primaryKey];
	NSAssert(primaryKeyValue, @"No value for key (%@) on object (%@) found", mapping.primaryKey, object);

	NSMutableDictionary *entityObjectsMap = [self cachedObjectsForMapping:mapping];
    entityObjectsMap[primaryKeyValue] = object;
}

- (NSDictionary *)existingObjectsForMapping:(FEMMapping *)mapping {
    return [[self cachedObjectsForMapping:mapping] copy];
}

@end