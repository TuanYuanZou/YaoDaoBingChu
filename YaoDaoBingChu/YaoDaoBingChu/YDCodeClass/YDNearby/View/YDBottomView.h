//
//  YDBottomView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDLeftButton ;

@interface YDBottomView : UIView

//  附近
@property(nonatomic,strong)YDLeftButton * nearby ;
//  路线
@property(nonatomic,strong)YDLeftButton * route ;
//  导航
@property(nonatomic,strong)YDLeftButton * Navigation ;
//  更多
@property(nonatomic,strong)YDLeftButton * more ;

@property(nonatomic,copy)void (^bottomViewButtonBlock)(UIButton *sender );

@end
