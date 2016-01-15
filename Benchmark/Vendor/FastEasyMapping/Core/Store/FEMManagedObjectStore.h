// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMObjectStore.h"

NS_ASSUME_NONNULL_BEGIN

@class NSManagedObjectContext;

@interface FEMManagedObjectStore : FEMObjectStore

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithContext:(NSManagedObjectContext *)context NS_DESIGNATED_INITIALIZER;
@property (nonatomic, strong, readonly) NSManagedObjectContext *context;

@property (nonatomic) BOOL saveContextOnCommit;

@end

NS_ASSUME_NONNULL_END