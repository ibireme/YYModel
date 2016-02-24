//
//  YYTestNestModel.m
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


@interface YYTestNestUser : NSObject
@property uint64_t uid;
@property NSString *name;
@end
@implementation YYTestNestUser
@end

@interface YYTestNestRepo : NSObject
@property uint64_t repoID;
@property NSString *name;
@property YYTestNestUser *user;
@end
@implementation YYTestNestRepo
@end



@interface YYTestNestModel : XCTestCase

@end

@implementation YYTestNestModel

- (void)test {
    NSString *json = @"{\"repoID\":1234,\"name\":\"YYModel\",\"user\":{\"uid\":5678,\"name\":\"ibireme\"}}";
    YYTestNestRepo *repo = [YYTestNestRepo yy_modelWithJSON:json];
    XCTAssert(repo.repoID == 1234);
    XCTAssert([repo.name isEqualToString:@"YYModel"]);
    XCTAssert(repo.user.uid == 5678);
    XCTAssert([repo.user.name isEqualToString:@"ibireme"]);
    
    NSDictionary *jsonObject = [repo yy_modelToJSONObject];
    XCTAssert([((NSString *)jsonObject[@"name"]) isEqualToString:@"YYModel"]);
    XCTAssert([((NSString *)((NSDictionary *)jsonObject[@"user"])[@"name"]) isEqualToString:@"ibireme"]);
    
    [repo yy_modelSetWithJSON:@{@"name" : @"YYImage", @"user" : @{@"name": @"bot"}}];
    XCTAssert(repo.repoID == 1234);
    XCTAssert([repo.name isEqualToString:@"YYImage"]);
    XCTAssert(repo.user.uid == 5678);
    XCTAssert([repo.user.name isEqualToString:@"bot"]);
}

@end
