//
//  YDEmotion.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/19.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Emoji.h"

@interface YDEmotion : NSObject
//  表情的文字描述
@property(nonatomic,copy)NSString * chs;
//  表情的png图片名
@property(nonatomic,copy)NSString * png;
//   Emoji表情的16进制编码
@property(nonatomic,copy)NSString * code;


@end
