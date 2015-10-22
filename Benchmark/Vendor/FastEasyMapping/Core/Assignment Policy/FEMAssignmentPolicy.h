// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>

@class FEMRelationshipAssignmentContext;

typedef __nullable id (^FEMAssignmentPolicy)(FEMRelationshipAssignmentContext * __nonnull context);

OBJC_EXTERN __nonnull FEMAssignmentPolicy FEMAssignmentPolicyAssign;

OBJC_EXTERN __nonnull FEMAssignmentPolicy FEMAssignmentPolicyObjectMerge;
OBJC_EXTERN __nonnull FEMAssignmentPolicy FEMAssignmentPolicyCollectionMerge;

OBJC_EXTERN __nonnull FEMAssignmentPolicy FEMAssignmentPolicyObjectReplace;
OBJC_EXTERN __nonnull FEMAssignmentPolicy FEMAssignmentPolicyCollectionReplace;