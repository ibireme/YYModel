//
//  ViewController.m
//  ModelBenchmark
//
//  Created by ibireme on 15/9/18.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "DateFormatter.h"
#import "GitHubUser.h"
#import "YYWeiboModel.h"
#import "FEWeiboModel.h"
#import "MTWeiboModel.h"
#import "JSWeiboModel.h"
#import "MJWeiboModel.h"
//#import "ModelBenchmark-Swift.h"

/*
 Benchmark: (update to 2016-01-15)
 YYModel: https://github.com/ibireme/YYKit
 Mantle: https://github.com/Mantle/Mantle
 JSONModel: https://github.com/icanzilb/JSONModel
 FastEasyMapping: https://github.com/Yalantis/FastEasyMapping
 MJExtension: https://github.com/CoderMJLee/MJExtension
 */
@implementation ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self benchmarkGithubUser];
        [self benchmarkWeiboStatus];
        
        [self testRobustness];
    });
}




- (void)benchmarkGithubUser {
    
    /// Benchmark swift .. too slow...
    /// [GithubUserBenchmark benchmark];
    
    
    printf("----------------------\n");
    printf("Benchmark (10000 times):\n");
    printf("GHUser          from json    to json    archive\n");

    /// get json data
    NSString *path = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    /// Benchmark
    int count = 10000;
    NSTimeInterval begin, end;
    
    /// warm up (NSDictionary's hot cache, and JSON to model framework cache)
    FEMMapping *mapping = [FEGHUser defaultMapping];
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTGHUser class]];
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            // Manually
            [[[[GHUser alloc] initWithJSONDictionary:json] description] length];
            
            // YYModel
            [YYGHUser yy_modelWithJSON:json];
            
            // FastEasyMapping
            [FEMDeserializer fillObject:[FEGHUser new] fromRepresentation:json mapping:mapping];
            
            // JSONModel
            [[[[JSGHUser alloc] initWithDictionary:json error:nil] description] length];
            
            // Mantle
            [adapter modelFromJSONDictionary:json error:nil];
            
            // MJExtension
            [MJGHUser mj_objectWithKeyValues:json];
        }
    }
    /// warm up holder
    NSMutableArray *holder = [NSMutableArray new];
    for (int i = 0; i < 1800; i++) {
        [holder addObject:[NSDate new]];
    }
    [holder removeAllObjects];
    
    /*------------------- Manually -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                GHUser *user = [[GHUser alloc] initWithJSONDictionary:json];
                [holder addObject:user];
            }
        }
        end = CACurrentMediaTime();
        printf("Manually:        %8.2f   ", (end - begin) * 1000);
        
        
        GHUser *user = [[GHUser alloc] initWithJSONDictionary:json];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user convertToJSONDictionary];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user convertToJSONDictionary]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    /*------------------- YYModel -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                YYGHUser *user = [YYGHUser yy_modelWithJSON:json];
                [holder addObject:user];
            }
        }
        end = CACurrentMediaTime();
        printf("YYModel:         %8.2f   ", (end - begin) * 1000);
        
        
        YYGHUser *user = [YYGHUser yy_modelWithJSON:json];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user yy_modelToJSONObject];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user yy_modelToJSONObject]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }

    
    /*------------------- FastEasyMapping -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                FEGHUser *user = [FEGHUser new];
                [FEMDeserializer fillObject:user fromRepresentation:json mapping:mapping];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("FastEasyMapping: %8.2f   ", (end - begin) * 1000);
        
        
        FEGHUser *user = [FEGHUser new];
        [FEMDeserializer fillObject:user fromRepresentation:json mapping:mapping];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [FEMSerializer serializeObject:user usingMapping:mapping];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject: [FEMSerializer serializeObject:user usingMapping:mapping]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        // FastEasyMapping does not support NSCoding?
        printf("     N/A\n");
    }

    /*------------------- JSONModel -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                JSGHUser *user = [[JSGHUser alloc] initWithDictionary:json error:nil];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("JSONModel:       %8.2f   ", (end - begin) * 1000);
        
        
        JSGHUser *user = [[JSGHUser alloc] initWithDictionary:json error:nil];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user toDictionary];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user toDictionary]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }

    /*------------------- Mantle -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                MTGHUser *user = [adapter modelFromJSONDictionary:json error:nil];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("Mantle:          %8.2f   ", (end - begin) * 1000);
        
        
        MTGHUser *user = [adapter modelFromJSONDictionary:json error:nil];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [adapter JSONDictionaryFromModel:user error:nil];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[adapter JSONDictionaryFromModel:user error:nil]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }

    /*------------------- MJExtension -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                MJGHUser *user = [MJGHUser mj_objectWithKeyValues:json];
                [user class];
            }
        }
        end = CACurrentMediaTime();
        printf("MJExtension:     %8.2f   ", (end - begin) * 1000);
        
        
        MJGHUser *user = [MJGHUser mj_objectWithKeyValues:json];
        if (user.userID == 0) NSLog(@"error!");
        if (!user.login) NSLog(@"error!");
        if (!user.htmlURL) NSLog(@"error");
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [user mj_JSONObject];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[user mj_JSONObject]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    printf("----------------------\n");
    printf("\n");
}

- (void)benchmarkWeiboStatus {
    printf("----------------------\n");
    printf("Benchmark (1000 times):\n");
    printf("WeiboStatus     from json    to json    archive\n");

    /// get json data
    NSString *path = [[NSBundle mainBundle] pathForResource:@"weibo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    

    
    /// Benchmark
    int count = 1000;
    NSTimeInterval begin, end;
    
    /// warm up (NSDictionary's hot cache, and JSON to model framework cache)
    FEMMapping *mapping = [FEWeiboStatus defaultMapping];
    MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTWeiboStatus class]];
    @autoreleasepool {
        for (int i = 0; i < count * 2; i++) {
            // YYModel
            [YYWeiboStatus yy_modelWithJSON:json];
            
            // FastEasyMapping
            [FEMDeserializer fillObject:[FEWeiboStatus new] fromRepresentation:json mapping:mapping];
            
            // JSONModel
            [[[JSWeiboStatus alloc] initWithDictionary:json error:nil] description];
            
            // Mantle
            [adapter modelFromJSONDictionary:json error:nil];
            
            // MJExtension
            [MJWeiboStatus mj_objectWithKeyValues:json];
        }
    }
    
    /// warm up holder
    NSMutableArray *holder = [NSMutableArray new];
    for (int i = 0; i < count; i++) {
        [holder addObject:[NSData new]];
    }
    [holder removeAllObjects];
    
    
    /*------------------- YYModel -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                YYWeiboStatus *feed = [YYWeiboStatus yy_modelWithJSON:json];
                [holder addObject:feed];
            }
        }
        end = CACurrentMediaTime();
        printf("YYModel:         %8.2f   ", (end - begin) * 1000);

        
        YYWeiboStatus *feed = [YYWeiboStatus yy_modelWithJSON:json];
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [feed yy_modelToJSONObject];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[feed yy_modelToJSONObject]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feed];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }

    /*------------------- FastEasyMapping -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                FEWeiboStatus *feed = [FEWeiboStatus new];
                [FEMDeserializer fillObject:feed fromRepresentation:json mapping:mapping];
                [holder addObject:feed];
            }
        }
        end = CACurrentMediaTime();
        printf("FastEasyMapping: %8.2f   ", (end - begin) * 1000);
        
        
        FEWeiboStatus *feed = [FEWeiboStatus new];
        [FEMDeserializer fillObject:feed fromRepresentation:json mapping:mapping];
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [FEMSerializer serializeObject:feed usingMapping:mapping];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject: [FEMSerializer serializeObject:feed usingMapping:mapping]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        // FastEasyMapping does not support NSCoding?
        printf("     N/A\n");
    }

    /*------------------- JSONModel -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                JSWeiboStatus *feed = [[JSWeiboStatus alloc] initWithDictionary:json error:nil];
                [holder addObject:feed];
            }
        }
        end = CACurrentMediaTime();
        printf("JSONModel:       %8.2f   ", (end - begin) * 1000);
        
        
        JSWeiboStatus *feed = [[JSWeiboStatus alloc] initWithDictionary:json error:nil];
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [feed toDictionary];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[feed toDictionary]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feed];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }

    /*------------------- Mantle -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                MTWeiboStatus *feed = [adapter modelFromJSONDictionary:json error:nil];
                [holder addObject:feed];
            }
        }
        end = CACurrentMediaTime();
        printf("Mantle:          %8.2f   ", (end - begin) * 1000);
        
        
        MTWeiboStatus *feed = [adapter modelFromJSONDictionary:json error:nil];
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [adapter JSONDictionaryFromModel:feed error:nil];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[adapter JSONDictionaryFromModel:feed error:nil]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feed];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }

    /*------------------- MJExtension -------------------*/
    {
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                MJWeiboStatus *feed = [MJWeiboStatus mj_objectWithKeyValues:json];
                [holder addObject:feed];
            }
        }
        end = CACurrentMediaTime();
        printf("MJExtension:     %8.2f   ", (end - begin) * 1000);
        
        
        MJWeiboStatus *feed = [MJWeiboStatus mj_objectWithKeyValues:json];
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSDictionary *json = [feed mj_JSONObject];
                [holder addObject:json];
            }
        }
        end = CACurrentMediaTime();
        if ([NSJSONSerialization isValidJSONObject:[feed mj_JSONObject]]) {
            printf("%8.2f   ", (end - begin) * 1000);
        } else {
            printf("   error   ");
        }
        
        [holder removeAllObjects];
        begin = CACurrentMediaTime();
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feed];
                [holder addObject:data];
            }
        }
        end = CACurrentMediaTime();
        printf("%8.2f\n", (end - begin) * 1000);
    }
    
    printf("----------------------\n");
    printf("\n");
}

- (void)testRobustness {
    
    {
        printf("----------------------\n");
        printf("The property is NSString, but the json value is number:\n");
        NSString *jsonStr = @"{\"type\":1}";
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        void (^logError)(NSString *model, id user) = ^(NSString *model, id user){
            printf("%s ",model.UTF8String);
            if (!user) {
                printf("⚠️ model is nil\n");
            } else {
                NSString *type = ((YYGHUser *)user).type;
                if (type == nil || type == (id)[NSNull null]) {
                    printf("⚠️ property is nil\n");
                } else if ([type isKindOfClass:[NSString class]]) {
                    printf("✅ property is %s\n",NSStringFromClass(type.class).UTF8String);
                } else {
                    printf("🚫 property is %s\n",NSStringFromClass(type.class).UTF8String);
                }
            }
        };
        
        // YYModel
        YYGHUser *yyUser = [YYGHUser yy_modelWithJSON:json];
        logError(@"YYModel:        ", yyUser);
        
        // FastEasyMapping
        FEGHUser *feUser = [FEGHUser new];
        FEMMapping *mapping = [FEGHUser defaultMapping];
        [FEMDeserializer fillObject:feUser fromRepresentation:json mapping:mapping];
        logError(@"FastEasyMapping:", feUser);
        
        // JSONModel
        JSGHUser *jsUser = [[JSGHUser alloc] initWithDictionary:json error:nil];
        logError(@"JSONModel:      ", jsUser);
        
        // Mantle
        MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTGHUser class]];
        MTGHUser *mtUser = [adapter modelFromJSONDictionary:json error:nil];
        logError(@"Mantle:         ", mtUser);
        
        // MJExtension
        MJGHUser *mjUser = [MJGHUser mj_objectWithKeyValues:json];
        logError(@"MJExtension:    ", mjUser);
        
        printf("\n");
    }
    
    {
        printf("----------------------\n");
        printf("The property is int, but the json value is string:\n");
        NSString *jsonStr = @"{\"followers\":\"100\"}";
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        void (^logError)(NSString *model, id user) = ^(NSString *model, id user){
            printf("%s ",model.UTF8String);
            if (!user) {
                printf("⚠️ model is nil\n");
            } else {
                UInt32 num = ((YYGHUser *)user).followers;
                if (num != 100) {
                    printf("🚫 property is %u\n",(unsigned int)num);
                } else {
                    printf("✅ property is %u\n",(unsigned int)num);
                }
            }
        };
        
        // YYModel
        YYGHUser *yyUser = [YYGHUser yy_modelWithJSON:json];
        logError(@"YYModel:        ", yyUser);
        
        // FastEasyMapping
        @try {
            FEGHUser *feUser = [FEGHUser new];
            FEMMapping *mapping = [FEGHUser defaultMapping];
            [FEMDeserializer fillObject:feUser fromRepresentation:json mapping:mapping];
            logError(@"FastEasyMapping:", feUser);
        }
        @catch (NSException *exception) {
            printf("FastEasyMapping: 🚫crash\n");
        }
        
        @try {
            // JSONModel
            JSGHUser *jsUser = [[JSGHUser alloc] initWithDictionary:json error:nil];
            logError(@"JSONModel:      ", jsUser);
            
        }
        @catch (NSException *exception) {
            printf("JSONModel:       🚫crash\n");
        }
        
        // Mantle
        MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTGHUser class]];
        MTGHUser *mtUser = [adapter modelFromJSONDictionary:json error:nil];
        logError(@"Mantle:         ", mtUser);
        
        // MJExtension
        MJGHUser *mjUser = [MJGHUser mj_objectWithKeyValues:json];
        logError(@"MJExtension:    ", mjUser);
    }
    
    
    {
        printf("----------------------\n");
        printf("The property is NSDate, and the json value is string:\n");
        NSString *jsonStr = @"{\"updated_at\":\"2009-04-02T03:35:22Z\"}";
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        void (^logError)(NSString *model, id user) = ^(NSString *model, id user){
            printf("%s ",model.UTF8String);
            if (!user) {
                printf("⚠️ model is nil\n");
            } else {
                NSDate *date = ((YYGHUser *)user).updatedAt;
                if (date == nil || date == (id)[NSNull null]) {
                    printf("⚠️ property is nil\n");
                } else if ([date isKindOfClass:[NSDate class]]) {
                    printf("✅ property is %s\n",NSStringFromClass(date.class).UTF8String);
                } else {
                    printf("🚫 property is %s\n",NSStringFromClass(date.class).UTF8String);
                }
            }
        };
        
        // YYModel
        YYGHUser *yyUser = [YYGHUser yy_modelWithJSON:json];
        logError(@"YYModel:        ", yyUser);
        
        // FastEasyMapping
        FEGHUser *feUser = [FEGHUser new];
        FEMMapping *mapping = [FEGHUser defaultMapping];
        [FEMDeserializer fillObject:feUser fromRepresentation:json mapping:mapping];
        logError(@"FastEasyMapping:", feUser);
        
        // JSONModel
        JSGHUser *jsUser = [[JSGHUser alloc] initWithDictionary:json error:nil];
        logError(@"JSONModel:      ", jsUser);
        
        // Mantle
        MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTGHUser class]];
        MTGHUser *mtUser = [adapter modelFromJSONDictionary:json error:nil];
        logError(@"Mantle:         ", mtUser);
        
        // MJExtension
        MJGHUser *mjUser = [MJGHUser mj_objectWithKeyValues:json];
        logError(@"MJExtension:    ", mjUser);
        
        printf("\n");
    }
    
    
    {
        printf("----------------------\n");
        printf("The property is NSValue, and the json value is string:\n");
        NSString *jsonStr = @"{\"test\":\"https://github.com\"}";
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        
        void (^logError)(NSString *model, id user) = ^(NSString *model, id user){
            printf("%s ",model.UTF8String);
            if (!user) {
                printf("⚠️ model is nil\n");
            } else {
                NSValue *valur = ((YYGHUser *)user).test;
                if (valur == nil || valur == (id)[NSNull null]) {
                    printf("✅ property is nil\n");
                } else if ([valur isKindOfClass:[NSURLRequest class]]) {
                    printf("✅ property is %s\n",NSStringFromClass(valur.class).UTF8String);
                } else {
                    printf("🚫 property is %s\n",NSStringFromClass(valur.class).UTF8String);
                }
            }
        };
        // YYModel
        YYGHUser *yyUser = [YYGHUser yy_modelWithJSON:json];
        logError(@"YYModel:        ", yyUser);
        
        // FastEasyMapping
        FEGHUser *feUser = [FEGHUser new];
        FEMMapping *mapping = [FEGHUser defaultMapping];
        [FEMDeserializer fillObject:feUser fromRepresentation:json mapping:mapping];
        logError(@"FastEasyMapping:", feUser);
        
        @try {
            // JSONModel
            JSGHUser *jsUser = [[JSGHUser alloc] initWithDictionary:json error:nil];
            logError(@"JSONModel:      ", jsUser);
        }
        @catch (NSException *exception) {
            printf("JSONModel:       🚫crash\n");
        }
        
        // Mantle
        MTLJSONAdapter *adapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTGHUser class]];
        MTGHUser *mtUser = [adapter modelFromJSONDictionary:json error:nil];
        logError(@"Mantle:         ", mtUser);
        
        // MJExtension
        MJGHUser *mjUser = [MJGHUser mj_objectWithKeyValues:json];
        logError(@"MJExtension:    ", mjUser);
        
        printf("\n");
    }
    
}

@end
