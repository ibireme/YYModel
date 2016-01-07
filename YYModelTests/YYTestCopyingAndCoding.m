//
//  YYTestCopyingAndCoding.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/11/29.
//  Copyright (c) 2015 ibireme.
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

@interface YYTestModelHashModel : NSObject <NSCopying, NSCoding>
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
@property CFArrayRef cfArrayValue;
@property NSValue *valueValue;

@property CGSize sizeValue;
@property CGPoint pointValue;
@property CGRect rectValue;
@property CGAffineTransform transformValue;
@property UIEdgeInsets insetsValue;
@property UIOffset offsetValue;
@property CATransform3D transform3DValue; // invalid for NSKeyedArchiver/Unarchiver
@property my_struct myStructValue;        // invalid for NSKeyedArchiver/Unarchiver



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

@implementation YYTestModelHashModel
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
@end




@interface YYTestEqualAndHash : XCTestCase

@end

@implementation YYTestEqualAndHash

- (void)testHash {
    YYTestModelHashModel *model1 = [YYTestModelHashModel new];
    YYTestModelHashModel *model2 = [YYTestModelHashModel new];
    
    XCTAssertTrue([model1 isEqual:model2]);
    
    model1.intValue = 1;
    XCTAssertFalse([model1 isEqual:model2]);
    
    model2.intValue = 1;
    XCTAssertTrue([model1 isEqual:model2]);
    
    model1.string = @"Apple";
    XCTAssertFalse([model1 isEqual:model2]);
    
    model2.string = @"Apple";
    XCTAssertTrue([model1 isEqual:model2]);
    
    my_struct my = {0};
    my.b = 12.34;
    
    model1.myStructValue = my;
    XCTAssertFalse([model1 isEqual:model2]);
    
    model2.myStructValue = my;
    XCTAssertTrue([model1 isEqual:model2]);
    
    model1.string = @"Apple";
    model1.string2 = @"Apple";
    model2.string = @"Steve Jobs";
    model2.string2 = @"Steve Jobs";
    XCTAssertTrue(model1.hash == model2.hash);
    XCTAssertFalse([model1 isEqual:model2]);
}

- (void)testCopying {
    YYTestModelHashModel *model1 = [YYTestModelHashModel new];
    YYTestModelHashModel *model2 = nil;
    
    model1.intValue = 1;
    model1.floatValue = 12.34;
    model1.myStructValue = (my_struct){.b = 56.78};
    model1.string = @"Apple";
    model2 = model1.copy;
    
    XCTAssertEqual(model1.intValue, model2.intValue);
    XCTAssertEqual(model1.floatValue, model2.floatValue);
    XCTAssertEqual(model1.myStructValue.b, model2.myStructValue.b);
    XCTAssertTrue([model1.string isEqualToString:model2.string]);
}

- (void)testCoding {
    NSData *data = nil;
    YYTestModelHashModel *model1 = [YYTestModelHashModel new];
    YYTestModelHashModel *model2 = nil;
    
    model1.intValue = 1;
    model1.floatValue = 12.34;
    model1.number = @(1234);
    model1.string = @"Apple";
    model1.sizeValue = CGSizeMake(12, 34);
    model1.selectorValue = @selector(stringWithFormat:);
    model1.myStructValue = (my_struct){.b = 56.78};
    model1.valueValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    data = [NSKeyedArchiver archivedDataWithRootObject:model1];
    model2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqual(model1.intValue, model2.intValue);
    XCTAssertEqual(model1.floatValue, model2.floatValue);
    XCTAssertTrue([model1.number isEqual:model2.number]);
    XCTAssertTrue([model1.string isEqualToString:model2.string]);
    XCTAssertTrue(CGSizeEqualToSize(model1.sizeValue, model2.sizeValue));
    XCTAssertTrue(model2.selectorValue == @selector(stringWithFormat:));
    XCTAssertTrue(model2.myStructValue.b == 0); // ignore in NSKeyedArchiver
    XCTAssertTrue(model2.valueValue == nil);    // ignore in NSKeyedArchiver
    
    // for code coverage
    NSArray *array = @[model1, model2];
    NSMutableData *mutableData = [NSMutableData new];
    NSKeyedArchiver *coder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [array yy_modelEncodeWithCoder:coder];
    [coder finishEncoding];
    XCTAssertTrue(mutableData.length > 0);
    
    mutableData = [NSMutableData new];
    coder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [[NSNull null] yy_modelEncodeWithCoder:coder];
    [coder finishEncoding];
    XCTAssertTrue(mutableData.length > 0);
}

@end
