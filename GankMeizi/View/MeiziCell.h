//
//  MeiziCell.h
//  GankMeizi
//
//  Created by 张威 on 2018/9/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Result;

@interface MeiziCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
-(void)setimageurl:(NSURL *)imageurl;

//- (void)setMeizi:(Result *)meizi;
@end
