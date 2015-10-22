// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>
#import "FEMMapping.h"
#import "FEMSerializer.h"

@interface FEMSerializer : NSObject

+ (nonnull NSDictionary *)serializeObject:(nonnull id)object usingMapping:(nonnull FEMMapping *)mapping;
+ (nonnull id)serializeCollection:(nonnull NSArray *)collection usingMapping:(nonnull FEMMapping *)mapping;

@end
