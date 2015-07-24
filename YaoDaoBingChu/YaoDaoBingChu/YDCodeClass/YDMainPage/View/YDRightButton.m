//
//  YDRightButton.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDRightButton.h"

//  首页 导航头的右按钮

//  图标所占的比例
#define YDRightButtonImageRatio 0.5

@implementation YDRightButton




- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageH = contentRect.size.height * YDRightButtonImageRatio ;
    CGFloat imageW = contentRect.size.width / 2.0f;
    return CGRectMake(imageW / 2, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * YDRightButtonImageRatio ;
    CGFloat titleH = contentRect.size.height * (1 - YDRightButtonImageRatio) ;
    CGFloat titleW = contentRect.size.width ;
    return CGRectMake(0, titleY, titleW, titleH) ;
    
}
@end
