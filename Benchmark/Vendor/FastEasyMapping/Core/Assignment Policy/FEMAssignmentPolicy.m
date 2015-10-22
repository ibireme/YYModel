// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMAssignmentPolicy.h"

#import "FEMRelationshipAssignmentContext.h"
#import "FEMExcludableCollection.h"
#import "FEMMergeableCollection.h"

FEMAssignmentPolicy FEMAssignmentPolicyAssign = ^id(FEMRelationshipAssignmentContext * context) {
    return context.targetRelationshipValue;
};

FEMAssignmentPolicy FEMAssignmentPolicyObjectMerge = ^id(FEMRelationshipAssignmentContext *context) {
    return context.targetRelationshipValue ?: context.sourceRelationshipValue;
};

FEMAssignmentPolicy FEMAssignmentPolicyCollectionMerge = ^id(FEMRelationshipAssignmentContext *context) {
    if (!context.targetRelationshipValue) return context.sourceRelationshipValue;

    NSCAssert(
        [context.targetRelationshipValue conformsToProtocol:@protocol(FEMMergeableCollection)],
        @"Collection %@ should support protocol %@",
        NSStringFromClass([context.targetRelationshipValue class]),
        NSStringFromProtocol(@protocol(FEMMergeableCollection))
    );

    return [context.targetRelationshipValue collectionByMergingObjects:context.sourceRelationshipValue];
};

FEMAssignmentPolicy FEMAssignmentPolicyObjectReplace = ^id(FEMRelationshipAssignmentContext *context) {
    if (context.sourceRelationshipValue && ![context.sourceRelationshipValue isEqual:context.targetRelationshipValue]) {
        [context deleteRelationshipObject:context.sourceRelationshipValue];
    }

    return context.targetRelationshipValue;
};

FEMAssignmentPolicy FEMAssignmentPolicyCollectionReplace = ^id(FEMRelationshipAssignmentContext *context) {
    if (!context.sourceRelationshipValue) return context.targetRelationshipValue;

    if (context.targetRelationshipValue) {
        NSCAssert(
            [context.sourceRelationshipValue conformsToProtocol:@protocol(FEMExcludableCollection)],
            @"Collection %@ should support protocol %@",
            NSStringFromClass([context.targetRelationshipValue class]),
            NSStringFromProtocol(@protocol(FEMExcludableCollection))
        );

        id objectsToDelete = [(id <FEMExcludableCollection>) context.sourceRelationshipValue collectionByExcludingObjects:context.targetRelationshipValue];
        for (id object in objectsToDelete) {
            [context deleteRelationshipObject:object];
        }
    } else {
        for (id object in context.sourceRelationshipValue) {
            [context deleteRelationshipObject:object];
        }
    }

    return context.targetRelationshipValue;
};