// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMObjectStore.h"

@class NSManagedObjectContext;

@interface FEMManagedObjectStore : FEMObjectStore

- (nonnull instancetype)initWithContext:(nonnull NSManagedObjectContext *)context NS_DESIGNATED_INITIALIZER;
@property (nonatomic, strong, readonly, nonnull) NSManagedObjectContext *context;

@property (nonatomic) BOOL saveContextOnCommit;

@end