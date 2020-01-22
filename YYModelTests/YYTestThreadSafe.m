//
//  YYTestThreadSafe.m
//  YYModelTests
//
//  Created by jufan wang on 2020/1/22.
//  Copyright © 2020 ibireme. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YYModel.h"
#import "YYTestHelper.h"


@interface YYTestThreadSafeModel : NSObject

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

@end


@implementation YYTestThreadSafeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"boolValue" : @"v",
              @"BOOLValue" : @"v",
              @"charValue" : @"v"
              };
}


@end





@interface YYTestThreadSafe : XCTestCase

@end

@implementation YYTestThreadSafe

- (void)testThreadSafe {
    NSString *json;
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];

    json = @"[{\"v\":1},{\"v\":2},{\"v\":3}]";
    [queue setSuspended:YES];
    for (int i = 0; i < 100; i++) {
        [queue addOperationWithBlock:^{
            NSArray *array = [NSArray yy_modelArrayWithClass:YYTestThreadSafeModel.class json:json];
            XCTAssertTrue(array.count == 3);
            XCTAssertTrue([array.firstObject isKindOfClass:[YYTestThreadSafeModel class]]);
        }];
        
    }
    [queue setSuspended:NO];
    sleep(200);
    for (int i = 0; i < 100; i++) {
        [queue addOperationWithBlock:^{
            NSArray *array = [NSArray yy_modelArrayWithClass:YYTestThreadSafeModel.class json:json];
            XCTAssertTrue(array.count == 3);
            XCTAssertTrue([array.firstObject isKindOfClass:[YYTestThreadSafeModel class]]);
        }];
        
    }
    sleep(200);
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
