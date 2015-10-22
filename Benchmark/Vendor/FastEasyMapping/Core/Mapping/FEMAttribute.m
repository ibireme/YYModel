// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMAttribute.h"

@implementation FEMAttribute {
    FEMMapBlock _map;
    FEMMapBlock _reverseMap;
}

@synthesize property = _property;
@synthesize keyPath = _keyPath;

#pragma mark - Init

- (id)initWithProperty:(NSString *)property keyPath:(NSString *)keyPath map:(FEMMapBlock)map reverseMap:(FEMMapBlock)reverseMap {
    NSParameterAssert(property.length > 0);

    self = [super init];
    if (self) {
        self.property = property;
        self.keyPath = keyPath;

        FEMMapBlock passthroughMap = ^(id value) {
            return value;
        };

        _map = map ?: passthroughMap;
        _reverseMap = reverseMap ?: passthroughMap;
    }

    return self;
}

+ (instancetype)mappingOfProperty:(NSString *)property toKeyPath:(NSString *)keyPath map:(FEMMapBlock)map reverseMap:(FEMMapBlock)reverseMap {
    return [[self alloc] initWithProperty:property keyPath:keyPath map:map reverseMap:reverseMap];
}

#pragma mark - Description

- (NSString *)description {
    return [NSString stringWithFormat:
        @"<%@ %p> property:%@ keyPath:%@",
        NSStringFromClass(self.class),
        (__bridge void *) self,
        self.property,
        self.keyPath
    ];
}

#pragma mark - Mapping

- (id)mapValue:(id)value {
    return _map(value);
}

- (id)reverseMapValue:(id)value {
    return _reverseMap(value);
}

@end

@implementation FEMAttribute (Shortcut)

+ (instancetype)mappingOfProperty:(NSString *)property toKeyPath:(NSString *)keyPath map:(FEMMapBlock)map {
    return [self mappingOfProperty:property toKeyPath:keyPath map:map reverseMap:NULL];
}

+ (instancetype)mappingOfProperty:(NSString *)property toKeyPath:(NSString *)keyPath {
    return [self mappingOfProperty:property toKeyPath:keyPath map:NULL reverseMap:NULL];
}

+ (instancetype)mappingOfProperty:(NSString *)property {
    return [self mappingOfProperty:property toKeyPath:nil map:NULL reverseMap:NULL];
}

+ (instancetype)mappingOfProperty:(NSString *)property map:(FEMMapBlock)map {
    return [self mappingOfProperty:property toKeyPath:nil map:map reverseMap:NULL];
}

+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property reverseMap:(nonnull FEMMapBlock)reverseMap {
    return [self mappingOfProperty:property toKeyPath:nil map:NULL reverseMap:reverseMap];
}

+ (instancetype)mappingOfProperty:(NSString *)property toKeyPath:(NSString *)keyPath dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:dateFormat];

    return [self mappingOfProperty:property toKeyPath:keyPath map:^id(id value) {
        return [value isKindOfClass:[NSString class]] ? [formatter dateFromString:value] : NSNull.null;
    } reverseMap:^id(id value) {
        return [formatter stringFromDate:value];
    }];
}

+ (instancetype)mappingOfURLProperty:(NSString *)property toKeyPath:(NSString *)keyPath {
    return [FEMAttribute mappingOfProperty:property toKeyPath:keyPath map:^id(id value) {
        return [value isKindOfClass:NSString.class] ? [NSURL URLWithString:value] : NSNull.null;
    }                           reverseMap:^id(NSURL *value) {
        return [value absoluteString];
    }];
}

@end