//
//  FEWeiboModel.m
//  ModelBenchmark
//
//  Created by ibireme on 15/9/18.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "FEWeiboModel.h"
#import "FEMDeserializer.h"
#import "DateFormatter.h"
#import "FEMSerializer.h"

@implementation FEWeiboPictureMetadata
+ (FEMMapping *)defaultMapping {
    static FEMMapping *mapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      mapping = [[FEMMapping alloc] initWithEntityName:@"FEWeiboPictureMetadata"];
      [mapping addAttributesFromDictionary:@{
             @"url" : @"url",
             @"width" : @"width",
             @"height" : @"height",
             @"type" : @"type",
             @"cutType" : @"cut_type"
      }];

    });
    return mapping;
}
@end

@implementation FEWeiboPicture
+ (FEMMapping *)defaultMapping {
    static FEMMapping *mapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      mapping = [[FEMMapping alloc] initWithEntityName:@"FEWeiboPicture"];
      [mapping addAttributesFromDictionary:@{
         @"picID" : @"pic_id",
         @"keepSize" : @"keep_size",
         @"photoTag" : @"photo_tag",
         @"objectID" : @"object_id",
//         @"thumbnail" : @"thumbnail",
//         @"bmiddle" : @"bmiddle",
//         @"middlePlus" : @"middleplus",
//         @"large" : @"large",
//         @"largest" : @"largest",
//         @"original" : @"original"
      }];
        
        FEMMapBlock map = (id)^(NSDictionary *value) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                FEMMapping *mapping = [FEWeiboPictureMetadata defaultMapping];
                FEWeiboPictureMetadata *meta = [FEWeiboPictureMetadata new];
                [FEMDeserializer fillObject:meta fromRepresentation:value mapping:mapping];
                return meta;
            }
            return (FEWeiboPictureMetadata*)nil;
        };
        FEMMapBlock reverseMap = (id)^(NSDictionary *value) {
            if ([value isKindOfClass:[FEWeiboPictureMetadata class]]) {
                FEMMapping *mapping = [FEWeiboPictureMetadata defaultMapping];
                id meta = [FEMSerializer serializeObject:value usingMapping:mapping];
                return meta;
            }
            return (id)nil;
        };
        [mapping addAttribute:[[FEMAttribute alloc] initWithProperty:@"thumbnail" keyPath:@"thumbnail" map:map reverseMap:reverseMap]];
        [mapping addAttribute:[[FEMAttribute alloc] initWithProperty:@"bmiddle" keyPath:@"bmiddle" map:map reverseMap:reverseMap]];
        [mapping addAttribute:[[FEMAttribute alloc] initWithProperty:@"middlePlus" keyPath:@"middleplus" map:map reverseMap:reverseMap]];
        [mapping addAttribute:[[FEMAttribute alloc] initWithProperty:@"large" keyPath:@"large" map:map reverseMap:reverseMap]];
        [mapping addAttribute:[[FEMAttribute alloc] initWithProperty:@"largest" keyPath:@"largest" map:map reverseMap:reverseMap]];
        [mapping addAttribute:[[FEMAttribute alloc] initWithProperty:@"original" keyPath:@"original" map:map reverseMap:reverseMap]];
    });
    return mapping;
}
@end

@implementation FEWeiboURL
+ (FEMMapping *)defaultMapping {
    static FEMMapping *mapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      mapping = [[FEMMapping alloc] initWithEntityName:@"FEWeiboURL"];
      [mapping addAttributesFromDictionary:@{
         @"result" : @"result",
         @"log" : @"log",
         @"oriURL" : @"ori_url",
         @"urlTitle" : @"url_title",
         @"urlTypePic" : @"url_type_pic",
         @"urlType" : @"url_type",
         @"shortURL" : @"short_url",
         @"actionLog" : @"actionlog",
         @"pageID" : @"page_id",
         @"storageType" : @"storage_type"
      }];

    });
    return mapping;
}
@end

@implementation FEWeiboUser
+ (FEMMapping *)defaultMapping {
    static FEMMapping *mapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      mapping = [[FEMMapping alloc] initWithEntityName:@"FEWeiboUser"];
      [mapping addAttributesFromDictionary:@{
        @"userID" : @"id",
         @"idString" : @"idstr",
         @"genderString" : @"gender",
         @"desc" : @"description",
         @"domain" : @"domain",
         @"name" : @"name",
         @"screenName" : @"screen_name",
         @"remark" : @"remark",
         @"followersCount" : @"followers_count",
         @"friendsCount" : @"friends_count",
         @"biFollowersCount" : @"bi_followers_count",
         @"favouritesCount" : @"favourites_count",
         @"statusesCount" : @"statuses_count",
         @"pagefriendsCount" : @"pagefriends_count",
         @"followMe" : @"follow_me",
         @"following" : @"following",
         @"province" : @"province",
         @"city" : @"city",
         @"url" : @"url",
         @"profileImageURL" : @"profile_image_url",
         @"avatarLarge" : @"avatar_large",
         @"avatarHD" : @"avatar_hd",
         @"coverImage" : @"cover_image",
         @"coverImagePhone" : @"cover_image_phone",
         @"profileURL" : @"profile_url",
         @"type" : @"type",
         @"ptype" : @"ptype",
         @"mbtype" : @"mbtype",
         @"urank" : @"urank",
         @"uclass" : @"class",
         @"ulevel" : @"ulevel",
         @"mbrank" : @"mbrank",
         @"star" : @"star",
         @"level" : @"level",
         //@"createdAt" : @"created_at",
         @"allowAllActMsg" : @"allow_all_act_msg",
         @"allowAllComment" : @"allow_all_comment",
         @"geoEnabled" : @"geo_enabled",
         @"onlineStatus"  : @"online_status",
         @"location" : @"location",
         @"icons" : @"icons",
         @"weihao" : @"weihao",
         @"badgeTop" : @"badge_top",
         @"blockWord" : @"block_word",
         @"blockApp" : @"block_app",
         @"hasAbilityTag" : @"has_ability_tag",
         @"creditScore" : @"credit_score",
         @"badge" : @"badge",
         @"lang" : @"lang",
         @"userAbility" : @"user_ability",
         @"extend" : @"extend",
         @"verified" : @"verified",
         @"verifiedType" : @"verified_type",
         @"verifiedLevel" : @"verified_level",
         @"verifiedState" : @"verified_state",
         @"verifiedContactEmail" : @"verified_contact_email",
         @"verifiedContactMobile" : @"verified_contact_mobile",
         @"verifiedTrade" : @"verified_trade",
         @"verifiedContactName" : @"verified_contact_name",
         @"verifiedSource" : @"verified_source",
         @"verifiedSourceURL" : @"verified_source_url",
         @"verifiedReason" : @"verified_reason",
         @"verifiedReasonURL" : @"verified_reason_url",
         @"verifiedReasonModified" : @"verified_reason_modified"
      }];
      FEMAttribute *createdAt = [[FEMAttribute alloc] initWithProperty:@"createdAt" keyPath:@"created_at" map:(id)^(NSString *value) {
            if ([value isKindOfClass:[NSString class]]) {
                return [[DateFormatter weiboDataFormatter] dateFromString:value];
            }
            return (NSDate*)nil;
        } reverseMap:(id)^(id value) {
            if ([value isKindOfClass:[NSDate class]]) {
                return [[DateFormatter weiboDataFormatter] stringFromDate:value];
            }
            return (NSString *)[NSNull null];
        }];
        [mapping addAttribute:createdAt];
    });
    return mapping;
}
@end

@implementation FEWeiboStatus
+ (FEMMapping *)defaultMapping {
    static FEMMapping *mapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping = [[FEMMapping alloc] initWithEntityName:@"FEWeiboStatus"];
        [mapping addAttributesFromDictionary:@{
            @"statusID" : @"id",
            @"idstr" : @"idstr",
            @"mid" : @"mid",
            @"rid" : @"rid",
            //@"createdAt" : @"created_at",
            //@"user" : @"user",
            @"userType" : @"userType",
            @"text" : @"text",
            @"picIds" : @"pic_ids",
            //@"picInfos" : @"pic_infos",
            //@"urlStruct" : @"url_struct",
            @"favorited" : @"favorited",
            @"truncated" : @"truncated",
            @"repostsCount" : @"reposts_count",
            @"commentsCount" : @"comments_count",
            @"attitudesCount" : @"attitudes_count",
            @"attitudesStatus" : @"attitudes_status",
            @"recomState" : @"recom_state",
            @"inReplyToScreenName" : @"in_reply_to_screen_name",
            @"inReplyToStatusId" : @"in_reply_to_status_id",
            @"inReplyToUserId" : @"in_reply_to_user_id",
            @"source" : @"source",
            @"sourceType" : @"source_type",
            @"sourceAllowClick" : @"source_allowclick",
            @"geo" : @"geo",
            @"annotations" : @"annotations",
            @"bizFeature" : @"biz_feature",
            @"mblogid" : @"mblogid",
            @"mblogTypeName" : @"mblogtypename",
            @"mblogType" : @"mblogtype",
            @"scheme" : @"scheme",
            @"visible" : @"visible",
            @"darwinTags" : @"darwin_tags"
        }];

        FEMAttribute *createdAt = [[FEMAttribute alloc] initWithProperty:@"createdAt" keyPath:@"created_at" map:(id)^(NSString *value) {
            if ([value isKindOfClass:[NSString class]]) {
                return [[DateFormatter weiboDataFormatter] dateFromString:value];
            }
            return (NSDate*)nil;
        } reverseMap:(id)^(id value) {
            if ([value isKindOfClass:[NSDate class]]) {
                return [[DateFormatter weiboDataFormatter] stringFromDate:value];
            }
            return (NSString *)[NSNull null];
        }];
        [mapping addAttribute:createdAt];
        
        FEMAttribute *user = [[FEMAttribute alloc] initWithProperty:@"user" keyPath:@"user" map:(id)^(NSDictionary *value) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                FEMMapping *mapping = [FEWeiboUser defaultMapping];
                FEWeiboUser *user = [FEWeiboUser new];
                [FEMDeserializer fillObject:user fromRepresentation:value mapping:mapping];
                return user;
            }
            return (FEWeiboUser*)nil;
        } reverseMap:(id)^(FEWeiboUser *value) {
            if ([value isKindOfClass:[FEWeiboUser class]]) {
                FEMMapping *mapping = [FEWeiboUser defaultMapping];
                id user = [FEMSerializer serializeObject:value usingMapping:mapping];
                return user;
            }
            return (id)nil;
        }];
        [mapping addAttribute:user];
        
        FEMAttribute *picInfos = [[FEMAttribute alloc] initWithProperty:@"picInfos" keyPath:@"pic_infos" map:(id)^(NSDictionary *value) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                NSMutableDictionary *infos = [NSMutableDictionary new];
                FEMMapping *picMapping = [FEWeiboPicture defaultMapping];
                [value enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    FEWeiboPicture *pic = [FEWeiboPicture new];
                    [FEMDeserializer fillObject:pic fromRepresentation:obj mapping:picMapping];
                    infos[key] = pic;
                }];
                return (id)infos;
            }
            return (id)nil;
        } reverseMap:(id) ^ (NSDictionary *value) {
            FEMMapping *picMapping = [FEWeiboPicture defaultMapping];
            NSMutableDictionary *infos = [NSMutableDictionary new];
            [value enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                id pic = [FEMSerializer serializeObject:obj usingMapping:picMapping];
                if (pic) infos[key] = pic;
            }];
            return infos;
        }];
        [mapping addAttribute:picInfos];
        
        FEMAttribute *urlStruct = [[FEMAttribute alloc] initWithProperty:@"urlStruct" keyPath:@"url_struct" map:(id)^(NSArray *value) {
            if ([value isKindOfClass:[NSArray class]]) {
                NSMutableArray *urls = [NSMutableArray new];
                FEMMapping *picMapping = [FEWeiboURL defaultMapping];
                [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    FEWeiboURL *url = [FEWeiboURL new];
                    [FEMDeserializer fillObject:url fromRepresentation:obj mapping:picMapping];
                    [urls addObject:url];
                }];
                return (id)urls;
            }
            return (id)nil;
        } reverseMap:(id) ^ (NSArray *value) {
            FEMMapping *picMapping = [FEWeiboURL defaultMapping];
            NSMutableArray *urls = [NSMutableArray new];
            [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                id url = [FEMSerializer serializeObject:obj usingMapping:picMapping];
                if (url) [urls addObject:url];
            }];
            return urls;
        }];
        [mapping addAttribute:urlStruct];
        
    });
    return mapping;
}

@end