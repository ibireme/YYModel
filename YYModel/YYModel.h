//
//  YYModel.h
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/5/10.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>

#if __has_include(<YYModel/YYModel.h>)
FOUNDATION_EXPORT double YYModelVersionNumber;
FOUNDATION_EXPORT const unsigned char YYModelVersionString[];
#import <YYModel/NSObject+YYModel.h>
#import <YYModel/YYClassInfo.h>
#import <YYModel/NSString+YYModel.h>
#else
#import "NSObject+YYModel.h"
#import "YYClassInfo.h"
#import "NSString+YYModel.h"
#endif



#define YYCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
self = [super init]; \
return [self modelInitWithCoder:decoder]; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self modelEncodeWithCoder:encoder]; \
}


#define YYCopyImplementation \
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }

#define YYHashImplementation \
- (NSUInteger)hash { return [self modelHash]; }

#define YYEqualImplementation \
- (BOOL)isEqual:(id)object { return [self modelIsEqual:object]; }

