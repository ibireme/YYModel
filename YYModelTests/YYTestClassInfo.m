//
//  YYTestClassInfo.m
//  YYModel <https://github.com/ibireme/YYModel>
//
//  Created by ibireme on 15/11/27.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <XCTest/XCTest.h>
#import <CoreFoundation/CoreFoundation.h>
#import "YYModel.h"

typedef union yy_union{ char a; int b;} yy_union;

@interface YYTestPropertyModel : NSObject
@property bool boolValue;
@property BOOL BOOLValue;
@property char charValue;
@property unsigned char unsignedCharValue;
@property short shortValue;
@property unsigned short unsignedShortValue;
@property int intValue;
@property unsigned int unsignedIntValue;
@property long longValue;
@property unsigned long unsignedLongValue;
@property long long longLongValue;
@property unsigned long long unsignedLongLongValue;
@property float floatValue;
@property double doubleValue;
@property long double longDoubleValue;
@property (strong) NSObject *objectValue;
@property (strong) NSArray *arrayValue;
@property (strong) Class classValue;
@property SEL selectorValue;
@property (copy) void (^blockValue)();
@property void *pointerValue;
@property CFArrayEqualCallBack functionPointerValue;
@property CGRect structValue;
@property yy_union unionValue;
@property char *cStringValue;

@property (nonatomic) NSObject *nonatomicValue;
@property (copy) NSObject *aCopyValue;
@property (assign) NSObject *assignValue;
@property (strong) NSObject *strongValue;
@property (retain) NSObject *retainValue;
@property (weak) NSObject *weakValue;
@property (readonly) NSObject *readonlyValue;
@property (nonatomic) NSObject *dynamicValue;
@property (unsafe_unretained) NSObject *unsafeValue;
@property (nonatomic, getter=getValue) NSObject *getterValue;
@property (nonatomic, setter=setValue:) NSObject *setterValue;
@end

@implementation YYTestPropertyModel {
    const NSObject *_constValue;
}

@dynamic dynamicValue;

- (NSObject *)getValue {
    return _getterValue;
}

- (void)setValue:(NSObject *)value {
    _setterValue = value;
}

- (void)testConst:(const NSObject *)value {}
- (void)testIn:(in NSObject *)value {}
- (void)testOut:(out NSObject *)value {}
- (void)testInout:(inout NSObject *)value {}
- (void)testBycopy:(bycopy NSObject *)value {}
- (void)testByref:(byref NSObject *)value {}
- (void)testOneway:(oneway NSObject *)value {}
@end






@interface YYTestClassInfo : XCTestCase
@end

@implementation YYTestClassInfo

- (void)testClassInfoCache {
    YYClassInfo *info1 = [YYClassInfo classInfoWithClass:[YYTestPropertyModel class]];
    [info1 setNeedUpdate];
    YYClassInfo *info2 = [YYClassInfo classInfoWithClassName:@"YYTestPropertyModel"];
    XCTAssertNotNil(info1);
    XCTAssertNotNil(info2);
    XCTAssertEqual(info1, info2);
}

- (void)testClassMeta {
    YYClassInfo *classInfo = [YYClassInfo classInfoWithClass:[YYTestPropertyModel class]];
    XCTAssertNotNil(classInfo);
    XCTAssertEqual(classInfo.cls, [YYTestPropertyModel class]);
    XCTAssertEqual(classInfo.superCls, [NSObject class]);
    XCTAssertEqual(classInfo.metaCls, objc_getMetaClass("YYTestPropertyModel"));
    XCTAssertEqual(classInfo.isMeta, NO);
    
    Class meta = object_getClass([YYTestPropertyModel class]);
    YYClassInfo *metaClassInfo = [YYClassInfo classInfoWithClass:meta];
    XCTAssertNotNil(metaClassInfo);
    XCTAssertEqual(metaClassInfo.cls, meta);
    XCTAssertEqual(metaClassInfo.superCls, object_getClass([NSObject class]));
    XCTAssertEqual(metaClassInfo.metaCls, nil);
    XCTAssertEqual(metaClassInfo.isMeta, YES);
}

- (void)testClassInfo {
    YYClassInfo *info = [YYClassInfo classInfoWithClass:[YYTestPropertyModel class]];
    XCTAssertEqual([self getType:info name:@"boolValue"] & YYEncodingTypeMask, YYEncodingTypeBool);
#ifdef OBJC_BOOL_IS_BOOL
    XCTAssertEqual([self getType:info name:@"BOOLValue"] & YYEncodingTypeMask, YYEncodingTypeBool);
#else
    XCTAssertEqual([self getType:info name:@"BOOLValue"] & YYEncodingTypeMask, YYEncodingTypeInt8);
#endif
    XCTAssertEqual([self getType:info name:@"charValue"] & YYEncodingTypeMask, YYEncodingTypeInt8);
    XCTAssertEqual([self getType:info name:@"unsignedCharValue"] & YYEncodingTypeMask, YYEncodingTypeUInt8);
    XCTAssertEqual([self getType:info name:@"shortValue"] & YYEncodingTypeMask, YYEncodingTypeInt16);
    XCTAssertEqual([self getType:info name:@"unsignedShortValue"] & YYEncodingTypeMask, YYEncodingTypeUInt16);
    XCTAssertEqual([self getType:info name:@"intValue"] & YYEncodingTypeMask, YYEncodingTypeInt32);
    XCTAssertEqual([self getType:info name:@"unsignedIntValue"] & YYEncodingTypeMask, YYEncodingTypeUInt32);
#ifdef __LP64__
    XCTAssertEqual([self getType:info name:@"longValue"] & YYEncodingTypeMask, YYEncodingTypeInt64);
    XCTAssertEqual([self getType:info name:@"unsignedLongValue"] & YYEncodingTypeMask, YYEncodingTypeUInt64);
    XCTAssertEqual(YYEncodingGetType("l") & YYEncodingTypeMask, YYEncodingTypeInt32); // long in 32 bit system
    XCTAssertEqual(YYEncodingGetType("L") & YYEncodingTypeMask, YYEncodingTypeUInt32); // unsingle long in 32 bit system
#else
    XCTAssertEqual([self getType:info name:@"longValue"] & YYEncodingTypeMask, YYEncodingTypeInt32);
    XCTAssertEqual([self getType:info name:@"unsignedLongValue"] & YYEncodingTypeMask, YYEncodingTypeUInt32);
#endif
    XCTAssertEqual([self getType:info name:@"longLongValue"] & YYEncodingTypeMask, YYEncodingTypeInt64);
    XCTAssertEqual([self getType:info name:@"unsignedLongLongValue"] & YYEncodingTypeMask, YYEncodingTypeUInt64);
    XCTAssertEqual([self getType:info name:@"floatValue"] & YYEncodingTypeMask, YYEncodingTypeFloat);
    XCTAssertEqual([self getType:info name:@"doubleValue"] & YYEncodingTypeMask, YYEncodingTypeDouble);
    XCTAssertEqual([self getType:info name:@"longDoubleValue"] & YYEncodingTypeMask, YYEncodingTypeLongDouble);
    
    XCTAssertEqual([self getType:info name:@"objectValue"] & YYEncodingTypeMask, YYEncodingTypeObject);
    XCTAssertEqual([self getType:info name:@"arrayValue"] & YYEncodingTypeMask, YYEncodingTypeObject);
    XCTAssertEqual([self getType:info name:@"classValue"] & YYEncodingTypeMask, YYEncodingTypeClass);
    XCTAssertEqual([self getType:info name:@"selectorValue"] & YYEncodingTypeMask, YYEncodingTypeSEL);
    XCTAssertEqual([self getType:info name:@"blockValue"] & YYEncodingTypeMask, YYEncodingTypeBlock);
    XCTAssertEqual([self getType:info name:@"pointerValue"] & YYEncodingTypeMask, YYEncodingTypePointer);
    XCTAssertEqual([self getType:info name:@"functionPointerValue"] & YYEncodingTypeMask, YYEncodingTypePointer);
    XCTAssertEqual([self getType:info name:@"structValue"] & YYEncodingTypeMask, YYEncodingTypeStruct);
    XCTAssertEqual([self getType:info name:@"unionValue"] & YYEncodingTypeMask, YYEncodingTypeUnion);
    XCTAssertEqual([self getType:info name:@"cStringValue"] & YYEncodingTypeMask, YYEncodingTypeCString);
    
    XCTAssertEqual(YYEncodingGetType(@encode(void)) & YYEncodingTypeMask, YYEncodingTypeVoid);
    XCTAssertEqual(YYEncodingGetType(@encode(int[10])) & YYEncodingTypeMask, YYEncodingTypeCArray);
    XCTAssertEqual(YYEncodingGetType("") & YYEncodingTypeMask, YYEncodingTypeUnknown);
    XCTAssertEqual(YYEncodingGetType(".") & YYEncodingTypeMask, YYEncodingTypeUnknown);
    XCTAssertEqual(YYEncodingGetType("ri") & YYEncodingTypeQualifierMask, YYEncodingTypeQualifierConst);
    XCTAssertEqual([self getMethodTypeWithName:@"testIn:"] & YYEncodingTypeQualifierMask, YYEncodingTypeQualifierIn);
    XCTAssertEqual([self getMethodTypeWithName:@"testOut:"] & YYEncodingTypeQualifierMask, YYEncodingTypeQualifierOut);
    XCTAssertEqual([self getMethodTypeWithName:@"testInout:"] & YYEncodingTypeQualifierMask, YYEncodingTypeQualifierInout);
    XCTAssertEqual([self getMethodTypeWithName:@"testBycopy:"] & YYEncodingTypeQualifierMask, YYEncodingTypeQualifierBycopy);
    XCTAssertEqual([self getMethodTypeWithName:@"testByref:"] & YYEncodingTypeQualifierMask, YYEncodingTypeQualifierByref);
    XCTAssertEqual([self getMethodTypeWithName:@"testOneway:"] & YYEncodingTypeQualifierMask, YYEncodingTypeQualifierOneway);
    
    XCTAssert([self getType:info name:@"nonatomicValue"] & YYEncodingTypePropertyMask &YYEncodingTypePropertyNonatomic);
    XCTAssert([self getType:info name:@"aCopyValue"] & YYEncodingTypePropertyMask & YYEncodingTypePropertyCopy);
    XCTAssert([self getType:info name:@"strongValue"] & YYEncodingTypePropertyMask & YYEncodingTypePropertyRetain);
    XCTAssert([self getType:info name:@"retainValue"] & YYEncodingTypePropertyMask & YYEncodingTypePropertyRetain);
    XCTAssert([self getType:info name:@"weakValue"] & YYEncodingTypePropertyMask & YYEncodingTypePropertyWeak);
    XCTAssert([self getType:info name:@"readonlyValue"] & YYEncodingTypePropertyMask & YYEncodingTypePropertyReadonly);
    XCTAssert([self getType:info name:@"dynamicValue"] & YYEncodingTypePropertyMask & YYEncodingTypePropertyDynamic);
    XCTAssert([self getType:info name:@"getterValue"] & YYEncodingTypePropertyMask &YYEncodingTypePropertyCustomGetter);
    XCTAssert([self getType:info name:@"setterValue"] & YYEncodingTypePropertyMask & YYEncodingTypePropertyCustomSetter);
}

- (YYEncodingType)getType:(YYClassInfo *)info name:(NSString *)name {
    return ((YYClassPropertyInfo *)info.propertyInfos[name]).type;
}

- (YYEncodingType)getMethodTypeWithName:(NSString *)name {
    YYTestPropertyModel *model = [YYTestPropertyModel new];
    NSMethodSignature *sig = [model methodSignatureForSelector:NSSelectorFromString(name)];
    const char *typeName = [sig getArgumentTypeAtIndex:2];
    return YYEncodingGetType(typeName);
}

@end
