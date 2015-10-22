// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>

#import "FEMAssignmentPolicy.h"
#import "FEMProperty.h"

@class FEMMapping;

@interface FEMRelationship : NSObject <FEMProperty>

@property (nonatomic, strong, nonnull) FEMMapping *mapping;
@property (nonatomic, getter=isToMany) BOOL toMany;

@property (nonatomic) BOOL weak;
@property (nonatomic, copy, nonnull) FEMAssignmentPolicy assignmentPolicy;

- (nonnull instancetype)initWithProperty:(nonnull NSString *)property mapping:(nonnull FEMMapping *)mapping;

- (nonnull instancetype)initWithProperty:(nonnull NSString *)property
                                 keyPath:(nullable NSString *)keyPath
                                 mapping:(nonnull FEMMapping *)mapping NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithProperty:(nonnull NSString *)property
                                 keyPath:(nonnull NSString *)keyPath
                                 mapping:(nonnull FEMMapping *)mapping
                        assignmentPolicy:(nonnull FEMAssignmentPolicy)assignmentPolicy;

- (void)setMapping:(nonnull FEMMapping *)mapping forKeyPath:(nullable NSString *)keyPath;

@end

@interface FEMRelationship (Deprecated)

- (void)setObjectMapping:(nonnull FEMMapping *)objectMapping forKeyPath:(nullable NSString *)keyPath __attribute__((deprecated("Use -[FEMRelationship setMappaing:forKeyPath:] instead")));

- (nonnull instancetype)initWithProperty:(nonnull NSString *)property
                                 keyPath:(nullable NSString *)keyPath
                        assignmentPolicy:(nullable FEMAssignmentPolicy)policy
                           objectMapping:(nullable FEMMapping *)objectMapping __attribute__((deprecated("Use -[FEMRelationship initWithProperty:keyPath:mapping:assignmentPolicy:] instead")));

/**
* same as + [FEMRelationship mappingOfProperty:property toKeyPath:nil mapping:mapping];
*/
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property objectMapping:(nonnull FEMMapping *)objectMapping __attribute__((deprecated("Use -[FEMRelationship initWithProperty:mapping:] instead")));
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property
                                toKeyPath:(nullable NSString *)keyPath
                            objectMapping:(nonnull FEMMapping *)objectMapping __attribute__((deprecated("Use -[FEMRelationship initWithProperty:keyPath:mapping:] instead")));

@property (nonatomic, strong, nonnull) FEMMapping *objectMapping __attribute__((deprecated("Use FEMRelationship.mapping instead")));

@end

@interface FEMRelationship (Unavailable)

+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property
                            configuration:(nonnull void (^)(FEMRelationship * __nonnull mapping))configuration __attribute__((unavailable("Use -[FEMRelationship initWithProperty:keyPath:mapping:] instead")));

+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property
                                toKeyPath:(nullable NSString *)keyPath
                            configuration:(nonnull void (^)(FEMRelationship * __nonnull mapping))configuration __attribute__((unavailable("Use -[FEMRelationship initWithProperty:keyPath:mapping:] instead")));

@end