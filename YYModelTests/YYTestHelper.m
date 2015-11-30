//
//  YYTestHelper.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/11/28.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "YYTestHelper.h"

@implementation YYTestHelper

+ (NSString *)jsonStringFromData:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)jsonStringFromObject:(id)object {
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:NULL];
    return [self jsonStringFromData:data];
}

+ (id)jsonObjectFromData:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
}

+ (id)jsonObjectFromString:(NSString *)string {
    NSData *data = [self jsonDataFromString:string];
    return [self jsonObjectFromData:data];
}

+ (NSData *)jsonDataFromString:(NSString *)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSData *)jsonDataFromObject:(id)object {
    NSString *string = [self jsonStringFromObject:object];
    return [self jsonDataFromString:string];
}

@end
