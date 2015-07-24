//
//  YDPlaceholderTextView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDPlaceholderTextView.h"


@implementation YDPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        
        //   通知
        //   Observer:---通知的关注者
        //   object:通知的发出者（一旦YDPlaceholderTextView的输入文字改变，就会自己自动发出UITextViewTextDidChangeNotification通知）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self] ;
        //self.font = [UIFont systemFontOfSize:20] ;
        
    }
    
    return self ;
}


- (void)textDidChange
{
    //  重绘
    [self setNeedsDisplay] ;
    
}


- (void)drawRect:(CGRect)rect
{
    //  当输入控件中无内容，就绘制占位符
    if (self.text.length == 0) {
        NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = self.placeholderColor  ? self.placeholderColor : [UIColor grayColor];
        attrs[NSFontAttributeName] = self.font ? self.font : [UIFont systemFontOfSize:12];
        //  把文字画到矩形框中
        CGFloat x = 5 ;
        CGFloat y = 8 ;
        CGFloat w = kScreenWidth - 2.0f * x ;
        CGFloat h = kScreenHeight - 2.0f * y ;
        CGRect placeHolderRect = CGRectMake(x,y, w,h) ;
        [self.placeholder drawInRect:placeHolderRect withAttributes:attrs] ;
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay] ;
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor ;
    [self setNeedsDisplay] ;
}


- (void)setText:(NSString *)text
{
    [super setText:text] ;
    [self setNeedsDisplay] ;
}


//  重写设置属性文字的方法
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText] ;
    //  重绘
    [self setNeedsDisplay] ;
    
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font] ;
    [self setNeedsDisplay] ;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}





@end
