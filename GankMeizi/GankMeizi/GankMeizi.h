//
//	GankMeizi.h
//
//	Create by 威 张 on 10/9/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Result.h"

@interface GankMeizi : NSObject

@property (nonatomic, assign) BOOL error;
@property (nonatomic, strong) NSArray * results;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
