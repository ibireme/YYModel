// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMRelationship.h"
#import "FEMMapping.h"

@implementation FEMRelationship

@synthesize property = _property;
@synthesize keyPath = _keyPath;

#pragma mark - Init

- (instancetype)initWithProperty:(NSString *)property mapping:(FEMMapping *)mapping {
    return [self initWithProperty:property keyPath:nil mapping:mapping];
}

- (instancetype)initWithProperty:(NSString *)property keyPath:(NSString *)keyPath mapping:(FEMMapping *)mapping {
    self = [super init];
    if (self) {
        self.property = property;
        self.keyPath = keyPath;
        self.mapping = mapping;
        self.assignmentPolicy = FEMAssignmentPolicyAssign;
    }

    return self;
}

- (instancetype)initWithProperty:(NSString *)property keyPath:(NSString *)keyPath mapping:(FEMMapping *)mapping assignmentPolicy:(FEMAssignmentPolicy)assignmentPolicy {
    self = [self initWithProperty:property keyPath:keyPath mapping:mapping];
    if (self) {
        self.assignmentPolicy = assignmentPolicy;
    }
    return self;
}

#pragma mark - Shortcut

- (void)setMapping:(nonnull FEMMapping *)mapping forKeyPath:(nullable NSString *)keyPath {
    self.mapping = mapping;
    self.keyPath = keyPath;
}

#pragma mark - Description

- (NSString *)description {
    return [NSString stringWithFormat:
        @"<%@ %p>\n {\nproperty:%@ keyPath:%@ toMany:%@\nmapping:(%@)}\n",
        NSStringFromClass(self.class),
        (__bridge void *) self,
        self.property,
        self.keyPath,
        @(self.toMany),
        [self.mapping description]
    ];
}

@end

@implementation FEMRelationship (Deprecated)

@dynamic objectMapping;

- (FEMMapping *)objectMapping {
    return self.mapping;
}

- (void)setObjectMapping:(FEMMapping *)objectMapping {
    self.mapping = objectMapping;
}

+ (instancetype)mappingOfProperty:(NSString *)property keyPath:(NSString *)keyPath objectMapping:(FEMMapping *)objectMapping {
    return [[self alloc] initWithProperty:property keyPath:keyPath mapping:objectMapping];
}

#pragma mark - Init

- (instancetype)initWithProperty:(NSString *)property
                         keyPath:(NSString *)keyPath
                assignmentPolicy:(FEMAssignmentPolicy)policy
                   objectMapping:(FEMMapping *)objectMapping {
    return [self initWithProperty:property keyPath:keyPath mapping:objectMapping assignmentPolicy:policy];
}

+ (instancetype)mappingOfProperty:(NSString *)property toKeyPath:(NSString *)keyPath objectMapping:(FEMMapping *)objectMapping {
    return [[self alloc] initWithProperty:property keyPath:keyPath mapping:objectMapping];
}

+ (instancetype)mappingOfProperty:(NSString *)property objectMapping:(FEMMapping *)objectMapping {
    return [[self alloc] initWithProperty:property mapping:objectMapping];
}

#pragma mark - Property objectMapping

- (void)setObjectMapping:(FEMMapping *)objectMapping forKeyPath:(NSString *)keyPath {
    [self setMapping:objectMapping forKeyPath:keyPath];
}

@end