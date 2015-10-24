YYModel
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYModel/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![Cocoapods](http://img.shields.io/cocoapods/v/YYModel.svg?style=flat)](http://cocoapods.org/?q= YYModel)&nbsp;
[![Cocoapods](http://img.shields.io/cocoapods/p/YYModel.svg?style=flat)](http://cocoapods.org/?q= YYModel)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)

High performance model framework for iOS.


Performance
==============

Time cost (process GithubUser 10000 times on iPhone 6):

![Benchmark result](https://raw.github.com/ibireme/YYModel/master/Benchmark/Result.png
)

See `Benchmark/ModelBenchmark.xcodeproj` for more benchmark case.


Usage
==============

###Simple model json convert

	// JSON:
	{
	    "uid":123456,
	    "name":"Harry",
	    "created":"1965-07-31T00:00:00+0000"
	}

	// Model:
	@interface User : NSObject
	@property UInt64 uid;
	@property NSString *name;
	@property NSDate *created;
	@end
	@implementation User
	@end

	
	// Convert json to model:
	User *user = [User yy_modelWithJSON:json];
	
	// Convert model to json:
	NSDictionary *json = [user yy_modelToJSONObject];


If the type of an object in JSON/Dictionary cannot be matched to the property of the model, the following automatic conversion is performed:
<table>
  <thead>
    <tr>
      <th>JSON/Dictionary</th>
      <th>Model</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>NSString</td>
      <td>NSURL,SEL,Class</td>
    </tr>
    <tr>
      <td>NSString</td>
      <td>NSDate parsed with these formats:<br/>
      yyyy-MM-dd<br/>
yyyy-MM-dd HH:mm:ss<br/>
yyyy-MM-dd'T'HH:mm:ss<br/>
yyyy-MM-dd'T'HH:mm:ssZ<br/>
EEE MMM dd HH:mm:ss Z yyyy
      </td>
    </tr>
    <tr>
      <td>NSDate</td>
      <td>NSString (formatted with ISO8601)<br/>
      "YYYY-MM-dd'T'HH:mm:ssZ"</td>
    </tr>
    <tr>
      <td>NSString/NSNumber</td>
      <td>C number (BOOL,int,float,NSUInteger,UInt64,...)<br/>
      NaN and Inf will be ignored</td>
    </tr>
    <tr>
      <td>NSNumber</td>
      <td>NSString (NSNumber.stringValue)</td>
    </tr>
    <tr>
      <td>NSValue</td>
      <td>struct (CGRect,CGSize,...)</td>
    </tr>
    <tr>
      <td>NSNull</td>
      <td>nil,0</td>
    </tr>
    <tr>
      <td>"null","nil","no","false",...</td>
      <td>nil,0</td>
    </tr>
    <tr>
      <td>"YES","yes","true",...</td>
      <td>@(YES)</td>
    </tr>
  </tbody>
</table>



###Match model property to different JSON key

	// JSON:
	{
	    "n":"Harry Pottery",
	    "p": 256,
	    "ext" : {
	        "desc" : "A book written by J.K.Rowing."
	    }
	}

	// Model:
	@interface Book : NSObject
	@property NSString *name;
	@property NSInteger page;
	@property NSString *desc;
	@end
	@implementation Book
	+ (NSDictionary *)modelCustomPropertyMapper {
	    return @{@"name" : @"n",
	             @"page" : @"p",
	             @"desc" : @"ext.desc"};
	}
	@end

###Nested model

	// JSON
	{
	    "author":{
	        "name":"J.K.Rowling",
	        "birthday":"1965-07-31T00:00:00+0000"
	    },
	    "name":"Harry Potter",
	    "pages":256
	}

	// Model: (no need to do anything)
	@interface Author : NSObject
	@property NSString *name;
	@property NSDate *birthday;
	@end
	@implementation Author
	@end
	
	@interface Book : NSObject
	@property NSString *name;
	@property NSUInteger pages;
	@property Author *author;
	@end
	@implementation Book
	@end
	
	

### Container property

	@class Shadow, Border, Attachment;

	@interface Attributes
	@property NSString *name;
	@property NSArray *shadows; //Array<Shadow>
	@property NSSet *borders; //Set<Border>
	@property NSMutableDictionary *attachments; //Dict<NSString,Attachment>
	@end

	@implementation Attributes
	+ (NSDictionary *)modelContainerPropertyGenericClass {
		// value should be Class or Class name.
	    return @{@"shadows" : [Shadow class],
	             @"borders" : Border.class,
	             @"attachments" : @"Attachment" };
	}
	@end




### Whitelist and blacklist

	@interface User
	@property NSString *name;
	@property NSUInteger age;
	@end
	
	@implementation Attributes
	+ (NSArray *)modelPropertyBlacklist {
	    return @{@"test1", @"test2"};
	}
	+ (NSArray *)modelPropertyWhitelist {
	    return @{@"name"};
	}
	@end

###Data validate and custom transform
	
	// JSON:
	{
		"name":"Harry",
		"timestamp" : 1445534567
	}
	
	// Model:
	@interface User
	@property NSString *name;
	@property NSDate *createdAt;
	@end

	@implementation User
	- (BOOL))modelCustomTransformFromDictionary:(NSDictionary *)dic {
	    NSNumber *timestamp = dic[@"timestamp"];
	    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
	    _createdAt = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
	    return YES;
	}
	- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
	    if (!_createdAt) return NO;
	    dic[@"timestamp"] = @(n.timeIntervalSince1970);
	    return YES;
	}
	@end

###Coding/Copying/hash/equal

	@interface YYShadow :NSObject <NSCoding, NSCopying>
	@property (nonatomic, copy) NSString *name;
	@property (nonatomic, assign) CGSize size;
	@end

	@implementation YYShadow
	- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
	- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; }
	- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
	- (NSUInteger)hash { return [self yy_modelHash]; }
	- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
	@end


Installation
==============

### Cocoapods

1. Add `pod "YYModel"` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import \<YYModel/YYModel.h\>


### Carthage

1. Add `github "ibireme/YYModel"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
3. Import \<YYModel/YYModel.h\>


### Manually

1. Download all the files in the YYModel subdirectory.
2. Add the source files to your Xcode project.
3. Import `YYModel.h`.


About
==============
This library supports iOS 6.0 and later.


License
==============
YYModel is provided under the MIT license. See LICENSE file for details.

中文链接
==============
[中文介绍](http://blog.ibireme.com/2015/10/23/yymodel/)

[性能评测](http://blog.ibireme.com/2015/10/23/ios_model_framework_benchmark/)
