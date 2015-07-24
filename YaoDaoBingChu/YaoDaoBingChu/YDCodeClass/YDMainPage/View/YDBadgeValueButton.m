//
//  YDBadgeValueButton.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDBadgeValueButton.h"
#import "UIImage+YDStretchImage.h"

@implementation YDBadgeValueButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.enabled = NO ;
        [self setBackgroundImage:[UIImage resizableImageWithName:@"main_badge_os7@2x.png"] forState:UIControlStateNormal] ;
        self.titleLabel.font = [UIFont systemFontOfSize:11] ;
    }
    return self ;
}



// 重写setBadgeValue 方法 
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy] ;
    
    if (badgeValue ) {
        self.hidden = NO;
        //  设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        //  设置提醒窗口尺寸，位置在外面设置（封装思想）
        CGFloat badageButtonH = self.currentBackgroundImage.size.height;
        CGFloat badageButtonW = self.currentBackgroundImage.size.width ;
        if (badgeValue.length > 1) {
            //  文字的尺寸
            NSDictionary * dictionaryxx =@{NSFontAttributeName:self.titleLabel.font} ;
            CGSize badgeSize = [badgeValue sizeWithAttributes:dictionaryxx] ;
            badageButtonW = badgeSize.width + 10 ;
        }
        self.frame = CGRectMake(0, 0, badageButtonW, badageButtonH);
    }else
    {
        self.hidden = YES ;
    }
}

@end
