//
//  YYTestAutoTypeConvert.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/11/28.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <XCTest/XCTest.h>
#import "YYModel.h"
#import "YYTestHelper.h"

@interface YYTestAutoTypeModel : NSObject
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

@property (nonatomic, strong) id anyObject;
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
@end

@implementation YYTestAutoTypeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"boolValue" : @"v",
              @"BOOLValue" : @"v",
              @"charValue" : @"v",
              @"unsignedCharValue" : @"v",
              @"shortValue" : @"v",
              @"unsignedShortValue" : @"v",
              @"intValue" : @"v",
              @"unsignedIntValue" : @"v",
              @"longValue" : @"v",
              @"unsignedLongValue" : @"v",
              @"longLongValue" : @"v",
              @"unsignedLongLongValue" : @"v",
              @"floatValue" : @"v",
              @"doubleValue" : @"v",
              @"longDoubleValue" : @"v",
              @"classValue" : @"v",
              @"selectorValue" : @"v",
              @"blockValue" : @"v",
              @"pointerValue" : @"v",
              @"structValue" : @"v",
              @"pointValue" : @"v",
              
              @"anyObject" : @"v",
              @"object" : @"v",
              @"number" : @"v",
              @"decimal" : @"v",
              @"string" : @"v",
              @"mString" : @"v",
              @"data" : @"v",
              @"mData" : @"v",
              @"date" : @"v",
              @"value" : @"v",
              @"url" : @"v",
              
              @"array" : @"v",
              @"mArray" : @"v",
              @"dict" : @"v",
              @"mDict" : @"v",
              @"set" : @"v",
              @"mSet" : @"v"
              };
}
@end





@interface YYTestAutoTypeConvert : XCTestCase

@end

@implementation YYTestAutoTypeConvert

- (void)testNumber {
    NSString *json;
    YYTestAutoTypeModel *model;
    
    json = @"{\"v\" : 1}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue);
    XCTAssert(model.BOOLValue);
    XCTAssert(model.charValue == 1);
    XCTAssert(model.unsignedCharValue == 1);
    XCTAssert(model.shortValue == 1);
    XCTAssert(model.unsignedShortValue == 1);
    XCTAssert(model.intValue == 1);
    XCTAssert(model.unsignedIntValue == 1);
    XCTAssert(model.longValue == 1);
    XCTAssert(model.unsignedLongValue == 1);
    XCTAssert(model.longLongValue == 1);
    XCTAssert(model.unsignedLongLongValue == 1);
    XCTAssert(model.floatValue == 1);
    XCTAssert(model.doubleValue == 1);
    XCTAssert(model.longDoubleValue == 1);
    XCTAssert([model.anyObject isEqual:@(1)]);
    XCTAssert([model.object isEqual:@(1)]);
    XCTAssert([model.number isEqual:@(1)]);
    XCTAssert([model.decimal isEqual:@(1)]);
    XCTAssert([model.string isEqualToString:@"1"]);
    XCTAssert([model.mString isEqualToString:@"1"]);
    XCTAssert([model.mString isKindOfClass:[NSMutableString class]]);
    XCTAssert(model.classValue == nil);
    XCTAssert(model.selectorValue == nil);
    XCTAssert(model.blockValue == nil);
    XCTAssert(model.pointerValue == nil);
    
    
    json = @"{\"v\" : 1.5}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue);
    XCTAssert(model.BOOLValue);
    XCTAssert(model.charValue == 1);
    XCTAssert(model.unsignedCharValue == 1);
    XCTAssert(model.shortValue == 1);
    XCTAssert(model.unsignedShortValue == 1);
    XCTAssert(model.intValue == 1);
    XCTAssert(model.unsignedIntValue == 1);
    XCTAssert(model.longValue == 1);
    XCTAssert(model.unsignedLongValue == 1);
    XCTAssert(model.longLongValue == 1);
    XCTAssert(model.unsignedLongLongValue == 1);
    XCTAssert(model.floatValue == 1.5);
    XCTAssert(model.doubleValue == 1.5);
    XCTAssert(model.longDoubleValue == 1.5);
    XCTAssert([model.anyObject isEqual:@(1.5)]);
    XCTAssert([model.object isEqual:@(1.5)]);
    XCTAssert([model.number isEqual:@(1.5)]);
    XCTAssert([model.decimal isEqual:@(1.5)]);
    XCTAssert([model.string isEqualToString:@"1.5"]);
    XCTAssert([model.mString isEqualToString:@"1.5"]);
    XCTAssert([model.mString isKindOfClass:[NSMutableString class]]);
    
    json = @"{\"v\" : -1}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue);
    XCTAssert(model.BOOLValue);
    XCTAssert(model.charValue == -1);
    XCTAssert(model.unsignedCharValue == (unsigned char)-1);
    XCTAssert(model.shortValue == -1);
    XCTAssert(model.unsignedShortValue == (unsigned short)-1);
    XCTAssert(model.intValue == -1);
    XCTAssert(model.unsignedIntValue == (unsigned int)-1);
    XCTAssert(model.longValue == -1);
    XCTAssert(model.unsignedLongValue == (unsigned long)-1);
    XCTAssert(model.longLongValue == -1);
    XCTAssert(model.unsignedLongLongValue == (unsigned long long)-1);
    XCTAssert(model.floatValue == -1);
    XCTAssert(model.doubleValue == -1);
    XCTAssert(model.longDoubleValue == -1);
    XCTAssert([model.anyObject isEqual:@(-1)]);
    XCTAssert([model.object isEqual:@(-1)]);
    XCTAssert([model.number isEqual:@(-1)]);
    XCTAssert([model.decimal isEqual:@(-1)]);
    XCTAssert([model.string isEqualToString:@"-1"]);
    XCTAssert([model.mString isEqualToString:@"-1"]);
    XCTAssert([model.mString isKindOfClass:[NSMutableString class]]);
    
    json = @"{\"v\" : \"2\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue);
    XCTAssert(model.BOOLValue);
    XCTAssert(model.charValue == 2);
    XCTAssert(model.unsignedCharValue == 2);
    XCTAssert(model.shortValue == 2);
    XCTAssert(model.unsignedShortValue == 2);
    XCTAssert(model.intValue == 2);
    XCTAssert(model.unsignedIntValue == 2);
    XCTAssert(model.longValue == 2);
    XCTAssert(model.unsignedLongValue == 2);
    XCTAssert(model.longLongValue == 2);
    XCTAssert(model.unsignedLongLongValue == 2);
    XCTAssert(model.floatValue == 2);
    XCTAssert(model.doubleValue == 2);
    XCTAssert(model.longDoubleValue == 2);
    XCTAssert([model.anyObject isEqual:@"2"]);
    XCTAssert([model.object isEqual:@"2"]);
    XCTAssert([model.number isEqual:@(2)]);
    XCTAssert([model.decimal isEqual:@(2)]);
    XCTAssert([model.string isEqualToString:@"2"]);
    XCTAssert([model.mString isEqualToString:@"2"]);
    XCTAssert([model.mString isKindOfClass:[NSMutableString class]]);
    
    model.intValue = 12;
    [model yy_modelSetWithJSON:json];
    XCTAssert(model.intValue == 2);
    
    json = @"{\"v\" : \"-3.2\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(fabs(model.floatValue + 3.2) < 0.0001);
    XCTAssert(fabs(model.doubleValue + 3.2) < 0.0001);
    XCTAssert(fabsl(model.longDoubleValue + 3.2) < 0.0001);
    XCTAssert([model.object isEqual:@"-3.2"]);
    XCTAssert([model.number isEqual:@(-3.2)]);
    XCTAssert([model.decimal isEqual:@(-3.2)]);
    XCTAssert([model.string isEqualToString:@"-3.2"]);
    XCTAssert([model.mString isEqualToString:@"-3.2"]);
    XCTAssert([model.mString isKindOfClass:[NSMutableString class]]);
    
    
    json = @"{\"v\" : \"true\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue);
    XCTAssert(model.intValue == 1);
    
    json = @"{\"v\" : \"false\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue == 0);
    XCTAssert(model.intValue == 0);
    
    json = @"{\"v\" : \"YES\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue);
    XCTAssert(model.intValue == 1);
    
    json = @"{\"v\" : \"NO\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue == 0);
    XCTAssert(model.intValue == 0);
    
    json = @"{\"v\" : \"nil\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue == 0);
    XCTAssert(model.intValue == 0);
    XCTAssert([model.string isEqual:@"nil"]);
    XCTAssert(model.number == nil);
    
    json = @"{\"v\" : {}}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert(model.boolValue == 0);
    XCTAssert(model.intValue == 0);
    XCTAssert(model.string == nil);
    XCTAssert(model.number == nil);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [NSDecimalNumber decimalNumberWithString:@"9876543210"]}];
    XCTAssert(model.unsignedLongLongValue == 9876543210LLU);
    XCTAssert(model.longLongValue == 9876543210LL);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [NSValue valueWithPointer:CFArrayCreate]}];
    XCTAssert(model.pointerValue == CFArrayCreate);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [NSURL class]}];
    XCTAssert(model.classValue == [NSURL class]);
    
    __block int  i = 0;
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : ^{i = 1;}}];
    model.blockValue();
    XCTAssert(i == 1);
}


- (void)testDate {
    NSString *json;
    YYTestAutoTypeModel *model;
    
    json = @"{\"v\" : \"2014-05-06\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
    
    json = @"{\"v\" : \"2014-05-06 07:08:09\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
    
    json = @"{\"v\" : \"2014-05-06T07:08:09\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
    
    json = @"{\"v\" : \"2014-01-20T12:24:48Z\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
    
    json = @"{\"v\" : \"2014-01-20T12:24:48+0800\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
    
    json = @"{\"v\" : \"2014-01-20T12:24:48+12:00\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
    
    json = @"{\"v\" : \"Fri Sep 04 00:12:21 +0800 2015\"}";
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [NSDate new]}];
    XCTAssert([model.date isKindOfClass:[NSDate class]]);
}

- (void)testString {
    NSDictionary *json;
    YYTestAutoTypeModel *model;
    
    json = @{@"v" : @"Apple"};
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssertTrue([model.string isEqualToString:@"Apple"]);
    
    json = @{@"v" : @" github.com"};
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssertTrue([model.url isEqual:[NSURL URLWithString:@"github.com"]]);
    
    json = @{@"v" : @"stringWithFormat:"};
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssertTrue(model.selectorValue == @selector(stringWithFormat:));
    
    json = @{@"v" : @"UILabel"};
    model = [YYTestAutoTypeModel yy_modelWithJSON:json];
    XCTAssertTrue(model.classValue == UILabel.class);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [@"haha" dataUsingEncoding:NSUTF8StringEncoding]}];
    XCTAssert([model.string isEqualToString:@"haha"]);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [NSURL URLWithString:@"https://github.com"]}];
    XCTAssert([model.string isEqualToString:@"https://github.com"]);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : @" "}];
    XCTAssert(model.url == nil);
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [[NSAttributedString alloc] initWithString:@"test"]}];
    XCTAssert([model.string isEqualToString:@"test"]);
}

- (void)testValue {
    NSValue *value;
    YYTestAutoTypeModel *model;
    
    value = [NSValue valueWithCGRect:CGRectMake(1, 2, 3, 4)];
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : value}];
    XCTAssertTrue(CGRectEqualToRect(model.structValue, CGRectMake(1, 2, 3, 4)));
    XCTAssertTrue(CGPointEqualToPoint(model.pointValue, CGPointZero));
    
    value = [NSValue valueWithCGPoint:CGPointMake(1, 2)];
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : value}];
    XCTAssertTrue(CGRectEqualToRect(model.structValue, CGRectZero));
    XCTAssertTrue(CGPointEqualToPoint(model.pointValue, CGPointMake(1, 2)));
}

- (void)testNull {
    YYTestAutoTypeModel *model;
    
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [NSNull null]}];
    XCTAssertTrue(model.boolValue == false);
    XCTAssertTrue(model.object == nil);
}

- (void)testBlock {
    int (^block)(void) = ^{return 12;};
    NSDictionary *dic = @{@"v":block};
    YYTestAutoTypeModel *model = [YYTestAutoTypeModel yy_modelWithDictionary:dic];
    XCTAssertNotNil(model.blockValue);
    
    block = (id)model.blockValue;
    XCTAssertTrue(block() == 12);
}

- (void)testArrayAndDic {
    NSString *json;
    
    json = @"[{\"v\":1},{\"v\":2},{\"v\":3}]";
    NSArray *array = [NSArray yy_modelArrayWithClass:YYTestAutoTypeModel.class json:json];
    XCTAssertTrue(array.count == 3);
    XCTAssertTrue([array.firstObject isKindOfClass:[YYTestAutoTypeModel class]]);
    
    array = [NSArray yy_modelArrayWithClass:YYTestAutoTypeModel.class json:[YYTestHelper jsonDataFromString:json]];
    XCTAssertTrue(array.count == 3);
    XCTAssertTrue([array.firstObject isKindOfClass:[YYTestAutoTypeModel class]]);
    
    array = [NSArray yy_modelArrayWithClass:YYTestAutoTypeModel.class json:[YYTestHelper jsonObjectFromString:json]];
    XCTAssertTrue(array.count == 3);
    XCTAssertTrue([array.firstObject isKindOfClass:[YYTestAutoTypeModel class]]);
    
    
    json = @"{\"a\":{\"v\":1},\"b\":{\"v\":2},\"c\":{\"v\":3}}";
    NSDictionary *dict = [NSDictionary yy_modelDictionaryWithClass:YYTestAutoTypeModel.class json:json];
    XCTAssertTrue(dict.count == 3);
    XCTAssertTrue([dict[@"a"] isKindOfClass:[YYTestAutoTypeModel class]]);
    
    json = @"{\"a\":{\"v\":1},\"b\":{\"v\":2},\"c\":{\"v\":3}}";
    dict = [NSDictionary yy_modelDictionaryWithClass:YYTestAutoTypeModel.class json:[YYTestHelper jsonDataFromString:json]];
    XCTAssertTrue(dict.count == 3);
    XCTAssertTrue([dict[@"a"] isKindOfClass:[YYTestAutoTypeModel class]]);
    
    json = @"{\"a\":{\"v\":1},\"b\":{\"v\":2},\"c\":{\"v\":3}}";
    dict = [NSDictionary yy_modelDictionaryWithClass:YYTestAutoTypeModel.class json:[YYTestHelper jsonObjectFromString:json]];
    XCTAssertTrue(dict.count == 3);
    XCTAssertTrue([dict[@"a"] isKindOfClass:[YYTestAutoTypeModel class]]);
    
    YYTestAutoTypeModel *model;
    model = [YYTestAutoTypeModel yy_modelWithJSON:@{@"v" : [NSSet setWithArray:@[@1,@2,@3]]}];
    XCTAssertTrue([model.array isKindOfClass:[NSArray class]]);
    XCTAssertTrue(model.array.count == 3);
}

@end
