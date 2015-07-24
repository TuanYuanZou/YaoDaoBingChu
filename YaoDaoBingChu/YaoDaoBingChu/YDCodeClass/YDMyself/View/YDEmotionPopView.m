//
//  YDEmotionPopView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionPopView.h"
#import "YDEmotion.h"
#import "YDEmotionButton.h"

@interface YDEmotionPopView ()

@property (strong, nonatomic) IBOutlet YDEmotionButton *EmotionButton;

@end

@implementation YDEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"YDEmotionPopView" owner:nil options:nil] lastObject] ;
}




//  根据按钮显示放大镜（确定放大镜的位置）
- (void)showPopViewFrom:(YDEmotionButton *)sender
{
    if (!sender) {
        return ;
    }
    
    self.EmotionButton.emotion = sender.emotion ;
    
    //  1.取得最上面的window
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject] ;
    [window addSubview:self] ;
    //  2.计算出被点击的按钮在window中的frame
    CGRect btnRect = [sender convertRect:sender.bounds toView:nil] ;
    
    // 3.计算popView在window的位置
    CGFloat btnCenterX = btnRect.origin.x + sender.frame.size.width / 2.0f ;
    CGFloat btnCenterY = btnRect.origin.y + sender.frame.size.height / 2.0f ;
    CGFloat popViewCenterX = btnCenterX ;
    CGFloat popViewCenterY = btnCenterY - self.frame.size.height / 2.0;
    self.center = CGPointMake(popViewCenterX, popViewCenterY) ;
    
    
}




@end
