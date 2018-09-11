//
//	Result.h
//
//	Create by 威 张 on 10/9/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Result : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * publishedAt;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, assign) BOOL used;
@property (nonatomic, strong) NSString * who;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end