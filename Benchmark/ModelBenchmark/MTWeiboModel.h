//
//  MTWeiboModel.h
//  ModelBenchmark
//
//  Created by ibireme on 15/9/18.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "Mantle.h"

@interface MTWeiboPictureMetadata : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) int cutType;
@end

@interface MTWeiboPicture : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *picID;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, assign) int photoTag;
@property (nonatomic, assign) BOOL keepSize;
@property (nonatomic, strong) MTWeiboPictureMetadata *thumbnail;
@property (nonatomic, strong) MTWeiboPictureMetadata *bmiddle;
@property (nonatomic, strong) MTWeiboPictureMetadata *middlePlus;
@property (nonatomic, strong) MTWeiboPictureMetadata *large;
@property (nonatomic, strong) MTWeiboPictureMetadata *largest;
@property (nonatomic, strong) MTWeiboPictureMetadata *original;
@end

@interface MTWeiboURL : MTLModel <MTLJSONSerializing>
@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) NSString *shortURL;
@property (nonatomic, strong) NSString *oriURL;
@property (nonatomic, strong) NSString *urlTitle;
@property (nonatomic, strong) NSString *urlTypePic;
@property (nonatomic, assign) int32_t urlType;
@property (nonatomic, strong) NSString *log;
@property (nonatomic, strong) NSDictionary *actionLog;
@property (nonatomic, strong) NSString *pageID;
@property (nonatomic, strong) NSString *storageType;
@end

@interface MTWeiboUser : MTLModel <MTLJSONSerializing>
@property (nonatomic, assign) uint64_t userID;
@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *genderString;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) int32_t followersCount;
@property (nonatomic, assign) int32_t friendsCount;
@property (nonatomic, assign) int32_t biFollowersCount;
@property (nonatomic, assign) int32_t favouritesCount;
@property (nonatomic, assign) int32_t statusesCount;
@property (nonatomic, assign) int32_t pagefriendsCount;
@property (nonatomic, assign) BOOL followMe;
@property (nonatomic, assign) BOOL following;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *avatarLarge;
@property (nonatomic, strong) NSString *avatarHD;
@property (nonatomic, strong) NSString *coverImage;
@property (nonatomic, strong) NSString *coverImagePhone;
@property (nonatomic, strong) NSString *profileURL;
@property (nonatomic, assign) int32_t type;
@property (nonatomic, assign) int32_t ptype;
@property (nonatomic, assign) int32_t mbtype;
@property (nonatomic, assign) int32_t urank;
@property (nonatomic, assign) int32_t uclass;
@property (nonatomic, assign) int32_t ulevel;
@property (nonatomic, assign) int32_t mbrank;
@property (nonatomic, assign) int32_t star;
@property (nonatomic, assign) int32_t level;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, assign) BOOL allowAllActMsg;
@property (nonatomic, assign) BOOL allowAllComment;
@property (nonatomic, assign) BOOL geoEnabled;
@property (nonatomic, assign) int32_t onlineStatus;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSString *weihao;
@property (nonatomic, strong) NSString *badgeTop;
@property (nonatomic, assign) int32_t blockWord;
@property (nonatomic, assign) int32_t blockApp;
@property (nonatomic, assign) int32_t hasAbilityTag;
@property (nonatomic, assign) int32_t creditScore;
@property (nonatomic, strong) NSDictionary *badge;
@property (nonatomic, strong) NSString *lang;
@property (nonatomic, assign) int32_t userAbility;
@property (nonatomic, strong) NSDictionary *extend;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, assign) int32_t verifiedType;
@property (nonatomic, assign) int32_t verifiedLevel;
@property (nonatomic, assign) int32_t verifiedState;
@property (nonatomic, strong) NSString *verifiedContactEmail;
@property (nonatomic, strong) NSString *verifiedContactMobile;
@property (nonatomic, strong) NSString *verifiedTrade;
@property (nonatomic, strong) NSString *verifiedContactName;
@property (nonatomic, strong) NSString *verifiedSource;
@property (nonatomic, strong) NSString *verifiedSourceURL;
@property (nonatomic, strong) NSString *verifiedReason;
@property (nonatomic, strong) NSString *verifiedReasonURL;
@property (nonatomic, strong) NSString *verifiedReasonModified;
@end

@interface MTWeiboStatus : MTLModel <MTLJSONSerializing>
@property (nonatomic, assign) uint64_t statusID;
@property (nonatomic, strong) NSString *idstr;
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *rid;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) MTWeiboUser *user;
@property (nonatomic, assign) int32_t userType;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *picIds;        /// Array<NSString>
@property (nonatomic, strong) NSDictionary *picInfos; /// Dic<NSString, MTWeiboPicture>
@property (nonatomic, strong) NSArray *urlStruct;     ///< Array<MTWeiboURL>
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, assign) int32_t repostsCount;
@property (nonatomic, assign) int32_t commentsCount;
@property (nonatomic, assign) int32_t attitudesCount;
@property (nonatomic, assign) int32_t attitudesStatus;
@property (nonatomic, assign) int32_t recomState;
@property (nonatomic, strong) NSString *inReplyToScreenName;
@property (nonatomic, strong) NSString *inReplyToStatusId;
@property (nonatomic, strong) NSString *inReplyToUserId;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) int32_t sourceType;
@property (nonatomic, assign) int32_t sourceAllowClick;
@property (nonatomic, strong) NSString *geo;
@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, assign) int32_t bizFeature;
@property (nonatomic, assign) int32_t mlevel;
@property (nonatomic, strong) NSString *mblogid;
@property (nonatomic, strong) NSString *mblogTypeName;
@property (nonatomic, assign) int32_t mblogType;
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSDictionary *visible;
@property (nonatomic, strong) NSArray *darwinTags;
@end
