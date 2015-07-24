//
//  YDBottomView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDBottomView.h"
#import "YDLeftButton.h"

@implementation YDBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor] ;
        self.nearby = [self setupButtonWithTitle:@"附近药店" image:@"nearby.png" index:0];
        self.route = [self setupButtonWithTitle:@"路线查询" image:@"route.png" index:1];
        self.Navigation = [self setupButtonWithTitle:@"导航开始" image:@"navigation.png" index:2];
        self.more = [self setupButtonWithTitle:@"更多内容" image:@"more.png" index:3];
        
        
        
    }
    return self ;
}


#pragma mark - 创建每一按钮
- (YDLeftButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image index:(int)index
{
    YDLeftButton * button = [[YDLeftButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 4.0f * index, 0, self.frame.size.width / 4.0f , self.frame.size.height)] ;
    [self addSubview:button] ;
    button.titleLabel.font = [UIFont systemFontOfSize:12] ;
    button.tag = (index + 1) * 100 ;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button ;
}


- (void)buttonAction:(UIButton *)sender
{
    if (self.bottomViewButtonBlock == nil) {
        return ;
    }
    self.bottomViewButtonBlock(sender);
}
@end
