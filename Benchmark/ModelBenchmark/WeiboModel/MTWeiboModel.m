//
//  MTWeiboModel.m
//  ModelBenchmark
//
//  Created by ibireme on 15/9/18.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "MTWeiboModel.h"
#import "DateFormatter.h"

@implementation MTWeiboPictureMetadata
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"url" : @"url",
             @"width" : @"width",
             @"height" : @"height",
             @"type" : @"type",
             @"cutType" : @"cut_type"};
}
+ (NSValueTransformer *)widthJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *num, BOOL *success, NSError *__autoreleasing *error) {
        if ([num isKindOfClass:[NSString class]]) {
            num = @([((NSString *)num) integerValue]);
        }
        return num;
    } reverseBlock:^id(NSNumber *num, BOOL *success, NSError *__autoreleasing *error) {
        return num;
    }];
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:MTWeiboPicture.class];
}
+ (NSValueTransformer *)heightJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *num, BOOL *success, NSError *__autoreleasing *error) {
        if ([num isKindOfClass:[NSString class]]) {
            num = @([((NSString *)num) integerValue]);
        }
        return num;
    } reverseBlock:^id(NSNumber *num, BOOL *success, NSError *__autoreleasing *error) {
        return num;
    }];
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:MTWeiboPicture.class];
}
@end

@implementation MTWeiboPicture
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"picID" : @"pic_id",
             @"keepSize" : @"keep_size",
             @"photoTag" : @"photo_tag",
             @"objectID" : @"object_id",
             @"thumbnail" : @"thumbnail",
             @"bmiddle" : @"bmiddle",
             @"middlePlus" : @"middleplus",
             @"large" : @"large",
             @"largest" : @"largest",
             @"original" : @"original"};
}
@end

@implementation MTWeiboURL
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"result" : @"result",
             @"log" : @"log",
             @"oriURL" : @"ori_url",
             @"urlTitle" : @"url_title",
             @"urlTypePic" : @"url_type_pic",
             @"urlType" : @"url_type",
             @"shortURL" : @"short_url",
             @"actionLog" : @"actionlog",
             @"pageID" : @"page_id",
             @"storageType" : @"storage_type"};
}
@end

@implementation MTWeiboUser
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userID" : @"id",
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
             @"createdAt" : @"created_at",
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
             @"verifiedReasonModified" : @"verified_reason_modified"};
}
+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[DateFormatter weiboDataFormatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [[DateFormatter weiboDataFormatter] stringFromDate:date];
    }];
}
@end

@implementation MTWeiboStatus
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"statusID" : @"id",
             @"idstr" : @"idstr",
             @"mid" : @"mid",
             @"rid" : @"rid",
             @"createdAt" : @"created_at",
             @"user" : @"user",
             @"userType" : @"userType",
             @"text" : @"text",
             @"picIds" : @"pic_ids",
             @"picInfos" : @"pic_infos",
             @"urlStruct" : @"url_struct",
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
             @"darwinTags" : @"darwin_tags"};
}
+ (NSValueTransformer *)picInfosJSONTransformer {
    static MTLJSONAdapter *pictureAdapter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pictureAdapter = [[MTLJSONAdapter alloc] initWithModelClass:[MTWeiboPicture class]];
    });
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *dic, BOOL *success, NSError *__autoreleasing *error) {
        NSMutableDictionary *pics = [NSMutableDictionary new];
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            MTWeiboPicture *pic = [pictureAdapter modelFromJSONDictionary:obj error:nil];
            if (pic) pics[key] = pic;
        }];
        return pics;
    } reverseBlock:^id(NSDictionary *dic, BOOL *success, NSError *__autoreleasing *error) {
        NSMutableDictionary *ret = [NSMutableDictionary new];
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[MTWeiboPicture class]]) {
                NSDictionary *one = [pictureAdapter JSONDictionaryFromModel:obj error:nil];
                if (one) ret[key] = one;
            }
        }];
        return ret;
    }];
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:MTWeiboPicture.class];
}
+ (NSValueTransformer *)urlStructJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTWeiboURL.class];
}
+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[DateFormatter weiboDataFormatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [[DateFormatter weiboDataFormatter] stringFromDate:date];
    }];
}
@end

