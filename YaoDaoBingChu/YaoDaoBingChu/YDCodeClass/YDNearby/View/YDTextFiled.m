//
//  YDTextFiled.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDTextFiled.h"

#define YDTextFiledCornerRadius 5

@implementation YDTextFiled


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        self.layer.cornerRadius = YDTextFiledCornerRadius ;
        self.layer.borderWidth = 1 ;
        self.layer.borderColor = [[UIColor blueColor]CGColor] ;
        self.layer.masksToBounds = YES ;
        
        CGFloat LabelX = YDTextFiledCornerRadius * 1.2 ;
        CGFloat LabelY = 0 ;
        CGFloat LabelW = frame.size.width/3.0f  - YDTextFiledCornerRadius * 1.2;
        CGFloat LabelH = frame.size.height ;
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(LabelX, LabelY, LabelW, LabelH) ];
        self.label.font = [UIFont systemFontOfSize:13] ;
        [self addSubview:self.label] ;
        
        
        CGFloat textFiledX = frame.size.width/3.0f  ;
        CGFloat textFiledY = 0 ;
        CGFloat textFiledW = frame.size.width/3.0f * 2.0f - YDTextFiledCornerRadius * 1.2  ;
        CGFloat textFiledH = frame.size.height ;
        self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(textFiledX, textFiledY, textFiledW, textFiledH ) ] ;
        [self addSubview:self.textFiled] ; 
        
    }
    return self ;
}


- (void)setupLabelText:(NSString *)labelText textFieldPlaceholder:(NSString *)Placeholder ;
{
    self.textFiled.placeholder = Placeholder ;
    [self.textFiled setValue:[UIFont boldSystemFontOfSize:10] forKeyPath:@"_placeholderLabel.font"];
    self.label.text = labelText ;
}
@end
