// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>

@protocol FEMProperty <NSObject>

@property (nonatomic, copy, nonnull) NSString *property;
@property (nonatomic, copy, nullable) NSString *keyPath;

@end