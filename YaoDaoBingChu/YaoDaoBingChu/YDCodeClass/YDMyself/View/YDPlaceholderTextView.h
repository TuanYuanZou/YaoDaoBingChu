//
//  YDPlaceholderTextView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>


//  增强版的textView，有占位符功能

@interface YDPlaceholderTextView : UITextView

//   占位文字
@property(nonatomic,copy)NSString * placeholder ;
//   占位文字颜色
@property(nonatomic,strong)UIColor * placeholderColor ;





@end
