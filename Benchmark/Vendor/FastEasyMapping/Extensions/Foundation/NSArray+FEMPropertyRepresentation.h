// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSArray (FEMPropertyRepresentation)

- (id)fem_propertyRepresentation:(objc_property_t)property;

@end