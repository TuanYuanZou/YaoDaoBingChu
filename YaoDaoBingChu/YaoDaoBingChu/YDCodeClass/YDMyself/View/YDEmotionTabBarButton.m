//
//  YDEmotionTabBarButton.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/19.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionTabBarButton.h"

@implementation YDEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        //  设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        // 设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:13] ;
    }
    return self ;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
