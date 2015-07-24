//
//  YDTabBarController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDTabBarController.h"
#import "YDNavagationController.h"

#import "YDMyselfViewController.h"
#import "YDNearbyViewController.h"
#import "YDHealthClassViewController.h"
#import "YDMainPageViewController.h"
#import "YDLeftViewController.h"


#import "YDTabBar.h"


// 抽屉
#import "MMDrawerController.h"



@interface YDTabBarController ()<YDTabBarDelegate>

//  保存 barItemTitle主题
@property(nonatomic,strong)NSArray * barItemTitles ;
//  保存 barItemIcon图片
@property(nonatomic,strong)NSArray * barItemIcons ;

//  自定义的tabBar
@property(nonatomic,strong)YDTabBar * customTabBar ;

@end

@implementation YDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  初始化 tabBar
    [self setupTabBar] ;
    
    //  初始化所有子控制器
    [self setupAllChildViewController];
}



#pragma mark - 将原来tabBar上的四个按钮 删除掉
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    for (UIView * childer in self.tabBar.subviews)
    {
        if ([childer isKindOfClass:[UIControl class]])
          {
              [childer removeFromSuperview] ;
          }
    }
}


#pragma mark -初始化自定义的tabBar
- (void)setupTabBar
{
    YDTabBar * customTabBar = [[YDTabBar alloc]init] ;
    //customTabBar.backgroundColor = [UIColor blueColor] ;
        
    customTabBar.frame = self.tabBar.bounds ;
    customTabBar.delegate = self ;
    self.customTabBar = customTabBar ;
    //  把自定义的tabBar 加载到系统自带的 tabBar 上面
    //  优点：当页面跳转的时候，系统会把自带的tabBar 给移除，同时我们自定义的 tabBar 也被移除了 。
    [self.tabBar addSubview:customTabBar] ;
}

#pragma mark - 初始化所有子控制器
- (void)setupAllChildViewController
{
    /*   1.第一个子控制器是一个抽屉控制器   */
    [self setupFirstController] ;
    
    /*   2.健康大讲堂     */
    
    YDHealthClassViewController * healthClassVc = [[YDHealthClassViewController alloc]init] ;
    [self addChildViewController:healthClassVc image:self.barItemIcons[1] title:self.barItemTitles[1]];
    
    
    /*   3.附近区     */
    YDNearbyViewController * nearbyVc = [[YDNearbyViewController alloc]init] ;
    [self addChildViewController:nearbyVc image:self.barItemIcons[2] title:self.barItemTitles[2]];
    
    
    /*   4.我     */
    YDMyselfViewController * myselfVc = [[YDMyselfViewController alloc]init] ;
    myselfVc.tabBarItem.badgeValue = @"new" ;
    [self addChildViewController:myselfVc image:self.barItemIcons[3] title:self.barItemTitles[3]];
    
    

}
#pragma mark - 初始化第一个子控制器  
- (void)setupFirstController
{
    // 中间抽屉控制器
    YDMainPageViewController * rootVc = [[YDMainPageViewController alloc]init] ;
    UINavigationController * rootNav = [[UINavigationController alloc]initWithRootViewController:rootVc] ;
    //  左抽屉控制器
    YDLeftViewController * leftVc = [[YDLeftViewController alloc]init] ;
    UINavigationController * leftNav = [[UINavigationController alloc]initWithRootViewController:leftVc] ;
    //  创建抽屉对象
    MMDrawerController * drawerViewVc = [[MMDrawerController alloc]initWithCenterViewController:rootNav leftDrawerViewController:leftNav];
    [drawerViewVc setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll] ;
    [drawerViewVc setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll] ;
    drawerViewVc.title = self.barItemTitles[0] ;
    drawerViewVc.tabBarItem.image = [UIImage imageNamed:self.barItemIcons[0]];
    [self addChildViewController:drawerViewVc];
    
    //  3.添加tabBar 内部的按钮
    [self.customTabBar addTabBarButtonWithItem:drawerViewVc.tabBarItem] ;
    
    
    
}

#pragma mark - 初始化除第一个的子控制器
- (void)addChildViewController:(UIViewController *)childController image:(NSString *)image title:(NSString *)title
{
    //  1.设置控制器的属性
    childController.title = title ;
    childController.tabBarItem.image = [UIImage imageNamed:image] ;
    
    
    //  2.用 childController包装一个导航控制器
    YDNavagationController * navigationVc = [[YDNavagationController alloc]initWithRootViewController:childController] ;
    [self addChildViewController:navigationVc] ;
    
    //  3.添加tabBar 内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childController.tabBarItem] ;
    
    
    
}


#pragma mark - 懒加载barItem的Title
- (NSArray *)barItemTitles
{
    if (!_barItemTitles) {
        _barItemTitles = @[@"群药荟萃",@"健康频道",@"附近查找",@"我的地盘"];
    }
    return _barItemTitles ;
}


#pragma mark - 懒加载barItem的icon
- (NSArray *)barItemIcons
{
    if (!_barItemIcons) {
        _barItemIcons = @[@"tabbar_homepage_selected@3x.png",@"tabbar_homepage_selected@3x.png",@"tabbar_vicinity_normal@3x.png",@"tabbar_mine_selected@3x.png"];
    }
    return _barItemIcons ;
    
}


#pragma mark - YDTabBarDelegate协议方法：点击tabBarItem 时，显示对应的Controller
- (void)tarBar:(YDTabBar *)tarBar fromTabBarItemIndex:(NSInteger)fromIndex toTabBarItemIndex:(NSInteger)toIndex
{
    self.selectedIndex = toIndex ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
