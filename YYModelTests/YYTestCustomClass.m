//
//  YYTestCustomClass.m
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

@interface YYBaseUser : NSObject
@property uint64_t uid;
@property NSString *name;
@end


@interface YYLocalUser : YYBaseUser
@property NSString *localName;
@end
@implementation YYLocalUser
@end

@interface YYRemoteUser : YYBaseUser
@property NSString *remoteName;
@end
@implementation YYRemoteUser
@end


@implementation YYBaseUser
+ (Class)modelCustomClassForDictionary:(NSDictionary*)dictionary {
    if (dictionary[@"localName"]) {
        return [YYLocalUser class];
    } else if (dictionary[@"remoteName"]) {
        return [YYRemoteUser class];
    }
    return [YYBaseUser class];
}
@end

@interface YYTestCustomClassModel : NSObject
@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSDictionary *userDict;
@property (nonatomic, strong) NSSet *userSet;
@property (nonatomic, strong) YYBaseUser *user;
@property (nonatomic, strong) NSArray<NSURL *> *imageURLs;
@property (nonatomic, strong) NSArray<NSString *> *phones;
@property (nonatomic, strong) NSArray<NSMutableString *> *editPhones;
@property (nonatomic, strong) NSArray<NSNumber *> *scores;

@end

@implementation YYTestCustomClassModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"users" : YYBaseUser.class,
             @"userDict" : YYBaseUser.class,
             @"userSet" : YYBaseUser.class,
             @"imageURLs" : NSURL.class,
             @"phones" : NSString.class,
             @"editPhones" : NSMutableString.class,
             @"scores" : NSNumber.class,
             };
}
+ (Class)modelCustomClassForDictionary:(NSDictionary*)dictionary {
    if (dictionary[@"localName"]) {
        return [YYLocalUser class];
    } else if (dictionary[@"remoteName"]) {
        return [YYRemoteUser class];
    }
    return nil;
}
@end


@interface YYTestCustomClass : XCTestCase

@end

@implementation YYTestCustomClass

- (void)test {
    YYTestCustomClassModel *model;
    YYBaseUser *user;
    
    NSDictionary *jsonUserBase = @{@"uid" : @123, @"name" : @"Harry"};
    NSDictionary *jsonUserLocal = @{@"uid" : @123, @"name" : @"Harry", @"localName" : @"HarryLocal"};
    NSDictionary *jsonUserRemote = @{@"uid" : @123, @"name" : @"Harry", @"remoteName" : @"HarryRemote"};
    NSArray *jsonImageURLs = @[@"http://aaa.com", @"http://bbb.com", @""];
    NSArray *jsonPhones = @[@13000000001, @13000000002, @"13000000003"];
    NSArray *jsonScores = @[@"90", @"80", @"70"];
    
    user = [YYBaseUser yy_modelWithDictionary:jsonUserBase];
    XCTAssert([user isMemberOfClass:[YYBaseUser class]]);
    
    user = [YYBaseUser yy_modelWithDictionary:jsonUserLocal];
    XCTAssert([user isMemberOfClass:[YYLocalUser class]]);
    
    user = [YYBaseUser yy_modelWithDictionary:jsonUserRemote];
    XCTAssert([user isMemberOfClass:[YYRemoteUser class]]);
    
    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"imageURLs" : jsonImageURLs}];
    XCTAssert([model.imageURLs[0] isMemberOfClass:[NSURL class]]);
    
    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"phones" : jsonPhones}];
    XCTAssert([model.phones[0] isKindOfClass:[NSString class]]);

    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"editPhones" : jsonPhones}];
    XCTAssert([model.editPhones[0] isKindOfClass:[NSMutableString class]]);

    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"scores" : jsonScores}];
    XCTAssert([model.scores[0] isKindOfClass:[NSNumber class]]);

    
    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"user" : jsonUserLocal}];
    XCTAssert([model.user isMemberOfClass:[YYLocalUser class]]);
    
    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"users" : @[jsonUserBase, jsonUserLocal, jsonUserRemote]}];
    XCTAssert([model.users[0] isMemberOfClass:[YYBaseUser class]]);
    XCTAssert([model.users[1] isMemberOfClass:[YYLocalUser class]]);
    XCTAssert([model.users[2] isMemberOfClass:[YYRemoteUser class]]);
    
    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"userDict" : @{@"a" : jsonUserBase, @"b" : jsonUserLocal, @"c" : jsonUserRemote}}];
    XCTAssert([model.userDict[@"a"] isKindOfClass:[YYBaseUser class]]);
    XCTAssert([model.userDict[@"b"] isKindOfClass:[YYLocalUser class]]);
    XCTAssert([model.userDict[@"c"] isKindOfClass:[YYRemoteUser class]]);
    
    model = [YYTestCustomClassModel yy_modelWithJSON:@{@"userSet" : @[jsonUserBase, jsonUserLocal, jsonUserRemote]}];
    XCTAssert([model.userSet.anyObject isKindOfClass:[YYBaseUser class]]);
}

@end
