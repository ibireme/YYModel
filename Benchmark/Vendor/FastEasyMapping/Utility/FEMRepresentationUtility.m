//
// Created by zen on 12/05/15.
// Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "FEMRepresentationUtility.h"
#import "FEMMapping.h"
#import "FEMMappingUtility.h"
#import "FEMAttribute.h"

id FEMRepresentationRootForKeyPath(id representation, NSString *keyPath) {
    if (keyPath.length > 0) {
        return [representation valueForKeyPath:keyPath];
    }

    return representation;
}

void _FEMRepresentationCollectPresentedPrimaryKeys(id, FEMMapping *, NSDictionary *);

void _FEMRepresentationCollectObjectPrimaryKeys(NSDictionary *object, FEMMapping *mapping, NSDictionary *container) {
    if (mapping.primaryKey) {
        FEMAttribute *primaryKeyMapping = mapping.primaryKeyAttribute;
        id primaryKeyValue = FEMRepresentationValueForAttribute(object, primaryKeyMapping);
        if (primaryKeyValue && primaryKeyValue != NSNull.null) {
            NSMutableSet *set = container[mapping.entityName];
            [set addObject:primaryKeyValue];
        }
    }

    for (FEMRelationship *relationship in mapping.relationships) {
        id relationshipRepresentation = FEMRepresentationRootForKeyPath(object, relationship.keyPath);
        if (relationshipRepresentation && relationshipRepresentation != NSNull.null) {
            _FEMRepresentationCollectPresentedPrimaryKeys(relationshipRepresentation, relationship.mapping, container);
        }
    }
}

void _FEMRepresentationCollectPresentedPrimaryKeys(id representation, FEMMapping *mapping, NSDictionary *container) {
    if ([representation isKindOfClass:NSArray.class]) {
        for (id object in (id<NSFastEnumeration>)representation) {
            _FEMRepresentationCollectObjectPrimaryKeys(object, mapping, container);
        }
    } else if ([representation isKindOfClass:NSDictionary.class] || [representation isKindOfClass:[NSNumber class]] || [representation isKindOfClass:[NSString class]]) {
        _FEMRepresentationCollectObjectPrimaryKeys(representation, mapping, container);
    } else {
        NSCAssert(
            NO,
            @"Expected container classes: NSArray, NSDictionary, NSNumber or NSString. Got:%@",
            NSStringFromClass([representation class])
        );
    }
};
NSDictionary *FEMRepresentationCollectPresentedPrimaryKeys(id representation, FEMMapping *mapping) {
    FEMMappingApply(mapping, ^(FEMMapping *object) {
        NSCParameterAssert(object.entityName != nil);
    });

    NSMutableDictionary *output = [[NSMutableDictionary alloc] init];
    for (NSString *name in FEMMappingCollectUsedEntityNames(mapping)) {
        output[name] = [[NSMutableSet alloc] init];
    }

    id root = FEMRepresentationRootForKeyPath(representation, mapping.rootPath);
    _FEMRepresentationCollectPresentedPrimaryKeys(root, mapping, output);

    return output;
}

id FEMRepresentationValueForAttribute(id representation, FEMAttribute *attribute) {
    id value = attribute.keyPath ? [representation valueForKeyPath:attribute.keyPath] : representation;
    // nil is a valid value for missing keys. therefore attribute is discarded
    if (value != nil) {
        // if by mistake nil returned we still have to map it to the NSNull to indicate missing value
        return [attribute mapValue:value] ?: [NSNull null];
    }

    return value;
}