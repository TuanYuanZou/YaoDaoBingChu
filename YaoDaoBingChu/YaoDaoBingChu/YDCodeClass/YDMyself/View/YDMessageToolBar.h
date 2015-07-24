//
//  YDMessageToolBar.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    YDMessageToolBarButtonTypeCamera ,  //  拍照
     YDMessageToolBarButtonTypePicture ,//  图片
     YDMessageToolBarButtonTypeMention ,//  @
     YDMessageToolBarButtonTypeTrend ,  //  #
     YDMessageToolBarButtonTypeEmotion ,//  表情
} YDMessageToolBarButtonType ;



@interface YDMessageToolBar : UIView


@property(nonatomic,copy)void (^didClinkButton)(UIButton * bnt) ;

@property(nonatomic,assign)BOOL isShowEmotionKeyboardButton ;

@end
