//
//  YYTestDescription.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 16/1/3.
//  Copyright (c) 2016 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <XCTest/XCTest.h>
#import "YYModel.h"


typedef struct my_struct {
    int a;
    double b;
    long double c;
} my_struct;

typedef struct my_union {
    int a;
    double b;
    long double c;
} my_union;



@interface YYTestDescriptionModel : NSObject
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
@property char *cString;
@property CFArrayRef cfArrayValue;
@property NSValue *valueValue;

@property CGSize sizeValue;
@property CGPoint pointValue;
@property CGRect rectValue;
@property CGAffineTransform transformValue;
@property UIEdgeInsets insetsValue;
@property UIOffset offsetValue;
@property my_struct myStructValue;        // invalid for NSKeyedArchiver/Unarchiver
@property my_union myUnionValue;        // invalid for NSKeyedArchiver/Unarchiver


@property (nonatomic, strong) NSObject *object;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDecimalNumber *decimal;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSString *string2;
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

@implementation YYTestDescriptionModel
- (NSString *)description {
    return [self yy_modelDescription];
}
@end




@interface YYTestDescription : XCTestCase

@end

@implementation YYTestDescription

- (void)testDescription {
    YYTestDescriptionModel *model = [YYTestDescriptionModel new];
    model.string = @"test";
    model.intValue = 100;
    
    model.number = @(123);
    model.decimal = [NSDecimalNumber decimalNumberWithString:@"456"];
    model.value = [NSValue valueWithRange:NSMakeRange(10, 5)];
    model.date = [NSDate new];
    model.blockValue = ^{};
    model.mData = [NSMutableData data];
    for (int i = 0; i < 1024; i++) {
        [model.mData appendBytes:&i length:sizeof(int)];
    }
    model.array = @[];
    model.dict = @{};
    model.set = [NSSet new];
    model.mArray = [NSMutableArray new];
    model.mDict = [NSMutableDictionary new];
    model.mSet = [NSMutableSet new];
    
    for (int i = 0; i < 2; i++) {
        YYTestDescriptionModel *sub = [YYTestDescriptionModel new];
        sub.intValue = i;
        [model.mArray addObject:sub];
        model.mDict[@(i).description] = sub;
        [model.mSet addObject:sub];
    }
    
    NSLog(@"%@",model.description);
}

@end
