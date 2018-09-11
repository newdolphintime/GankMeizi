//
//	GankMeizi.m
//
//	Create by 威 张 on 10/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "GankMeizi.h"

NSString *const kGankMeiziError = @"error";
NSString *const kGankMeiziResults = @"results";

@interface GankMeizi ()
@end
@implementation GankMeizi




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kGankMeiziError] isKindOfClass:[NSNull class]]){
		self.error = [dictionary[kGankMeiziError] boolValue];
	}

	if(dictionary[kGankMeiziResults] != nil && [dictionary[kGankMeiziResults] isKindOfClass:[NSArray class]]){
		NSArray * resultsDictionaries = dictionary[kGankMeiziResults];
		NSMutableArray * resultsItems = [NSMutableArray array];
		for(NSDictionary * resultsDictionary in resultsDictionaries){
			Result * resultsItem = [[Result alloc] initWithDictionary:resultsDictionary];
			[resultsItems addObject:resultsItem];
		}
		self.results = resultsItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kGankMeiziError] = @(self.error);
	if(self.results != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Result * resultsElement in self.results){
			[dictionaryElements addObject:[resultsElement toDictionary]];
		}
		dictionary[kGankMeiziResults] = dictionaryElements;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.error) forKey:kGankMeiziError];	if(self.results != nil){
		[aCoder encodeObject:self.results forKey:kGankMeiziResults];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.error = [[aDecoder decodeObjectForKey:kGankMeiziError] boolValue];
	self.results = [aDecoder decodeObjectForKey:kGankMeiziResults];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	GankMeizi *copy = [GankMeizi new];

	copy.error = self.error;
	copy.results = [self.results copy];

	return copy;
}
@end