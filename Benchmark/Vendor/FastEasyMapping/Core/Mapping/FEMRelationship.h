// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>

#import "FEMAssignmentPolicy.h"
#import "FEMProperty.h"

NS_ASSUME_NONNULL_BEGIN

@class FEMMapping;

@interface FEMRelationship : NSObject <FEMProperty>

@property (nonatomic, strong) FEMMapping *mapping;
@property (nonatomic, getter=isToMany) BOOL toMany;

@property (nonatomic) BOOL weak;
@property (nonatomic, copy) FEMAssignmentPolicy assignmentPolicy;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithProperty:(NSString *)property keyPath:(nullable NSString *)keyPath mapping:(FEMMapping *)mapping NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithProperty:(NSString *)property mapping:(FEMMapping *)mapping;
- (instancetype)initWithProperty:(NSString *)property keyPath:(NSString *)keyPath mapping:(FEMMapping *)mapping assignmentPolicy:(FEMAssignmentPolicy)assignmentPolicy;

- (void)setMapping:(FEMMapping *)mapping forKeyPath:(nullable NSString *)keyPath;

@end

@interface FEMRelationship (Deprecated)

- (void)setObjectMapping:(FEMMapping *)objectMapping forKeyPath:(nullable NSString *)keyPath __attribute__((deprecated("Use -[FEMRelationship setMappaing:forKeyPath:] instead")));

- (instancetype)initWithProperty:(NSString *)property
                         keyPath:(nullable NSString *)keyPath
                assignmentPolicy:(nullable FEMAssignmentPolicy)policy
                   objectMapping:(nullable FEMMapping *)objectMapping __attribute__((deprecated("Use -[FEMRelationship initWithProperty:keyPath:mapping:assignmentPolicy:] instead")));

/**
* same as + [FEMRelationship mappingOfProperty:property toKeyPath:nil mapping:mapping];
*/
+ (instancetype)mappingOfProperty:(NSString *)property objectMapping:(FEMMapping *)objectMapping __attribute__((deprecated("Use -[FEMRelationship initWithProperty:mapping:] instead")));

+ (instancetype)mappingOfProperty:(NSString *)property
                        toKeyPath:(nullable NSString *)keyPath
                    objectMapping:(FEMMapping *)objectMapping __attribute__((deprecated("Use -[FEMRelationship initWithProperty:keyPath:mapping:] instead")));

@property (nonatomic, strong) FEMMapping *objectMapping __attribute__((deprecated("Use FEMRelationship.mapping instead")));

@end

@interface FEMRelationship (Unavailable)

+ (instancetype)mappingOfProperty:(NSString *)property
                    configuration:(void (^)(FEMRelationship *__mapping))configuration __attribute__((unavailable("Use -[FEMRelationship initWithProperty:keyPath:mapping:] instead")));

+ (instancetype)mappingOfProperty:(NSString *)property
                        toKeyPath:(nullable NSString *)keyPath
                    configuration:(void (^)(FEMRelationship *__mapping))configuration __attribute__((unavailable("Use -[FEMRelationship initWithProperty:keyPath:mapping:] instead")));

@end

NS_ASSUME_NONNULL_END