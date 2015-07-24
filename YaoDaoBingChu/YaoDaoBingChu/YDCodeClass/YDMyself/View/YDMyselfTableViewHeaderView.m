
//
//  YDMyselfTableViewHeaderView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMyselfTableViewHeaderView.h"

@interface YDMyselfTableViewHeaderView ()
//  装载登陆按钮、注册按钮、用户头像、用户姓名
@property(nonatomic,strong)UIView * view ;
//  用户头像
@property(nonatomic,strong)UIButton * headIcon ;
//  登陆按钮
@property(nonatomic,strong)UIButton * loginButton;
//  注册按钮
@property(nonatomic,strong)UIButton * registeredButton;

// 定时器
@property(nonatomic,strong)CADisplayLink * link ;
@end



@implementation YDMyselfTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * view = [[UIView alloc]init] ;
        view.backgroundColor = [UIColor blueColor] ;
        [self addSubview:view] ;
        self.view = view ;
        
        
        UIButton * headIcon = [[UIButton alloc]init] ;
        [headIcon setImage:[UIImage imageNamed:@"headIcon.png"] forState:UIControlStateNormal] ;
        [view addSubview:headIcon] ;
        self.headIcon = headIcon ;
        
        
        
        UIButton * loginButton = [[UIButton alloc]init] ;
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal] ;
        loginButton.layer.cornerRadius = 5 ;
        loginButton.layer.borderWidth = 1 ;
        loginButton.layer.borderColor = [[UIColor whiteColor]CGColor] ;
        loginButton.layer.masksToBounds = YES ;
        [view addSubview:loginButton] ;
        self.loginButton = loginButton ;
        
        
        
        UIButton * registeredButton = [[UIButton alloc]init] ;
        [registeredButton setTitle:@"注册" forState:UIControlStateNormal] ;
        registeredButton.layer.cornerRadius = 5 ;
        registeredButton.layer.borderWidth = 1 ;
        registeredButton.layer.borderColor = [[UIColor whiteColor]CGColor] ;
        registeredButton.layer.masksToBounds = YES ;
        [view addSubview:registeredButton] ;
        self.registeredButton = registeredButton ;
        
        self.backgroundColor = kColor(245, 245, 245);
        
        [self startRotation];
        
    }
    return self ;
}


- (void)layoutSubviews
{
    //  view 距离self底部的距离
    CGFloat viewToBottonRange = 40 ;
    self.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height -viewToBottonRange);
    
    
    
    NSUInteger count = self.view.subviews.count ;
    //  按钮水平间距
    CGFloat horizontalRange = 30 ;
    //  按钮垂直间距
    CGFloat verticalRange  = 65 ;
    CGFloat ButtonW = (self.view.frame.size.width - (count + 1)*horizontalRange)/count ;
    CGFloat ButtonH = self.view.frame.size.height - 2 * verticalRange ;
    
    
    CGFloat buttonCenterY = verticalRange + ButtonH / 2.0f ;
    CGFloat NearbybuttonCenterRange = horizontalRange + ButtonW ;
    CGFloat FirstButtonCenterLeftRange = horizontalRange + ButtonW / 2.0f ;
    
    self.headIcon.bounds = CGRectMake(0, 0, ButtonW, ButtonW) ;
    self.headIcon.center = CGPointMake(FirstButtonCenterLeftRange , buttonCenterY) ;
    
    self.loginButton.bounds = CGRectMake(0, 0, ButtonW, ButtonH) ;
    self.loginButton.center = CGPointMake(FirstButtonCenterLeftRange + NearbybuttonCenterRange , buttonCenterY) ;
    
    self.registeredButton.bounds = CGRectMake(0, 0, ButtonW, ButtonH) ;
    self.registeredButton.center = CGPointMake(FirstButtonCenterLeftRange + NearbybuttonCenterRange * 2.0f, buttonCenterY) ;
}



//  开始慢悠悠的不停旋转
- (void)startRotation
{
    CABasicAnimation * basicAnimation =[CABasicAnimation animation] ;
    basicAnimation.keyPath = @"transform.rotation";
    basicAnimation.toValue = @(2 * M_PI);
    basicAnimation.repeatCount = MAXFLOAT ;
    basicAnimation.duration = 10 ;
    [self.headIcon.layer addAnimation:basicAnimation forKey:nil] ;

}




@end
