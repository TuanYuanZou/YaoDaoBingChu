//
//  YDMessageToolBar.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMessageToolBar.h"

@interface YDMessageToolBar ()

@property(nonatomic,strong)UIButton * emotionButton ;

@end





@implementation YDMessageToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self)
    {
        //  设置背景颜色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background@2x.png"]] ;
        
        [self setupButtonWithImage:@"compose_camerabutton_background@2x.png" selectImage:@"compose_camerabutton_background_highlighted@2x.png"type:YDMessageToolBarButtonTypeCamera] ;
        [self setupButtonWithImage:@"compose_toolbar_picture@2x.png" selectImage:@"compose_toolbar_picture_highlighted@2x.png"type:YDMessageToolBarButtonTypePicture] ;
        [self setupButtonWithImage:@"compose_mentionbutton_background@2x.png" selectImage:@"compose_mentionbutton_background_highlighted@2x.png"type:YDMessageToolBarButtonTypeMention] ;
        [self setupButtonWithImage:@"compose_trendbutton_background@2x.png" selectImage:@"compose_trendbutton_background_highlighted@2x.png"type:YDMessageToolBarButtonTypeTrend] ;
        self.emotionButton = [self setupButtonWithImage:@"compose_emoticonbutton_background@2x.png" selectImage:@"compose_emoticonbutton_background_highlighted@2x.png"type:YDMessageToolBarButtonTypeEmotion] ;
    }
    return self ;
}


- (UIButton *)setupButtonWithImage:(NSString *)image selectImage:(NSString *)selectImage type:(YDMessageToolBarButtonType)type
{
    UIButton * btn = [[UIButton alloc]init] ;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal] ;
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted] ;
    [btn addTarget:self action:@selector(didClink:) forControlEvents:UIControlEventTouchUpInside] ;
    btn.tag  =  type ;
    [self addSubview:btn] ;
    return btn ;
}

- (void)layoutSubviews
{
    NSUInteger cont = self.subviews.count ;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width / cont ;
    CGFloat h = self.frame.size.height;
    for (NSUInteger i  = 0; i < cont; i++) {
        UIButton * btn = self.subviews[i] ;
        CGFloat x = w * i ;
        btn.frame = CGRectMake(x, y, w, h) ;
    }
}

- (void)didClink:(UIButton *)sender
{
    if (self.didClinkButton == nil) {
        return ;
    }
    self.didClinkButton(sender) ;
   
}

- (void)setIsShowEmotionKeyboardButton:(BOOL)isShowEmotionKeyboardButton
{
    _isShowEmotionKeyboardButton = isShowEmotionKeyboardButton ;
    if (_isShowEmotionKeyboardButton)
    {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background@2x.png"] forState:UIControlStateNormal] ;
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted@2x.png"] forState:UIControlStateHighlighted] ;
    }
    else
    {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background@2x.png"] forState:UIControlStateNormal] ;
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted@2x.png"] forState:UIControlStateHighlighted] ;
    }
}
@end
