//
//  YYTestBlacklistWhitelist.m
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


@interface YYTestBlacklistModel : NSObject
@property (nonatomic, strong) NSString *a;
@property (nonatomic, strong) NSString *b;
@property (nonatomic, strong) NSString *c;
@end

@implementation YYTestBlacklistModel
+ (NSArray *)modelPropertyBlacklist {
    return @[@"a", @"d"];
}
@end

@interface YYTestWhitelistModel : NSObject
@property (nonatomic, strong) NSString *a;
@property (nonatomic, strong) NSString *b;
@property (nonatomic, strong) NSString *c;
@end

@implementation YYTestWhitelistModel
+ (NSArray *)modelPropertyWhitelist {
    return @[@"a", @"d"];
}
@end


@interface YYTestBlackWhitelistModel : NSObject
@property (nonatomic, strong) NSString *a;
@property (nonatomic, strong) NSString *b;
@property (nonatomic, strong) NSString *c;
@end

@implementation YYTestBlackWhitelistModel
+ (NSArray *)modelPropertyBlacklist {
    return @[@"a", @"d"];
}
+ (NSArray *)modelPropertyWhitelist {
    return @[@"a", @"b", @"d"];
}
@end




@interface YYTestBlacklistWhitelist : XCTestCase

@end

@implementation YYTestBlacklistWhitelist

- (void)testBlacklist {
    NSString *json = @"{\"a\":\"A\", \"b\":\"B\", \"c\":\"C\", \"d\":\"D\"}";
    YYTestBlacklistModel *model = [YYTestBlacklistModel yy_modelWithJSON:json];
    XCTAssert(model.a == nil);
    XCTAssert(model.b != nil);
    XCTAssert(model.c != nil);
    
    NSDictionary *dic = [model yy_modelToJSONObject];
    XCTAssert(dic[@"a"] == nil);
    XCTAssert(dic[@"b"] != nil);
    XCTAssert(dic[@"c"] != nil);
}

- (void)testWhitelist {
    NSString *json = @"{\"a\":\"A\", \"b\":\"B\", \"c\":\"C\", \"d\":\"D\"}";
    YYTestWhitelistModel *model = [YYTestWhitelistModel yy_modelWithJSON:json];
    XCTAssert(model.a != nil);
    XCTAssert(model.b == nil);
    XCTAssert(model.c == nil);
    
    NSDictionary *dic = [model yy_modelToJSONObject];
    XCTAssert(dic[@"a"] != nil);
    XCTAssert(dic[@"b"] == nil);
    XCTAssert(dic[@"c"] == nil);
}


- (void)testBlackWhitelist {
    NSString *json = @"{\"a\":\"A\", \"b\":\"B\", \"c\":\"C\", \"d\":\"D\"}";
    YYTestBlackWhitelistModel *model = [YYTestBlackWhitelistModel yy_modelWithJSON:json];
    XCTAssert(model.a == nil);
    XCTAssert(model.b != nil);
    XCTAssert(model.c == nil);
    
    NSDictionary *dic = [model yy_modelToJSONObject];
    XCTAssert(dic[@"a"] == nil);
    XCTAssert(dic[@"b"] != nil);
    XCTAssert(dic[@"c"] == nil);
}

@end
