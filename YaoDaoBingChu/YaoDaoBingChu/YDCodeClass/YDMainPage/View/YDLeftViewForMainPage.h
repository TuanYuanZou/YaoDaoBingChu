//
//  YDLeftViewForMainPage.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YDLeftViewForMainPage : UIView


//  block 回调
@property(nonatomic,copy)void (^leftButtonAction)(UIButton * sender );

@end
