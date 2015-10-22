// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>

#import "FEMRelationshipAssignmentContext.h"

@class FEMMapping;

@interface FEMObjectStore : NSObject <FEMRelationshipAssignmentContextDelegate>

- (void)prepareTransactionForMapping:(nonnull FEMMapping *)mapping ofRepresentation:(nonnull NSArray *)representation;
- (void)beginTransaction;
- (nullable NSError *)commitTransaction;

- (nonnull id)newObjectForMapping:(nonnull FEMMapping *)mapping;
- (nonnull FEMRelationshipAssignmentContext *)newAssignmentContext;

- (void)registerObject:(nonnull id)object forMapping:(nonnull FEMMapping *)mapping;
- (BOOL)canRegisterObject:(nonnull id)object forMapping:(nonnull FEMMapping *)mapping;

- (nonnull NSDictionary *)registeredObjectsForMapping:(nonnull FEMMapping *)mapping;
- (nullable id)registeredObjectForRepresentation:(nonnull id)representation mapping:(nonnull FEMMapping *)mapping;

@end