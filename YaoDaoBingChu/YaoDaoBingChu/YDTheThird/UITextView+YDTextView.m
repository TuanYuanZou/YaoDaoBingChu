//
//  UITextView+YDTextView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "UITextView+YDTextView.h"

@implementation UITextView (YDTextView)


- (void)insertattributedText:(NSAttributedString *)aAttributedString
{
    //  1.创建 NSMutableAttributedString（带有属性的字符串）
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]init] ;
    //  2.拼接之前的图文
    [attrString appendAttributedString:self.attributedText] ;
    
    //  3.插入图片----selectedRange:确定光标选中的范围
    NSRange range = self.selectedRange ;
    //  将内容插入光标位置
    //[attrString insertAttributedString:aAttributedString atIndex:range.location] ;
    //  替换光标选中的内容
    [attrString replaceCharactersInRange:range withAttributedString:aAttributedString] ;
    
    
    
    self.attributedText = attrString ;
    //  移动光标到所插入图片的后面
    self.selectedRange = NSMakeRange(range.location + 1, 0) ;
    

}



@end
