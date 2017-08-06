//
//  WBModel.m
//  ModelBenchmark
//
//  Created by ibireme on 15/9/18.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "YYWeiboModel.h"

#define YYModelSynthCoderAndHash \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; } \
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; } \
- (NSUInteger)hash { return [self yy_modelHash]; } \
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }


@implementation YYWeiboPictureMetadata
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cutType" : @"cut_type"};
}
YYModelSynthCoderAndHash
@end

@implementation YYWeiboPicture
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"picID" : @"pic_id",
             @"keepSize" : @"keep_size",
             @"photoTag" : @"photo_tag",
             @"objectID" : @"object_id",
             @"middlePlus" : @"middleplus"};
}
YYModelSynthCoderAndHash
@end

@implementation YYWeiboURL
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"oriURL" : @"ori_url",
             @"urlTitle" : @"url_title",
             @"urlTypePic" : @"url_type_pic",
             @"urlType" : @"url_type",
             @"shortURL" : @"short_url",
             @"actionLog" : @"actionlog",
             @"pageID" : @"page_id",
             @"storageType" : @"storage_type"};
}
YYModelSynthCoderAndHash
@end

@implementation YYWeiboUser
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userID" : @"id",
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
             @"userAbility" : @"user_ability"};
}
YYModelSynthCoderAndHash
@end

@implementation YYWeiboStatus
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"statusID" : @"id",
             @"createdAt" : @"created_at",
             @"attitudesStatus" : @"attitudes_status",
             @"inReplyToScreenName" : @"in_reply_to_screen_name",
             @"sourceType" : @"source_type",
             @"commentsCount" : @"comments_count",
             @"recomState" : @"recom_state",
             @"urlStruct" : @"url_struct",
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
             @"inReplyToUserId" : @"in_reply_to_user_id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"picIds" : [NSString class],
             @"picInfos" : [YYWeiboPicture class],
             @"urlStruct" : [YYWeiboURL class]};
}
YYModelSynthCoderAndHash
@end
