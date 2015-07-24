//
//  YDMessagePhoneView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.



//  自定义一个相册视图，放了很多照片

#import <UIKit/UIKit.h>

@interface YDMessagePhonesView : UIView

//  将照片添加到自定义view上
- (void)addPhone:(UIImage *)image ;


//  保存相册中所有的图片
- (NSArray *)phones;
@end
