//
//  YDImageView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDCompass.h"

@implementation YDCompass

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self)
    {
        self.image = [UIImage imageNamed:@"Compass.png"];
    }
    return self ;
}

@end
