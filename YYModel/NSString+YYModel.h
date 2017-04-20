//
//  NSString+YYModel.h
//  ModelBenchmark
//
//  Created by HHIOS on 2017/4/20.
//  Copyright © 2017年 ibireme. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 转换类型
typedef NS_ENUM(NSUInteger, NSStringMapperType) {
    NSStringMapperDefault = 0,///< 不做转换
    NSStringMapperFirstCharLower = 1,///< 首字母变小写
    NSStringMapperFirstCharUpper, ///< 首字母变大写
    NSStringMapperUnderLineFromCamel, ///< 驼峰转下划线（loveYou -> love_you）
    NSStringMapperCamelFromUnderLine, ///< 下划线转驼峰（love_you -> loveYou）
};


@interface NSString (YYModel)

- (NSString *)stringWithMapperType:(NSStringMapperType)type;

@end
