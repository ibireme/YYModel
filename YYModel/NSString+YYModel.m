//
//  NSString+YYModel.m
//  ModelBenchmark
//
//  Created by HHIOS on 2017/4/20.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import "NSString+YYModel.h"


@interface NSString (__YYAdd)
/// 驼峰转下划线（loveYou -> love_you）
- (NSString *)_underlineFromCamel;
/// 下划线转驼峰（love_you -> loveYou）
- (NSString *)_camelFromUnderline;
/// 首字母变大写
- (NSString *)_firstCharUpper;
/// 首字母变小写
- (NSString *)_firstCharLower;
@end
@implementation NSString (__YYAdd)
- (NSString *)_underlineFromCamel {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        NSString *cStringLower = [cString lowercaseString];
        if ([cString isEqualToString:cStringLower]) {
            [string appendString:cStringLower];
        } else {
            [string appendString:@"_"];
            [string appendString:cStringLower];
        }
    }
    return string;
}

- (NSString *)_camelFromUnderline {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    NSArray *cmps = [self componentsSeparatedByString:@"_"];
    for (NSUInteger i = 0; i<cmps.count; i++) {
        NSString *cmp = cmps[i];
        if (i && cmp.length) {
            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
            if (cmp.length >= 2) [string appendString:[cmp substringFromIndex:1]];
        } else {
            [string appendString:cmp];
        }
    }
    return string;
}

- (NSString *)_firstCharLower {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

- (NSString *)_firstCharUpper {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}
@end


@implementation NSString (YYModel)

- (NSString *)stringWithMapperType:(NSStringMapperType)type {
    switch (type) {
        case NSStringMapperFirstCharLower:
            return self._firstCharLower;
        case NSStringMapperFirstCharUpper:
            return self._firstCharUpper;
        case NSStringMapperUnderLineFromCamel:
            return self._underlineFromCamel;
        case NSStringMapperCamelFromUnderLine:
            return self._camelFromUnderline;
        default:
            break;
    }
    return self;
}

@end
