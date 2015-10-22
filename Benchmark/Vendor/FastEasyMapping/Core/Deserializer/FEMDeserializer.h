// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>
#import "FEMManagedObjectMapping.h"

@class FEMObjectStore, FEMMapping, NSManagedObject, NSFetchRequest, NSManagedObjectContext;
@class FEMDeserializer;

@protocol FEMDeserializerDelegate <NSObject>

@optional
- (void)deserializer:(nonnull FEMDeserializer *)deserializer willMapObjectFromRepresentation:(nonnull id)representation mapping:(nonnull FEMMapping *)mapping;
- (void)deserializer:(nonnull FEMDeserializer *)deserializer didMapObject:(nonnull id)object fromRepresentation:(nonnull id)representation mapping:(nonnull FEMMapping *)mapping;

- (void)deserializer:(nonnull FEMDeserializer *)deserializer willMapCollectionFromRepresentation:(nonnull NSArray *)representation mapping:(nonnull FEMMapping *)mapping;
- (void)deserializer:(nonnull FEMDeserializer *)deserializer didMapCollection:(nonnull NSArray *)collection fromRepresentation:(nonnull NSArray *)representation mapping:(nonnull FEMMapping *)mapping;

@end

@interface FEMDeserializer : NSObject

@property (nonatomic, strong, readonly, nonnull) FEMObjectStore *store;
- (nonnull instancetype)initWithStore:(nonnull FEMObjectStore *)store NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)init;
- (nonnull instancetype)initWithContext:(nonnull NSManagedObjectContext *)context;

@property (nonatomic, unsafe_unretained, nullable) id<FEMDeserializerDelegate> delegate;

- (nonnull id)objectFromRepresentation:(nonnull NSDictionary *)representation mapping:(nonnull FEMMapping *)mapping;
- (nonnull id)fillObject:(nonnull id)object fromRepresentation:(nonnull NSDictionary *)representation mapping:(nonnull FEMMapping *)mapping;
- (nonnull NSArray *)collectionFromRepresentation:(nonnull NSArray *)representation mapping:(nonnull FEMMapping *)mapping;

@end

@interface FEMDeserializer (Extension)

+ (nonnull id)objectFromRepresentation:(nonnull NSDictionary *)representation mapping:(nonnull FEMMapping *)mapping context:(nonnull NSManagedObjectContext *)context;
+ (nonnull id)objectFromRepresentation:(nonnull NSDictionary *)representation mapping:(nonnull FEMMapping *)mapping;

+ (nonnull id)fillObject:(nonnull id)object fromRepresentation:(nonnull NSDictionary *)representation mapping:(nonnull FEMMapping *)mapping;

+ (nonnull NSArray *)collectionFromRepresentation:(nonnull NSArray *)representation mapping:(nonnull FEMMapping *)mapping context:(nonnull NSManagedObjectContext *)context;
+ (nonnull NSArray *)collectionFromRepresentation:(nonnull NSArray *)representation mapping:(nonnull FEMMapping *)mapping;

@end


@interface FEMDeserializer (FEMObjectDeserializer_Deprecated)

+ (nonnull id)deserializeObjectExternalRepresentation:(nonnull NSDictionary *)externalRepresentation usingMapping:(nonnull FEMMapping *)mapping __attribute__((deprecated("Use +[FEMDeserializer objectFromRepresentation:mapping:] instead")));
+ (nonnull id)fillObject:(nonnull id)object fromExternalRepresentation:(nonnull NSDictionary *)externalRepresentation usingMapping:(nonnull FEMMapping *)mapping __attribute__((deprecated("Use +[FEMDeserializer fillObject:fromRepresentation:mapping:] instead")));
+ (nonnull NSArray *)deserializeCollectionExternalRepresentation:(nonnull NSArray *)externalRepresentation usingMapping:(nonnull FEMMapping *)mapping __attribute__((deprecated("Use +[FEMDeserializer collectionFromRepresentation:mapping:] instead")));

@end

@interface FEMDeserializer (FEMManagedObjectDeserializer_Deprecated)

+ (nonnull id)deserializeObjectExternalRepresentation:(nonnull NSDictionary *)externalRepresentation usingMapping:(nonnull FEMMapping *)mapping context:(nonnull NSManagedObjectContext *)context __attribute__((deprecated("Use +[FEMDeserializer objectFromRepresentation:mapping:context:] instead")));
+ (nonnull NSArray *)deserializeCollectionExternalRepresentation:(nonnull NSArray *)externalRepresentation usingMapping:(nonnull FEMMapping *)mapping context:(nonnull NSManagedObjectContext *)context __attribute__((deprecated("Use +[FEMDeserializer collectionFromRepresentation:mapping:context:] instead")));
+ (nonnull NSArray *)synchronizeCollectionExternalRepresentation:(nonnull NSArray *)externalRepresentation usingMapping:(nonnull FEMMapping *)mapping predicate:(nonnull NSPredicate *)predicate context:(nonnull NSManagedObjectContext *)context __attribute__((unavailable));

@end