//
//  YDRouteSelectView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDRouteSelectView.h"

@implementation YDRouteSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        CGFloat range = 5 ;
        CGFloat textFiledW = self.frame.size.width  ;
        CGFloat textFiledH = (self.frame.size.height - 2 * range)/3 ;
        
        YDTextFiled * startTextFiled = [[YDTextFiled alloc]initWithFrame:CGRectMake(0, 0,textFiledW , textFiledH)] ;
        [self addSubview:startTextFiled] ;
        [startTextFiled setupLabelText:@"起点:" textFieldPlaceholder:@"请输入起点"];
        self.startTextFiled = startTextFiled ;
        
        YDTextFiled * endTextFiled = [[YDTextFiled alloc]initWithFrame:CGRectMake(0, textFiledH + range,textFiledW, textFiledH)] ;
        [self addSubview:endTextFiled] ;
        [endTextFiled setupLabelText:@"终点:" textFieldPlaceholder:@"请输入终点"];
        self.endTextFiled = endTextFiled ;
        
        self.selectButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, textFiledH)] ;
        self.selectButton.center = CGPointMake(textFiledW/2.0f, 2.0 * (textFiledH + range) + textFiledH/2.0f);
        [self.selectButton setTitle:@"路线" forState:UIControlStateNormal] ;
        self.selectButton.backgroundColor = [UIColor cyanColor] ;
        [self addSubview:self.selectButton] ;
        
    }
    return self ;
}



@end
