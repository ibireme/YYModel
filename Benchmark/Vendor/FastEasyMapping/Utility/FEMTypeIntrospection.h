// For License please refer to LICENSE file in the root of FastEasyMapping project

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

extern BOOL FEMObjectPropertyTypeIsScalar(id object, NSString *propertyName);

extern NSString * FEMPropertyTypeStringRepresentation(objc_property_t property);