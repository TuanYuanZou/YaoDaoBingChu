//
//  YDTextAttachment.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDTextAttachment.h"

#import "YDEmotion.h"

@implementation YDTextAttachment

- (void)setEmotion:(YDEmotion *)emotion
{
    _emotion = emotion ;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
