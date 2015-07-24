//
//  YDLeftButton.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

//  图标的比例
#define YDLeftButtonImageRatio 0.3

#import "YDLeftButton.h"

@implementation YDLeftButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self ;
}


// 图片尺寸和位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width * YDLeftButtonImageRatio;
    CGFloat imageH = contentRect.size.height ;
    return CGRectMake(0, 0, imageW, imageH) ;
}

//  文字的尺寸和位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = contentRect.size.width * YDLeftButtonImageRatio ;
    CGFloat titleH = contentRect.size.height ;
    CGFloat titleW = contentRect.size.width * (1 - YDLeftButtonImageRatio) ;
    return CGRectMake(titleX, 0, titleW, titleH) ;
}
@end
