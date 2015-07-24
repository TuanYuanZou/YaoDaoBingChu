//
//  YDNavigationView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDNavigationView.h"

@implementation YDNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        CGFloat range = 5 ;
        CGFloat textFiledW = self.frame.size.width  ;
        CGFloat textFiledH = (self.frame.size.height - 1 * range)/2 ;
        
        YDTextFiled * destinationTextFiled = [[YDTextFiled alloc]initWithFrame:CGRectMake(0, 0,textFiledW , textFiledH)] ;
        [self addSubview:destinationTextFiled] ;
        [destinationTextFiled setupLabelText:@"目的地:" textFieldPlaceholder:@"请输入目的地"];
        self.destinationTextFiled = destinationTextFiled ;
        
        
        
        self.NavigationButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0 , 80, textFiledH)] ;
        self.NavigationButton.center = CGPointMake(textFiledW / 2.0f, textFiledH + range + textFiledH / 2.0f) ;
        [self.NavigationButton setTitle:@"乘车" forState:UIControlStateNormal] ;
        [self.NavigationButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        self.NavigationButton.backgroundColor = [UIColor cyanColor] ;
        self.NavigationButton.tag = 100 ;
        [self addSubview:self.NavigationButton] ;
        
        
        
        
    }
    return self ;
}


@end
