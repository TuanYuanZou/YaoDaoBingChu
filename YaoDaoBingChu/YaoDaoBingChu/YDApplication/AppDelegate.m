//
//  AppDelegate.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "AppDelegate.h"
#import "YDTabBarController.h"


#import <BaiduMapAPI/BMapKit.h>

@interface AppDelegate ()

//  地图管理者
@property(nonatomic,strong)BMKMapManager * mapMabager ;

@end

@implementation AppDelegate

#pragma mark - 懒加载
- (BMKMapManager *)mapMabager
{
    if (!_mapMabager)
    {
        _mapMabager = [[BMKMapManager alloc]init];
    }
    return _mapMabager ;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    
    // 百度开发者账号：SM9YbHDeRtsqwG6GN22E4EDG
    BOOL ret = [self.mapMabager start:@"SM9YbHDeRtsqwG6GN22E4EDG"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    

    
    //  创建自定义 tabBarController对象，作为根视图控制器
    YDTabBarController * tabBarVc = [[YDTabBarController alloc]init] ;
    self.window.rootViewController = tabBarVc ;
    
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
