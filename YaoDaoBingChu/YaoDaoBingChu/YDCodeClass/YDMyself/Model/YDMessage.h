//
//  YDMessage.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDMessage : NSObject
//  留言编号
@property(nonatomic,assign)NSInteger ID ;
//  留言内容
@property(nonatomic,strong)NSString * message;
//  作者
@property(nonatomic,strong)NSString * author;
//  图片
@property(nonatomic,strong)UIImage * image;


@end
