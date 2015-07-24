//
//  YDTextFiled.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDTextFiled : UIView

@property(nonatomic,strong)UITextField * textFiled ;
@property(nonatomic,strong)UILabel * label ;


//  设置标签 和 占位符
- (void)setupLabelText:(NSString *)labelText textFieldPlaceholder:(NSString *)Placeholder ;
@end
