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
    return [[JSONKeyMapper alloc] initWithDictionary:@{ @"cut_type" : @"cutType" }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboPicture
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"pic_id" : @"picID",
        @"keep_size" : @"keepSize",
        @"photo_tag" : @"photoTag",
        @"object_id" : @"objectID",
        @"middleplus" : @"middlePlus"
    }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboURL
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"ori_url" : @"oriURL",
        @"url_title" : @"urlTitle",
        @"url_type_pic" : @"urlTypePic",
        @"url_type" : @"urlType",
        @"short_url" : @"shortURL",
        @"actionlog" : @"actionLog",
        @"page_id" : @"pageID",
        @"storage_type" : @"storageType"
    }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboUser
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
             @"id" : @"userID",
             @"idstr" : @"idString",
             @"gender" : @"genderString",
             @"bi_followers_count" : @"biFollowersCount",
             @"profile_image_url" : @"profileImageURL",
             @"class" : @"uclass",
             @"verified_contact_email" : @"verifiedContactEmail",
             @"statuses_count" : @"statusesCount",
             @"geo_enabled" : @"geoEnabled",
             @"follow_me" : @"followMe",
             @"cover_image_phone" : @"coverImagePhone",
             @"description" : @"desc",
             @"followers_count" : @"followersCount",
             @"verified_contact_mobile" : @"verifiedContactMobile",
             @"avatar_large" : @"avatarLarge",
             @"verified_trade" : @"verifiedTrade",
             @"profile_url" : @"profileURL",
             @"cover_image" : @"coverImage",
             @"online_status"  : @"onlineStatus",
             @"badge_top" : @"badgeTop",
             @"verified_contact_name" : @"verifiedContactName",
             @"screen_name" : @"screenName",
             @"verified_source_url" : @"verifiedSourceURL",
             @"pagefriends_count" : @"pagefriendsCount",
             @"vverified_reason" : @"erifiedReason",
             @"friends_count" : @"friendsCount",
             @"block_app" : @"blockApp",
             @"has_ability_tag" : @"hasAbilityTag",
             @"avatar_hd" : @"avatarHD",
             @"credit_score" : @"creditScore",
             @"created_at" : @"createdAt",
             @"block_word" : @"blockWord",
             @"allow_all_act_msg" : @"allowAllActMsg",
             @"verified_state" : @"verifiedState",
             @"verified_reason_modified" : @"verifiedReasonModified",
             @"allow_all_comment" : @"allowAllComment",
             @"verified_level" : @"verifiedLevel",
             @"verified_reason_url" : @"verifiedReasonURL",
             @"favourites_count" : @"favouritesCount",
             @"verified_type" : @"verifiedType",
             @"verified_source" : @"verifiedSource",
             @"user_ability" : @"userAbility"}];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end

@implementation JSWeiboStatus
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"id" : @"statusID",
        @"created_at" : @"createdAt",
        @"attitudes_status" : @"attitudesStatus",
        @"in_reply_to_screen_name" : @"inReplyToScreenName",
        @"source_type" : @"sourceType",
        @"comments_count" : @"commentsCount",
        @"recom_state" : @"recomState",
        @"source_allowclick" : @"sourceAllowClick",
        @"biz_feature" : @"bizFeature",
        @"mblogtypename" : @"mblogTypeName",
        @"url_struct" : @"urlStruct",
        @"mblogtype" : @"mblogType",
        @"in_reply_to_status_id" : @"inReplyToStatusId",
        @"pic_ids" : @"picIds",
        @"reposts_count" : @"repostsCount",
        @"attitudes_count" : @"attitudesCount",
        @"darwin_tags" : @"darwinTags",
        @"userType" : @"userType",
        @"pic_infos" : @"picInfos",
        @"in_reply_to_user_id" : @"inReplyToUserId"
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
