//
//  YDEmotionButton.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDEmotion.h"


@interface YDEmotionButton : UIButton

//  一个按钮对应一个Emotion模型
@property(nonatomic,strong)YDEmotion * emotion ;

@end
