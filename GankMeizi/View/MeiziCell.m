//
//  MeiziCell.m
//  GankMeizi
//
//  Created by 张威 on 2018/9/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "MeiziCell.h"
#import "Result.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MeiziCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation MeiziCell
- (void)setMeizi:(Result *)meizi {
    NSURL *imageURL = [NSURL URLWithString:meizi.url];
    [self.imageview sd_setImageWithURL:imageURL];
}
@end
