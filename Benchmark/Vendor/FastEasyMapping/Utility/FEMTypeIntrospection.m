// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMTypeIntrospection.h"
#import <objc/runtime.h>

static const char ScalarTypeEncodings[] = {
	_C_BOOL, _C_BFLD,          // BOOL
	_C_CHR, _C_UCHR,           // char, unsigned char
	_C_SHT, _C_USHT,           // short, unsigned short
	_C_INT, _C_UINT,           // int, unsigned int, NSInteger, NSUInteger
	_C_LNG, _C_ULNG,           // long, unsigned long
	_C_LNG_LNG, _C_ULNG_LNG,   // long long, unsigned long long
	_C_FLT, _C_DBL,            // float, CGFloat, double
	0
};

BOOL FEMObjectPropertyTypeIsScalar(id object, NSString *propertyName) {
	objc_property_t property = class_getProperty(object_getClass(object), [propertyName UTF8String]);
	NSString *type = property ? FEMPropertyTypeStringRepresentation(property) : nil;

	return (type.length == 1) && (NSNotFound != [@(ScalarTypeEncodings) rangeOfString:type].location);
}

NSString * FEMPropertyTypeStringRepresentation(objc_property_t property) {
	const char *TypeAttribute = "T";
	char *type = property_copyAttributeValue(property, TypeAttribute);
	NSString *propertyType = (type[0] != _C_ID) ? @(type) : ({
		(type[1] == 0) ? @"id" : ({
			// Modern format of a type attribute (e.g. @"NSSet")
			type[strlen(type) - 1] = 0;
			@(type + 2);
		});
	});
	free(type);
	return propertyType;
}