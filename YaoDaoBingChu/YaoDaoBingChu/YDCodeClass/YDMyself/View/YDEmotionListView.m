//
//  YDEmotionListView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/19.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDEmotionListView.h"
#import "YDEmotionPageView.h"



//  每一页表情个数
#define kEmotionPageSize 20

@interface YDEmotionListView ()<UIScrollViewDelegate>
//  滚动视图
@property(nonatomic,strong)UIScrollView * scrollView ;
//  page
@property(nonatomic,strong)UIPageControl * page ;

@end



@implementation YDEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        //  UIScrollView
        UIScrollView * scrollView = [[UIScrollView alloc]init] ;
        scrollView.delegate = self ;
        scrollView.pagingEnabled = YES ;
        scrollView.showsHorizontalScrollIndicator = NO ;
        scrollView.showsVerticalScrollIndicator = NO ;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView] ;
        self.scrollView = scrollView ;
        
        
        //  UIPageController
        UIPageControl * page = [[UIPageControl alloc]init ] ;
        //  当只有一个点时，隐藏pageVc
        page.hidesForSinglePage = YES ;
        page.userInteractionEnabled = NO ;
        //  设置内部圆点图片
        [page setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected@2x.png"] forKey:@"currentPageImage"] ;
        [page setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal@2x.png"] forKey:@"pageImage"] ;
        page.backgroundColor = [UIColor whiteColor] ;
        [self addSubview:page ] ;
        self.page = page ;
    }
    return self ;
}

- (void)layoutSubviews
{
    //  page 的 frame
    CGFloat pageH = 30 ;
    CGFloat pageX = 0 ;
    CGFloat pageY = self.frame.size.height - pageH;
    CGFloat pageW = self.frame.size.width;     
    self.page.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    
    //  scrollView 的 frame
    CGFloat scrollViewX = 0 ;
    CGFloat scrollViewY = 0 ;
    CGFloat scrollViewW = self.frame.size.width;
    CGFloat scrollViewH = pageY ;
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    //  设置scrollView内部每一页的尺寸
    CGFloat viewY = 0 ;
    CGFloat viewW = self.scrollView.frame.size.width ;
    CGFloat viewH = self.scrollView.frame.size.height ;
    CGFloat viewX = 0  ;
    NSInteger count = self.scrollView.subviews.count ;
    for (int i = 0 ; i < count; i++) {
        viewX = viewW * i ;
        YDEmotionPageView * pageView = (YDEmotionPageView *)self.scrollView.subviews[i] ;
        pageView.frame = CGRectMake(viewX, viewY, viewW, viewH) ;
    }
    //  设置scrollView的内容区域
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * count, 0) ;
}








- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions ;
    //  设置页数
    NSUInteger numberOfPages = (self.emotions.count + kEmotionPageSize - 1 )/ kEmotionPageSize ;
    
    self.page.numberOfPages = numberOfPages ;
    //  创建用来显示每一页表情的控件
    for (int i = 0 ; i < numberOfPages ; i++)
    {
        YDEmotionPageView * pageView = [[YDEmotionPageView alloc]init] ;
        
        //  截取子数组区间
        NSRange range ;
        range.location = i * kEmotionPageSize ;
        if (emotions.count - range.location >= kEmotionPageSize) {
            range.length = kEmotionPageSize ;
        }
        else {
            range.length = emotions.count - range.location ;
            
        }        
        
        //  设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView] ;
    }
}

#pragma - mark 绑定scrollView和pageController
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.page.currentPage = (int)(pageNo + 0.5);
    
}
@end
