// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>

#import "FEMTypes.h"
#import "FEMProperty.h"

@interface FEMAttribute : NSObject <FEMProperty>

- (nullable id)mapValue:(nullable id)value;
- (nullable id)reverseMapValue:(nullable id)value;

- (nonnull instancetype)initWithProperty:(nonnull NSString *)property keyPath:(nullable NSString *)keyPath map:(nullable FEMMapBlock)map reverseMap:(nullable FEMMapBlock)reverseMap;
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property toKeyPath:(nullable NSString *)keyPath map:(nullable FEMMapBlock)map reverseMap:(nullable FEMMapBlock)reverseMap;

@end

@interface FEMAttribute (Shortcut)

/**
* same as +[FEMAttribute mappingOfProperty:property toKeyPath:property];
*/
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property;

/**
* same as +[FEMAttribute mappingOfProperty:property toKeyPath:nil map:NULL];
*/
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property toKeyPath:(nonnull NSString *)keyPath;

/**
* same as +[FEMAttribute mappingOfProperty:property toKeyPath:nil map:map];
*/
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property map:(nonnull FEMMapBlock)map;

+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property reverseMap:(nonnull FEMMapBlock)reverseMap;

/**
* same as +[FEMAttribute mappingOfProperty:property toKeyPath:nil map:NULL reverseMap:NULL];
*/
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property toKeyPath:(nonnull NSString *)keyPath map:(nonnull FEMMapBlock)map;

/**
* create mapping object, based on NSDateFormatter.
* NSDateFormatter instance uses en_US_POSIX locale and UTC Timezone
*/
+ (nonnull instancetype)mappingOfProperty:(nonnull NSString *)property toKeyPath:(nullable NSString *)keyPath dateFormat:(nonnull NSString *)dateFormat;

/**
* property represented by NSURL, value at keyPath - NSString
*/
+ (nonnull instancetype)mappingOfURLProperty:(nonnull NSString *)property toKeyPath:(nullable NSString *)keyPath;

@end