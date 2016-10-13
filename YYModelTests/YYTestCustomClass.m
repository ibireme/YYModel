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
@end

@implementation YYTestCustomClassModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"users" : YYBaseUser.class,
             @"userDict" : YYBaseUser.class,
             @"userSet" : YYBaseUser.class};
}
//+ (Class)modelCustomClassForDictionary:(NSDictionary*)dictionary {
//    if (dictionary[@"localName"]) {
//        return [YYLocalUser class];
//    } else if (dictionary[@"remoteName"]) {
//        return [YYRemoteUser class];
//    }
//    return nil;
//}
@end






@interface Shape : NSObject
@property (nonatomic, strong) NSString *name;
@end

@interface Circle : Shape

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat radius;

@end

@interface Square : Shape
@property (nonatomic) CGFloat side;
@end




@implementation Shape

+ (Class)modelCustomClassForDictionary:(NSDictionary*)dictionary {
    if ([dictionary[@"name"] isEqualToString:@"Circle"]) {
        return [Circle class];
    } else if ([dictionary[@"name"] isEqualToString:@"Square"]) {
        return [Square class];
    }
    return self;
}

- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dictionary{
    NSString *name = dictionary[@"name"];
    if([name isEqualToString:@"Circle"] || [name isEqualToString:@"Square"]){
        return dictionary;
    }
    NSLog(@"unrecognized shape");
    return nil;
}
@end

@implementation Circle

@end

@implementation Square

@end



@interface YYTestCustomShapeModel : NSObject
@property (nonatomic, strong) NSArray *shapes;
@property (nonatomic, strong) NSDictionary *shapesDict;
@property (nonatomic, strong) NSSet *shapesSet;
@property (nonatomic, strong) Shape *shape;
@end

@implementation YYTestCustomShapeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"shapes" : Shape.class,
             @"shapesDict" : Shape.class,
             @"shapesSet" : Shape.class};
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
    
    user = [YYBaseUser yy_modelWithDictionary:jsonUserBase];
    XCTAssert([user isMemberOfClass:[YYBaseUser class]]);
    
    user = [YYBaseUser yy_modelWithDictionary:jsonUserLocal];
    XCTAssert([user isMemberOfClass:[YYLocalUser class]]);
    
    user = [YYBaseUser yy_modelWithDictionary:jsonUserRemote];
    XCTAssert([user isMemberOfClass:[YYRemoteUser class]]);
    
    
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

- (void)testUnrecognizedShape {
    NSDictionary *unrecognizedShapeDic = @{@"name" : @"unrecognizedShape"};
    NSDictionary *squareDic = @{@"name" : @"Square", @"side":@99};
    NSDictionary *circleDic = @{@"name" : @"Circle", @"radius":@11};
    
    
    YYTestCustomShapeModel *model;
    Shape *shape;
    shape = [Shape yy_modelWithJSON:unrecognizedShapeDic];
    XCTAssert(shape == nil);
    
    model = [YYTestCustomShapeModel yy_modelWithJSON:@{@"shapes" : @[unrecognizedShapeDic, squareDic, circleDic]}];
    XCTAssert(model.shapes.count == 2);
    XCTAssert([model.shapes[0] isMemberOfClass:[Square class]]);
    XCTAssert([model.shapes[1] isMemberOfClass:[Circle class]]);
    
    model = [YYTestCustomShapeModel yy_modelWithJSON:@{@"shapesDict" : @{@"a" : unrecognizedShapeDic, @"b" : squareDic, @"c": circleDic}}];
    XCTAssert(model.shapesDict.count == 2);
    XCTAssert(model.shapesDict[@"a"] == nil);
    XCTAssert([model.shapesDict[@"b"] isMemberOfClass:[Square class]]);
    XCTAssert([model.shapesDict[@"c"] isMemberOfClass:[Circle class]]);
    
    model = [YYTestCustomShapeModel yy_modelWithJSON:@{@"shapesSet" : @[unrecognizedShapeDic, squareDic, circleDic]}];
    XCTAssert(model.shapesSet.count == 2);
//    XCTAssert([model.shapesSet[0] isMemberOfClass:[Square class]]);
//    XCTAssert([model.shapesSet[1] isMemberOfClass:[Circle class]]);
    
    model = [YYTestCustomShapeModel yy_modelWithJSON:@{@"shape" : unrecognizedShapeDic,}];
    XCTAssert(model.shape == nil);
}

@end
