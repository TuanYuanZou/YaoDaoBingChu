//
//  OrderPlayView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPlayView : UIView<UIScrollViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray;

@end
