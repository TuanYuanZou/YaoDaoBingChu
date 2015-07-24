//
//  OrderPlayView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "OrderPlayView.h"

@implementation OrderPlayView

@synthesize scrollView, slideImages;
@synthesize pageControl;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    // 定时器 循环
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    // 初始化 scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    // 初始化 数组 并添加四张图片
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"lunbo1.jpg"];
    [slideImages addObject:@"lunbo2.jpg"];
    [slideImages addObject:@"lunbo3.jpg"];
    [slideImages addObject:@"lunbo4.jpg"];
    // 初始化 pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth - 100) / 2,165,100,10)]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
    [pageControl setPageIndicatorTintColor:[UIColor redColor]];
    pageControl.numberOfPages = [self.slideImages count];
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self addSubview:pageControl];
    // 创建四个图片 imageview
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((kScreenWidth * i) + kScreenWidth, 0, kScreenWidth, 180);
        [scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count] - 1)]]];
    imageView.frame = CGRectMake(0, 0, kScreenWidth, 180); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((kScreenWidth * ([slideImages count] + 1)) , 0, kScreenWidth, 180); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(kScreenWidth * ([slideImages count] + 2), 180)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth,0,kScreenWidth,180) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    }
    return self;
}
// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([slideImages count] + 2))/pagewidth) + 1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([slideImages count] + 2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/375; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage == 0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * [slideImages count],0,kScreenWidth,180) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([slideImages count] + 1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth,0,kScreenWidth,180) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = (int)pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(kScreenWidth * (page + 1),0,kScreenWidth,180) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = (int)pageControl.currentPage; // 获取当前的page
    page++;
    page = page > (slideImages.count - 1) ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}

@end
