//
//  UIImage+YDStretchImage.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "UIImage+YDStretchImage.h"

@implementation UIImage (YDStretchImage)


+ (UIImage *)resizableImageWithName:(NSString *)name
{
    UIImage * image = [self imageNamed:name] ;
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5] ;
}

@end
