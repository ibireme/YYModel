// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>

#import "FEMAttribute.h"
#import "FEMRelationship.h"

@interface FEMMapping : NSObject {
    @protected
	NSMutableDictionary *_attributeMap;
	NSMutableDictionary *_relationshipMap;
}

- (nonnull instancetype)init __attribute__((unavailable("use -[FEMMapping initWithObjectClass:] or -[FEMMapping initWithEntityName:] insted")));
+ (nonnull instancetype)new __attribute__((unavailable("use -[FEMMapping initWithObjectClass:] or -[FEMMapping initWithEntityName:] insted")));
- (nonnull instancetype)initWithRootPath:(nullable NSString *)rootPath __attribute__((unavailable("use -[FEMMapping initWithObjectClass:] or -[FEMMapping initWithEntityName:] insted")));

- (nonnull instancetype)initWithObjectClass:(nonnull Class)objectClass NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithObjectClass:(nonnull Class)objectClass rootPath:(nullable NSString *)rootPath;

- (nonnull instancetype)initWithEntityName:(nonnull NSString *)entityName NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithEntityName:(nonnull NSString *)entityName rootPath:(nullable NSString *)rootPath;

@property (nonatomic, readonly, nullable) Class objectClass;
@property (nonatomic, copy, readonly, nullable) NSString *entityName;

@property (nonatomic, copy, nullable) NSString *rootPath;

@property (nonatomic, copy, nullable) NSString *primaryKey;
@property (nonatomic, strong, readonly, nullable) FEMAttribute *primaryKeyAttribute;

@property (nonatomic, strong, readonly, nonnull) NSArray *attributes;
- (void)addAttribute:(nonnull FEMAttribute *)attribute;
- (nullable FEMAttribute *)attributeForProperty:(nonnull NSString *)property;

@property (nonatomic, strong, readonly, nonnull) NSArray *relationships;
- (void)addRelationship:(nonnull FEMRelationship *)relationship;
- (nullable FEMRelationship *)relationshipForProperty:(nonnull NSString *)property;

@end

@interface FEMMapping (Shortcut)

- (void)addAttributesFromArray:(nonnull NSArray *)attributes;
- (void)addAttributesFromDictionary:(nonnull NSDictionary *)attributesToKeyPath;
- (void)addAttributeWithProperty:(nonnull NSString *)property keyPath:(nullable NSString *)keyPath;

- (void)addRelationshipMapping:(nonnull FEMMapping *)mapping forProperty:(nonnull NSString *)property keyPath:(nullable NSString *)keyPath;
- (void)addToManyRelationshipMapping:(nonnull FEMMapping *)mapping forProperty:(nonnull NSString *)property keyPath:(nullable NSString *)keyPath;

@end

@interface FEMMapping (FEMObjectMapping_Deprecated)

+ (nonnull FEMMapping *)mappingForClass:(nonnull Class)objectClass configuration:(nonnull void (^)(FEMMapping * __nonnull mapping))configuration __attribute__((deprecated("Use -[FEMMapping initWithObjectClass:] instead")));
+ (nonnull FEMMapping *)mappingForClass:(nonnull Class)objectClass rootPath:(nullable NSString *)rootPath configuration:(nonnull void (^)(FEMMapping * __nonnull mapping))configuration __attribute__((deprecated("Use -[FEMMapping initWithObjectClass:rootPath:] instead")));

@end


@interface FEMMapping (FEMManagedObjectMapping_Deprecated)

+ (nonnull FEMMapping *)mappingForEntityName:(nonnull NSString *)entityName __attribute__((deprecated("Use -[FEMMapping initWithEntityName:] instead")));
+ (nonnull FEMMapping *)mappingForEntityName:(nonnull NSString *)entityName configuration:(nullable void (^)(FEMMapping * __nonnull sender))configuration __attribute__((deprecated("Use -[FEMMapping initWithEntityName:] instead")));
+ (nonnull FEMMapping *)mappingForEntityName:(nonnull NSString *)entityName rootPath:(nullable NSString *)rootPath configuration:(nullable void (^)(FEMMapping * __nonnull sender))configuration __attribute__((deprecated("Use -[FEMMapping initWithEntityName:rootPath:] instead")));

@end
