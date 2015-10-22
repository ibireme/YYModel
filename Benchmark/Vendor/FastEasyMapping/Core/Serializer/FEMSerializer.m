// For License please refer to LICENSE file in the root of FastEasyMapping project

#import "FEMSerializer.h"
#import "FEMAttribute.h"
#import "FEMTypeIntrospection.h"
#import "FEMRelationship.h"

@implementation FEMSerializer

+ (NSDictionary *)_serializeObject:(id)object usingMapping:(FEMMapping *)mapping {
	NSMutableDictionary *representation = [NSMutableDictionary dictionary];

	for (FEMAttribute *fieldMapping in mapping.attributes) {
		[self setValueOnRepresentation:representation fromObject:object withFieldMapping:fieldMapping];
	}

	for (FEMRelationship *relationshipMapping in mapping.relationships) {
		[self setRelationshipObjectOn:representation usingMapping:relationshipMapping fromObject:object];
	}

	return representation;
}

+ (NSDictionary *)serializeObject:(id)object usingMapping:(FEMMapping *)mapping {
	NSDictionary *representation = [self _serializeObject:object usingMapping:mapping];

	return mapping.rootPath.length > 0 ? @{mapping.rootPath : representation} : representation;
}

+ (id)_serializeCollection:(NSArray *)collection usingMapping:(FEMMapping *)mapping {
	NSMutableArray *representation = [NSMutableArray new];

	for (id object in collection) {
		NSDictionary *objectRepresentation = [self _serializeObject:object usingMapping:mapping];
		[representation addObject:objectRepresentation];
	}

	return representation;
}

+ (id)serializeCollection:(NSArray *)collection usingMapping:(FEMMapping *)mapping {
	NSArray *representation = [self _serializeCollection:collection usingMapping:mapping];

	return mapping.rootPath.length > 0 ? @{mapping.rootPath: representation} : representation;
}

+ (void)setValueOnRepresentation:(NSMutableDictionary *)representation fromObject:(id)object withFieldMapping:(FEMAttribute *)fieldMapping {
	id returnedValue = [object valueForKey:fieldMapping.property];
	if (returnedValue) {
        returnedValue = [fieldMapping reverseMapValue:returnedValue] ?: [NSNull null];

		[self setValue:returnedValue forKeyPath:fieldMapping.keyPath inRepresentation:representation];
	}
}

+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath inRepresentation:(NSMutableDictionary *)representation {
	NSArray *keyPathComponents = [keyPath componentsSeparatedByString:@"."];
	if ([keyPathComponents count] == 1) {
		[representation setObject:value forKey:keyPath];
	} else if ([keyPathComponents count] > 1) {
		NSString *attributeKey = [keyPathComponents lastObject];
		NSMutableArray *subPaths = [NSMutableArray arrayWithArray:keyPathComponents];
		[subPaths removeLastObject];

		id currentPath = representation;
		for (NSString *key in subPaths) {
			id subPath = [currentPath valueForKey:key];
			if (subPath == nil) {
				subPath = [NSMutableDictionary new];
				[currentPath setValue:subPath forKey:key];
			}
			currentPath = subPath;
		}
		[currentPath setValue:value forKey:attributeKey];
	}
}

+ (void)setRelationshipObjectOn:(NSMutableDictionary *)representation
                   usingMapping:(FEMRelationship *)relationshipMapping
			         fromObject:(id)object {
	id value = [object valueForKey:relationshipMapping.property];
	if (value) {
		id relationshipRepresentation = nil;
		if (relationshipMapping.isToMany) {
			relationshipRepresentation = [self _serializeCollection:value usingMapping:relationshipMapping.mapping];
		} else {
			relationshipRepresentation = [self _serializeObject:value usingMapping:relationshipMapping.mapping];
		}

		if (relationshipMapping.keyPath.length > 0) {
			[representation setObject:relationshipRepresentation forKey:relationshipMapping.keyPath];
		} else {
			NSParameterAssert([relationshipRepresentation isKindOfClass:NSDictionary.class]);
			[representation addEntriesFromDictionary:relationshipRepresentation];
		}
	}
}

@end