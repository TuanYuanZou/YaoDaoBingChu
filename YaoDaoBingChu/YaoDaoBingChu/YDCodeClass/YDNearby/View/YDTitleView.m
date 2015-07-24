//
//  YDTitleView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDTitleView.h"


@implementation YDTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        CGFloat range = 5 ;
        CGFloat textFiledW = (self.frame.size.width - range) /2 ;
        CGFloat textFiledH = self.frame.size.height ;
        
        YDTextFiled * city = [[YDTextFiled alloc]initWithFrame:CGRectMake(0, 0,textFiledW , textFiledH)] ;
        [self addSubview:city] ;
        [city setupLabelText:@"城市:" textFieldPlaceholder:@"请输入城市名"];
        self.city = city ;
        
        YDTextFiled * content = [[YDTextFiled alloc]initWithFrame:CGRectMake(textFiledW + range, 0,textFiledW, textFiledH)] ;
        [self addSubview:content] ;
        [content setupLabelText:@"内容:" textFieldPlaceholder:@"请输入搜索内容"];
        self.content = content ;
        
    }
    return self ;
}

@end
