//
//  YDEmotionPlaceholderTextView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionPlaceholderTextView.h"
#import "YDEmotion.h"
#import "YDTextAttachment.h"


@implementation YDEmotionPlaceholderTextView


//  插入表情
- (void)insertEmotion:(YDEmotion *)emotion
{
    if (emotion.code) {
        // 将普通文字插到光标所在的位置
        [self insertText:emotion.code.emoji] ;
    }
    else if (emotion.png)
    {
        //  1.加载图片
        YDTextAttachment * atta = [[YDTextAttachment alloc]init] ;
        //  传递Emotion模型
        atta.emotion = emotion ;
        
        //  2.得到文字高度
        CGFloat attaWH = self.font.lineHeight ;
        atta.bounds = CGRectMake(0, -3, attaWH, attaWH);
        
        
        //  3.根据附件创建一个属性文字
        NSAttributedString * imageString = [NSAttributedString attributedStringWithAttachment:atta] ;
        //  插入属性文字
        [self insertattributedText:imageString] ;
    }
}



- (NSString *)fullText
{
    NSMutableString * fullText = [NSMutableString string] ;
    //  遍历指定范围的attributedText(带属性的字符串)---普通文字 和 图片
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        //  获得这个范围的文字
        NSAttributedString * str = [self.attributedText attributedSubstringFromRange:range] ;
        //  如果是图片表情
        YDTextAttachment * atta = attrs[@"NSAttachment"] ;
        if (atta) {//  如果是图片表情----》对应的文本描述
            [fullText appendString:atta.emotion.chs] ;
        }else{//  非图片表情
            [fullText appendString:str.string] ;
        }        
    }] ;
    NSLog(@"%@",fullText);
    return fullText;
}


@end
