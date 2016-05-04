//
//  YYTestModelToJSON.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/11/29.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "YYModel.h"
#import "YYTestHelper.h"

@interface YYTestModelToJSONModel : NSObject
@property bool boolValue;
@property BOOL BOOLValue;
@property char charValue;
@property unsigned char unsignedCharValue;
@property short shortValue;
@property unsigned short unsignedShortValue;
@property int intValue;
@property unsigned int unsignedIntValue;
@property long longValue;
@property unsigned long unsignedLongValue;
@property long long longLongValue;
@property unsigned long long unsignedLongLongValue;
@property float floatValue;
@property double doubleValue;
@property long double longDoubleValue;
@property (strong) Class classValue;
@property SEL selectorValue;
@property (copy) void (^blockValue)();
@property void *pointerValue;
@property CGRect structValue;
@property CGPoint pointValue;

@property (nonatomic, strong) NSObject *object;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDecimalNumber *decimal;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSMutableString *mString;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSMutableData *mData;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSValue *value;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSMutableDictionary *mDict;
@property (nonatomic, strong) NSSet *set;
@property (nonatomic, strong) NSMutableSet *mSet;
@property (nonatomic, strong) UIColor *color;
@end

@implementation YYTestModelToJSONModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"intValue" : @"int",
             @"longValue" : @"long",             // mapped to same key
             @"unsignedLongLongValue" : @"long", // mapped to same key
             @"shortValue" : @"ext.short"        // mapped to key path
             };
}
@end



@interface YYTestKeyPathModelToJSONModel : NSObject
@property (nonatomic, strong) NSString *a;
@property (nonatomic, strong) NSString *b;
@property (nonatomic, strong) NSString *c;
@property (nonatomic, strong) NSString *d;
@property (nonatomic, strong) NSString *e;
@property (nonatomic, strong) NSDictionary *f;
@property (nonatomic, strong) NSString *g;
@end

@implementation YYTestKeyPathModelToJSONModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"a" : @"ext.a",
             @"b" : @"ext.b",
             @"c" : @"ext.a",
             @"e" : @"d.e",
             @"g" : @"f.g.g"
             };
}
@end



@interface YYTestModelToJSON : XCTestCase

@end

@implementation YYTestModelToJSON


- (void)testToJSON {
    YYTestModelToJSONModel *model = [YYTestModelToJSONModel new];
    model.intValue = 1;
    model.longValue = 2;
    model.unsignedLongLongValue = 3;
    model.shortValue = 4;
    model.array = @[@1,@"2",[NSURL URLWithString:@"https://github.com"]];
    model.set = [NSSet setWithArray:model.array];
    model.color = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    
    NSDictionary *jsonObject = [model yy_modelToJSONObject];
    XCTAssert([jsonObject isKindOfClass:[NSDictionary class]]);
    XCTAssert([jsonObject[@"int"] isEqual:@(1)]);
    XCTAssert([jsonObject[@"long"] isEqual:@(2)] || [jsonObject[@"long"] isEqual:@(3)]);
    XCTAssert([ ((NSDictionary *)jsonObject[@"ext"])[@"short"] isEqual:@(4)]);
    XCTAssert(jsonObject[@"color"] != nil);
    
    NSString *jsonString = [model yy_modelToJSONString];
    XCTAssert([[YYTestHelper jsonObjectFromString:jsonString] isKindOfClass:[NSDictionary class]]);
    
    NSData *jsonData = [model yy_modelToJSONData];
    XCTAssert([[YYTestHelper jsonObjectFromData:jsonData] isKindOfClass:[NSDictionary class]]);
    
    model = [YYTestModelToJSONModel yy_modelWithJSON:jsonData];
    XCTAssert(model.intValue == 1);
}

- (void)testKeyPath {
    YYTestKeyPathModelToJSONModel *model = [YYTestKeyPathModelToJSONModel new];
    model.a = @"a";
    model.b = @"b";
    model.c = @"c";
    model.d = @"d";
    model.e = @"e";
    model.f = @{};
    
    NSDictionary *dic = [model yy_modelToJSONObject];
    NSDictionary *ext = dic[@"ext"];
    XCTAssert([ext[@"b"] isEqualToString:@"b"]);
    XCTAssert([ext[@"a"] isEqualToString:@"a"] || [ext[@"a"] isEqualToString:@"c"]);
    
    model.f = @{@"g" : @""};
    dic = [model yy_modelToJSONObject];
    
}

- (void)testDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:100000000];
    NSString *dateString = [formatter stringFromDate:date];
    
    YYTestModelToJSONModel *model = [YYTestModelToJSONModel new];
    model.date = date;
    
    NSDictionary *jsonObject = [model yy_modelToJSONObject];
    XCTAssert([jsonObject[@"date"] isEqual:dateString]);
    
    NSString *jsonString = [model yy_modelToJSONString];
    YYTestModelToJSONModel *newModel = [YYTestModelToJSONModel yy_modelWithJSON:jsonString];
    XCTAssert([newModel.date isEqualToDate:date]);
}

@end
