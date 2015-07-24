//
//  YDEmotionButton.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 zlwz. All rights reserved.



#import "YDEmotionButton.h"

#import "NSString+Emoji.h"
@implementation YDEmotionButton
/*
 当控件不是从 xib、SB中创建时，就会调用这个方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        [self setup] ;
    }
    return self ;
}


/*
 反之：当控件从 xib、SB中创建时，就会调用下面这两个方法
 initWithCoder：从文件中解析xib文件
 awakeFromNib：该对象（self）从xib文件中苏醒过来
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder] ;
    if (self) {
         [self setup] ;
        
    }
    return self ;
}
- (void)awakeFromNib
{
    NSLog(@"awakeFromNib") ;
}


//  设置自定义按钮文字的大小
- (void)setup
{
    //  设置字体大小（Emoji就是文字）
    self.titleLabel.font = [UIFont systemFontOfSize:32] ;
    //  按钮高亮的时候不要去调整图片。（即长按按钮的时候按钮不会变黑）
    self.adjustsImageWhenHighlighted = NO ;
}


- (void)setEmotion:(YDEmotion *)emotion
{
    _emotion = emotion ;
    
    //  设置表情数据
    if (emotion.png) {
        //  找到 @“.png” 在字符串中 emotion.png的位置
        NSRange range = [emotion.png rangeOfString:@".png"] ;
        NSMutableString * pngStr = (NSMutableString *)[emotion.png mutableCopy] ;
        [pngStr insertString:@"@2x" atIndex:range.location] ;
        [self setImage:[UIImage imageNamed:pngStr] forState:UIControlStateNormal] ;
    }
    else
    {
        /**
         *  将十六进制的编码转为emoji字符
         */
        NSString * codeStr = [emotion.code emoji];
        [self setTitle:codeStr forState:
         UIControlStateNormal];
    }

}

@end
