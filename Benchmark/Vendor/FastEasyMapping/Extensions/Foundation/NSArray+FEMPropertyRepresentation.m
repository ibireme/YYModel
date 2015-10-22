// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "NSArray+FEMPropertyRepresentation.h"

#import "FEMTypeIntrospection.h"

@implementation NSArray (FEMPropertyRepresentation)

- (id)fem_propertyRepresentation:(objc_property_t)property {
	id convertedObject = self;
	if (property) {
		NSString *type = FEMPropertyTypeStringRepresentation(property);
		if ([type isEqualToString:@"NSSet"]) {
			convertedObject = [NSSet setWithArray:self];
		}
		else if ([type isEqualToString:@"NSMutableSet"]) {
			convertedObject = [NSMutableSet setWithArray:self];
		}
		else if ([type isEqualToString:@"NSOrderedSet"]) {
			convertedObject = [NSOrderedSet orderedSetWithArray:self];
		}
		else if ([type isEqualToString:@"NSMutableOrderedSet"]) {
			convertedObject = [NSMutableOrderedSet orderedSetWithArray:self];
		}
		else if ([type isEqualToString:@"NSMutableArray"]) {
			convertedObject = [NSMutableArray arrayWithArray:self];
		}
	}
	return convertedObject;
}

@end