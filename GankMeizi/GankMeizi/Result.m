//
//	Result.m
//
//	Create by 威 张 on 10/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Result.h"

NSString *const kResultIdField = @"_id";
NSString *const kResultCreatedAt = @"createdAt";
NSString *const kResultDesc = @"desc";
NSString *const kResultPublishedAt = @"publishedAt";
NSString *const kResultSource = @"source";
NSString *const kResultType = @"type";
NSString *const kResultUrl = @"url";
NSString *const kResultUsed = @"used";
NSString *const kResultWho = @"who";

@interface Result ()
@end
@implementation Result




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kResultIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kResultIdField];
	}	
	if(![dictionary[kResultCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kResultCreatedAt];
	}	
	if(![dictionary[kResultDesc] isKindOfClass:[NSNull class]]){
		self.desc = dictionary[kResultDesc];
	}	
	if(![dictionary[kResultPublishedAt] isKindOfClass:[NSNull class]]){
		self.publishedAt = dictionary[kResultPublishedAt];
	}	
	if(![dictionary[kResultSource] isKindOfClass:[NSNull class]]){
		self.source = dictionary[kResultSource];
	}	
	if(![dictionary[kResultType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kResultType];
	}	
	if(![dictionary[kResultUrl] isKindOfClass:[NSNull class]]){
		self.url = dictionary[kResultUrl];
	}	
	if(![dictionary[kResultUsed] isKindOfClass:[NSNull class]]){
		self.used = [dictionary[kResultUsed] boolValue];
	}

	if(![dictionary[kResultWho] isKindOfClass:[NSNull class]]){
		self.who = dictionary[kResultWho];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.idField != nil){
		dictionary[kResultIdField] = self.idField;
	}
	if(self.createdAt != nil){
		dictionary[kResultCreatedAt] = self.createdAt;
	}
	if(self.desc != nil){
		dictionary[kResultDesc] = self.desc;
	}
	if(self.publishedAt != nil){
		dictionary[kResultPublishedAt] = self.publishedAt;
	}
	if(self.source != nil){
		dictionary[kResultSource] = self.source;
	}
	if(self.type != nil){
		dictionary[kResultType] = self.type;
	}
	if(self.url != nil){
		dictionary[kResultUrl] = self.url;
	}
	dictionary[kResultUsed] = @(self.used);
	if(self.who != nil){
		dictionary[kResultWho] = self.who;
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
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kResultIdField];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kResultCreatedAt];
	}
	if(self.desc != nil){
		[aCoder encodeObject:self.desc forKey:kResultDesc];
	}
	if(self.publishedAt != nil){
		[aCoder encodeObject:self.publishedAt forKey:kResultPublishedAt];
	}
	if(self.source != nil){
		[aCoder encodeObject:self.source forKey:kResultSource];
	}
	if(self.type != nil){
		[aCoder encodeObject:self.type forKey:kResultType];
	}
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:kResultUrl];
	}
	[aCoder encodeObject:@(self.used) forKey:kResultUsed];	if(self.who != nil){
		[aCoder encodeObject:self.who forKey:kResultWho];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kResultIdField];
	self.createdAt = [aDecoder decodeObjectForKey:kResultCreatedAt];
	self.desc = [aDecoder decodeObjectForKey:kResultDesc];
	self.publishedAt = [aDecoder decodeObjectForKey:kResultPublishedAt];
	self.source = [aDecoder decodeObjectForKey:kResultSource];
	self.type = [aDecoder decodeObjectForKey:kResultType];
	self.url = [aDecoder decodeObjectForKey:kResultUrl];
	self.used = [[aDecoder decodeObjectForKey:kResultUsed] boolValue];
	self.who = [aDecoder decodeObjectForKey:kResultWho];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Result *copy = [Result new];

	copy.idField = [self.idField copy];
	copy.createdAt = [self.createdAt copy];
	copy.desc = [self.desc copy];
	copy.publishedAt = [self.publishedAt copy];
	copy.source = [self.source copy];
	copy.type = [self.type copy];
	copy.url = [self.url copy];
	copy.used = self.used;
	copy.who = [self.who copy];

	return copy;
}
@end