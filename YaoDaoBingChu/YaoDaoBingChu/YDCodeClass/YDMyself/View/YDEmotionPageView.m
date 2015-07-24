//
//  YDEmotionPageView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionPageView.h"
#import "YDEmotion.h"
#import "YDEmotionPopView.h"
#import "YDEmotionButton.h"



//  最大有多少行按钮
#define kMaxRow 3
//  最大有多少列按钮
#define kMaxColumn 7

@interface YDEmotionPageView ()

// 点击表情后弹出的放大镜
@property(nonatomic,strong)YDEmotionPopView * popView ;

@property(nonatomic,strong)YDEmotionButton * deleteButton ;

@end


@implementation YDEmotionPageView
#pragma mark - 懒加载
- (YDEmotionPopView *)popView
{
    if (!_popView) {
        _popView = [YDEmotionPopView popView] ;
    }
    return _popView ;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        //  1.删除按钮
        YDEmotionButton * deleteButton = [[YDEmotionButton alloc]init] ;
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete@2x.png"] forState:UIControlStateNormal] ;
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted@2x.png"] forState:UIControlStateHighlighted] ;
        self.deleteButton = deleteButton ;
        [self addSubview:deleteButton] ;
        [deleteButton addTarget:self action:@selector(deleteButtonClink:) forControlEvents:UIControlEventTouchUpInside] ;
        //  2.添加长按手势
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)] ;
        [self addGestureRecognizer:longPress] ;
    }
    return self ;
}


//  根据手指位置找到对应的按钮
- (YDEmotionButton *)emotionButtotnWithLocation:(CGPoint)location
{
    NSInteger count = self.emotions.count ;
    YDEmotionButton * emotionButton = nil;
    for (int i = 0 ; i < count; i++) {
        emotionButton = self.subviews[i] ;
        if (CGRectContainsPoint(emotionButton.frame, location))
        {//  已经找到手指所在的表情按钮。
            break ;
        }
    }
    return emotionButton ;
}

#pragma mark - 长按手势触发方法
- (void)longPress:(UILongPressGestureRecognizer *)lonPress
{
    //  获得手指在视图上的位置
    CGPoint location = [lonPress locationInView:lonPress.view] ;
    //  获得手指所在的按钮
    YDEmotionButton * btn = [self emotionButtotnWithLocation:location] ;
    
    switch (lonPress.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            //  移除放大镜
            [self.popView removeFromSuperview] ;
            //  如果手指还在表情按钮上
            if (btn) {//  发出通知
                //  发出表情按钮被点击的通知
                if (btn.emotion )
                {
                    NSMutableDictionary * userInfo = [NSMutableDictionary dictionary] ;
                    userInfo[@"selectEmotion"] = btn.emotion ;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"YDEmotionDidChoiceNotification" object:nil userInfo:userInfo] ;
                }
                
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            //  显示放大镜
            [self.popView showPopViewFrom:btn];
             break;
        }
        case UIGestureRecognizerStateBegan:
            NSLog(@"手势开始");
            break;
        default:
            break;
    }
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions ;
    NSUInteger count = emotions.count ;
    
    for (int i = 0; i < count; i++) {
        YDEmotionButton * btn = [[YDEmotionButton alloc]init] ;
        YDEmotion * emotion = emotions[i] ;
       
        //  设置表情数据
        btn.emotion = emotion ;        
        
        [self addSubview:btn] ;
        
        //CUICatalog: Invalid asset name supplied: (null)
        //  警告原因：尝试加载的图片不存在
        
        //  监听
        [btn addTarget:self action:@selector(clinkButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)layoutSubviews
{
    CGFloat btnBottonRange = 0 ;
    CGFloat btnLeftRange = 5 ;
    CGFloat btnTopRange = 5 ;
    CGFloat btnRightRange = 5 ;
    
    CGFloat btnW = (self.frame.size.width - btnLeftRange - btnRightRange)/ kMaxColumn ;
    CGFloat btnH = (self.frame.size.height - btnBottonRange - btnTopRange) / kMaxRow;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    NSUInteger count = self.subviews.count - 1;
    //  每一页表情的行数
    NSUInteger row = (count + kMaxColumn - 1) / kMaxColumn ;
    //  每一行的列数
    NSUInteger column = kMaxColumn ;
    int i ,j ;
    for ( i = 0 ; i < row ; i++) {
        if (i == row - 1) {
            column = count - i * kMaxColumn ;
        }
        for ( j = 0 ; j < column; j++) {
            btnX = j * btnW + btnLeftRange;
            btnY = i * btnH + btnTopRange ;
            
            YDEmotionButton * btn = self.subviews[i * kMaxColumn + j + 1 ] ;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH) ;
        }
    }
    btnX = j * btnW + btnLeftRange;
    btnY = (i - 1) * btnH + btnTopRange ;
    self.deleteButton.frame = CGRectMake(btnX, btnY, btnW, btnH) ;
}


#pragma mark - 监听表情按钮
- (void)clinkButton:(YDEmotionButton *)sender
{
    //  显示popView
    [self.popView showPopViewFrom:sender] ;
    
    
       
    
    
    //  在一定时间间隔后，将popView移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    
    //  发出表情按钮被点击的通知
    NSMutableDictionary * userInfo = [NSMutableDictionary dictionary] ;
    userInfo[@"selectEmotion"] = sender.emotion ;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"YDEmotionDidChoiceNotification" object:nil userInfo:userInfo] ;
}


//  监听---删除按钮
- (void)deleteButtonClink:(UIButton *)sender
{
    //  发出删除按钮被点击的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"YDEmotionDeleteButtonClink" object:nil userInfo:nil] ;
}

@end
