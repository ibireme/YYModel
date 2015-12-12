//
//  YYTestModelMapper.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/11/27.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <XCTest/XCTest.h>
#import "YYModel.h"


@interface YYTestPropertyMapperModelAuto : NSObject
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSNumber *count;
@end

@implementation YYTestPropertyMapperModelAuto
@end

@interface YYTestPropertyMapperModelCustom : NSObject
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSNumber *count;
@property (nonatomic, assign) NSString *desc1;
@property (nonatomic, assign) NSString *desc2;
@property (nonatomic, assign) NSString *desc3;
@property (nonatomic, assign) NSString *desc4;
@property (nonatomic, assign) NSString *modelID;
@end

@implementation YYTestPropertyMapperModelCustom
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"name" : @"n",
              @"count" : @"ext.c",
              @"desc1" : @"ext.d", // mapped to same key path
              @"desc2" : @"ext.d", // mapped to same key path
              @"desc3" : @"ext.d.e",
              @"desc4" : @".ext",
              @"modelID" : @[@"ID", @"Id", @"id", @"ext.id"]};
}
@end

@interface YYTestPropertyMapperModelWarn : NSObject {
    NSString *_description;
}
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *id;
@end

@implementation YYTestPropertyMapperModelWarn
@synthesize description = _description;
@end


@interface YYTestPropertyMapperModelContainer : NSObject
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSMutableDictionary *mDict;
@property (nonatomic, strong) NSSet *set;
@property (nonatomic, strong) NSMutableSet *mSet;
@end

@implementation YYTestPropertyMapperModelContainer
@end

@interface YYTestPropertyMapperModelContainerGeneric : YYTestPropertyMapperModelContainer
@end

@implementation YYTestPropertyMapperModelContainerGeneric
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"mArray" : @"array",
              @"mDict" : @"dict",
              @"mSet" : @"set"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array" : YYTestPropertyMapperModelAuto.class,
             @"mArray" : YYTestPropertyMapperModelAuto.class,
             @"dict" : YYTestPropertyMapperModelAuto.class,
             @"mDict" : YYTestPropertyMapperModelAuto.class,
             @"set" : @"YYTestPropertyMapperModelAuto",
             @"mSet" : @"YYTestPropertyMapperModelAuto"};
}
@end



@interface YYTestModelPropertyMapper : XCTestCase

@end

@implementation YYTestModelPropertyMapper

- (void)testAuto {
    NSString *json;
    YYTestPropertyMapperModelAuto *model;
    
    json = @"{\"name\":\"Apple\",\"count\":12}";
    model = [YYTestPropertyMapperModelAuto yy_modelWithJSON:json];
    XCTAssertTrue([model.name isEqualToString:@"Apple"]);
    XCTAssertTrue([model.count isEqual:@12]);
    
    json = @"{\"n\":\"Apple\",\"count\":12, \"description\":\"hehe\"}";
    model = [YYTestPropertyMapperModelAuto yy_modelWithJSON:json];
    XCTAssertTrue(model.name == nil);
    XCTAssertTrue([model.count isEqual:@12]);
}

- (void)testCustom {
    NSString *json;
    NSDictionary *jsonObject;
    YYTestPropertyMapperModelCustom *model;
    
    json = @"{\"n\":\"Apple\",\"ext\":{\"c\":12}}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue([model.name isEqualToString:@"Apple"]);
    XCTAssertTrue([model.count isEqual:@12]);
    
    json = @"{\"n\":\"Apple\",\"count\":12}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue(model.count == nil);
    
    json = @"{\"n\":\"Apple\",\"ext\":12}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue(model.count == nil);
    
    json = @"{\"n\":\"Apple\",\"ext\":@{}}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue(model.count == nil);
    
    json = @"{\"ext\":{\"d\":\"Apple\"}}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue([model.desc1 isEqualToString:@"Apple"]);
    XCTAssertTrue([model.desc2 isEqualToString:@"Apple"]);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue([((NSDictionary *)jsonObject[@"ext"])[@"d"] isEqualToString:@"Apple"]);
    
    json = @"{\"ext\":{\"d\":{ \"e\" : \"Apple\"}}}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue([model.desc3 isEqualToString:@"Apple"]);
    
    json = @"{\".ext\":\"Apple\"}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue([model.desc4 isEqualToString:@"Apple"]);
    
    json = @"{\"id\":\"abcd\"}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue([model.modelID isEqualToString:@"abcd"]);
    
    json = @"{\"ext\":{\"id\":\"abcd\"}}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue([model.modelID isEqualToString:@"abcd"]);
    
    json = @"{\"id\":\"abcd\",\"ID\":\"ABCD\",\"Id\":\"Abcd\"}";
    model = [YYTestPropertyMapperModelCustom yy_modelWithJSON:json];
    XCTAssertTrue([model.modelID isEqualToString:@"ABCD"]);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue(jsonObject[@"id"] == nil);
    XCTAssertTrue([jsonObject[@"ID"] isEqualToString:@"ABCD"]);
}

- (void)testWarn {
    NSString *json = @"{\"description\":\"Apple\",\"id\":12345}";
    YYTestPropertyMapperModelWarn *model = [YYTestPropertyMapperModelWarn yy_modelWithJSON:json];
    XCTAssertTrue([model.description isEqualToString:@"Apple"]);
    XCTAssertTrue([model.id isEqual:@12345]);
}

- (void)testContainer {
    NSString *json;
    NSDictionary *jsonObject = nil;
    YYTestPropertyMapperModelContainer *model;
    
    json = @"{\"array\":[\n  {\"name\":\"Apple\", \"count\":10},\n  {\"name\":\"Banana\", \"count\":11},\n  {\"name\":\"Pear\", \"count\":12},\n  null\n]}";
    
    model = [YYTestPropertyMapperModelContainer yy_modelWithJSON:json];
    XCTAssertTrue([model.array isKindOfClass:[NSArray class]]);
    XCTAssertTrue(model.array.count == 4);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue([jsonObject[@"array"] isKindOfClass:[NSArray class]]);
    
    model = [YYTestPropertyMapperModelContainerGeneric yy_modelWithJSON:json];
    XCTAssertTrue([model.array isKindOfClass:[NSArray class]]);
    XCTAssertTrue(model.array.count == 3);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.array[0]).name isEqualToString:@"Apple"]);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.array[0]).count isEqual:@10]);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.array[2]).name isEqualToString:@"Pear"]);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.array[2]).count isEqual:@12]);
    XCTAssertTrue([model.mArray isKindOfClass:[NSMutableArray class]]);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue([jsonObject[@"array"] isKindOfClass:[NSArray class]]);
    
    json = @"{\"dict\":{\n  \"A\":{\"name\":\"Apple\", \"count\":10},\n  \"B\":{\"name\":\"Banana\", \"count\":11},\n  \"P\":{\"name\":\"Pear\", \"count\":12},\n  \"N\":null\n}}";
    
    model = [YYTestPropertyMapperModelContainer yy_modelWithJSON:json];
    XCTAssertTrue([model.dict isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue(model.dict.count == 4);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue(jsonObject != nil);
    
    model = [YYTestPropertyMapperModelContainerGeneric yy_modelWithJSON:json];
    XCTAssertTrue([model.dict isKindOfClass:[NSDictionary class]]);
    XCTAssertTrue(model.dict.count == 3);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.dict[@"A"]).name isEqualToString:@"Apple"]);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.dict[@"A"]).count isEqual:@10]);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.dict[@"P"]).name isEqualToString:@"Pear"]);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.dict[@"P"]).count isEqual:@12]);
    XCTAssertTrue([model.mDict isKindOfClass:[NSMutableDictionary class]]);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue(jsonObject != nil);
    
    json = @"{\"set\":[\n  {\"name\":\"Apple\", \"count\":10},\n  {\"name\":\"Banana\", \"count\":11},\n  {\"name\":\"Pear\", \"count\":12},\n  null\n]}";
    
    model = [YYTestPropertyMapperModelContainer yy_modelWithJSON:json];
    XCTAssertTrue([model.set isKindOfClass:[NSSet class]]);
    XCTAssertTrue(model.set.count == 4);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue(jsonObject != nil);
    
    model = [YYTestPropertyMapperModelContainerGeneric yy_modelWithJSON:json];
    XCTAssertTrue([model.set isKindOfClass:[NSSet class]]);
    XCTAssertTrue(model.set.count == 3);
    XCTAssertTrue([((YYTestPropertyMapperModelAuto *)model.set.anyObject).name isKindOfClass:[NSString class]]);
    XCTAssertTrue([model.mSet isKindOfClass:[NSMutableSet class]]);
    
    jsonObject = [model yy_modelToJSONObject];
    XCTAssertTrue(jsonObject != nil);
    
    model = [YYTestPropertyMapperModelContainerGeneric yy_modelWithJSON:@{@"set" : @[[YYTestPropertyMapperModelAuto new]]}];
    XCTAssertTrue([model.set isKindOfClass:[NSSet class]]);
    XCTAssertTrue([[model.set anyObject] isKindOfClass:[YYTestPropertyMapperModelAuto class]]);
    
    model = [YYTestPropertyMapperModelContainerGeneric yy_modelWithJSON:@{@"array" : [NSSet setWithArray:@[[YYTestPropertyMapperModelAuto new]]]}];
    XCTAssertTrue([model.array isKindOfClass:[NSArray class]]);
    XCTAssertTrue([[model.array firstObject] isKindOfClass:[YYTestPropertyMapperModelAuto class]]);
    
    model = [YYTestPropertyMapperModelContainer yy_modelWithJSON:@{@"mArray" : @[[YYTestPropertyMapperModelAuto new]]}];
    XCTAssertTrue([model.mArray isKindOfClass:[NSMutableArray class]]);
    XCTAssertTrue([[model.mArray firstObject] isKindOfClass:[YYTestPropertyMapperModelAuto class]]);
    
    model = [YYTestPropertyMapperModelContainer yy_modelWithJSON:@{@"mArray" : [NSSet setWithArray:@[[YYTestPropertyMapperModelAuto new]]]}];
    XCTAssertTrue([model.mArray isKindOfClass:[NSMutableArray class]]);
    XCTAssertTrue([[model.mArray firstObject] isKindOfClass:[YYTestPropertyMapperModelAuto class]]);
}

@end
