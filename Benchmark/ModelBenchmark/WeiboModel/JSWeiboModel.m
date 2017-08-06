//
//  JSWeiboModel.m
//  ModelBenchmark
//
//  Created by ibireme on 15/9/18.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "JSWeiboModel.h"
#import "DateFormatter.h"

@implementation JSWeiboPictureMetadata
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"cut_type" : @"cutType" }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboPicture
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
             @"url" : @"url",
             @"width" : @"width",
             @"height" : @"height",
             @"type" : @"type",
             @"cutType" : @"cut_type"
    }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboURL
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
             @"oriURL" : @"ori_url",
             @"urlTitle" : @"url_title",
             @"urlTypePic" : @"url_type_pic",
             @"urlType" : @"url_type",
             @"shortURL" : @"short_url",
             @"actionLog" : @"actionlog",
             @"pageID" : @"page_id",
             @"storageType" : @"storage_type"
    }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboUser
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
             @"userID" : @"id",
             @"idString" : @"idstr",
             @"genderString" : @"gender",
             @"biFollowersCount" : @"bi_followers_count",
             @"profileImageURL" : @"profile_image_url",
             @"uclass" : @"class",
             @"verifiedContactEmail" : @"verified_contact_email",
             @"statusesCount" : @"statuses_count",
             @"geoEnabled" : @"geo_enabled",
             @"followMe" : @"follow_me",
             @"coverImagePhone" : @"cover_image_phone",
             @"desc" : @"description",
             @"followersCount" : @"followers_count",
             @"verifiedContactMobile" : @"verified_contact_mobile",
             @"avatarLarge" : @"avatar_large",
             @"verifiedTrade" : @"verified_trade",
             @"profileURL" : @"profile_url",
             @"coverImage" : @"cover_image",
             @"onlineStatus"  : @"online_status",
             @"badgeTop" : @"badge_top",
             @"verifiedContactName" : @"verified_contact_name",
             @"screenName" : @"screen_name",
             @"verifiedSourceURL" : @"verified_source_url",
             @"pagefriendsCount" : @"pagefriends_count",
             @"verifiedReason" : @"verified_reason",
             @"friendsCount" : @"friends_count",
             @"blockApp" : @"block_app",
             @"hasAbilityTag" : @"has_ability_tag",
             @"avatarHD" : @"avatar_hd",
             @"creditScore" : @"credit_score",
             @"createdAt" : @"created_at",
             @"blockWord" : @"block_word",
             @"allowAllActMsg" : @"allow_all_act_msg",
             @"verifiedState" : @"verified_state",
             @"verifiedReasonModified" : @"verified_reason_modified",
             @"allowAllComment" : @"allow_all_comment",
             @"verifiedLevel" : @"verified_level",
             @"verifiedReasonURL" : @"verified_reason_url",
             @"favouritesCount" : @"favourites_count",
             @"verifiedType" : @"verified_type",
             @"verifiedSource" : @"verified_source",
             @"userAbility" : @"user_ability"}];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboStatus
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
         @"statusID" : @"id",
         @"createdAt" : @"created_at",
         @"attitudesStatus" : @"attitudes_status",
         @"inReplyToScreenName" : @"in_reply_to_screen_name",
         @"sourceType" : @"source_type",
         @"commentsCount" : @"comments_count",
         @"urlStruct" : @"url_struct",
         @"recomState" : @"recom_state",
         @"sourceAllowClick" : @"source_allowclick",
         @"bizFeature" : @"biz_feature",
         @"mblogTypeName" : @"mblogtypename",
         @"mblogType" : @"mblogtype",
         @"inReplyToStatusId" : @"in_reply_to_status_id",
         @"picIds" : @"pic_ids",
         @"repostsCount" : @"reposts_count",
         @"attitudesCount" : @"attitudes_count",
         @"darwinTags" : @"darwin_tags",
         @"userType" : @"userType",
         @"picInfos" : @"pic_infos",
         @"inReplyToUserId" : @"in_reply_to_user_id"
    }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end





/**
 JSONModel use a global transformer to transform value...
 But how to create a custom transformer for a specified model ?!!!!
 */
@interface JSONValueTransformer(CustomDate)
-(NSDate*)__NSDateFromNSString:(NSString*)string;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation JSONValueTransformer (CustomDate)
- (NSDate *)NSDateFromNSString:(NSString *)string {
    if (string.length == 30) {
        return [[DateFormatter weiboDataFormatter] dateFromString:string];
    } else {
        return [self __NSDateFromNSString:string];
    }
}
@end
#pragma clang diagnostic pop
