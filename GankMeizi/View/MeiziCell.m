//
//  MeiziCell.m
//  GankMeizi
//
//  Created by 张威 on 2018/9/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "MeiziCell.h"
#import "Result.h"



@interface MeiziCell()

//@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation MeiziCell
//- (void)setMeizi:(Result *)meizi {
//    NSURL *imageURL = [NSURL URLWithString:meizi.url];
//    [self.imageview sd_setImageWithURL:imageURL];
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.bounds;
        [self addSubview:_imageView];
    }
    return self;
}
- (void)setimageurl:(NSURL *)imageurl{
    
    [self.imageView sd_setImageWithURL:imageurl];
}
@end
