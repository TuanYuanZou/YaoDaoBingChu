//
//  YDNearbyViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDNearbyViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <BaiduMapAPI/BMapKit.h>




#import "YDBottomView.h"
#import "YDRightView.h"
#import "YDTitleView.h"
#import "YDRouteSelectView.h"
#import "YDCompass.h"
#import "YDNavigationView.h"


#import "YDRouterSelectViewController.h"


@interface YDNearbyViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate,UITextFieldDelegate>
{
    //  记录当前展示的是搜索结果的第几页
    int _curPage ;
}

//  百度地图
@property(nonatomic,strong)BMKMapView * mapView ;
//  检索对象
@property(nonatomic,strong)BMKPoiSearch * poiSearch ;
//  定位服务
@property(nonatomic,strong)BMKLocationService * locationServer ;
//  地理编码
@property(nonatomic,strong)CLGeocoder * geocoder ;

//  导航栏自定义titleView
@property(nonatomic,strong)YDTitleView * titleView ;

//  路径查询View
@property(nonatomic,strong)YDRouteSelectView * routeSelectView ;
//  导航View
@property(nonatomic,strong)YDNavigationView * navigationView ;

//  指南针
@property(nonatomic,strong)YDCompass * compass ;








@end

@implementation YDNearbyViewController

#pragma mark - 懒加载
- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,0 ,kScreenWidth , kScreenHeight)] ;
    }
    return _mapView ;
    
}

- (BMKPoiSearch *)poiSearch
{
    if (!_poiSearch) {
        _poiSearch = [[BMKPoiSearch alloc]init] ;
        
    }
    return _poiSearch ;
    
}

- (BMKLocationService *)locationServer
{
    if (!_locationServer) {
        _locationServer = [[BMKLocationService alloc]init] ;
        _locationServer.delegate = self ;
    }
    return _locationServer ;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init] ;
    }
    return  _geocoder ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO ;
    [self.view addSubview:self.mapView] ;
    
    //  搭界面----block链式编程
    self.setupBottomView().setupRightView().setupTitleView().setupLeftRightBarButtonItem().setupCompass().setupRouteSelectView().setupNavigationView() ;
    
    //  启动定位服务
    [self starLocationServer] ;
}


#pragma mark - Map底部功能按钮
- (YDNearbyViewController *(^)())setupBottomView
{
    return ^{
        //  Map底部功能按钮
        CGFloat bottomViewX = 20 ;
        CGFloat DistanceToBottom = 150 ;
        CGFloat bottomViewY = kScreenHeight - DistanceToBottom ;
        CGFloat bottomViewW = kScreenWidth - 2 * bottomViewX ;
        CGFloat bottomViewH = 25 ;
        YDBottomView * bottomView = [[YDBottomView alloc]initWithFrame:CGRectMake(bottomViewX, bottomViewY, bottomViewW , bottomViewH)] ;
        bottomView.bottomViewButtonBlock = ^(UIButton * sender){[self bottonViewButtonAction:sender];} ;
        [self.view addSubview:bottomView] ;

        return self ;
    };
}

#pragma mark - map右侧辅助视图
- (YDNearbyViewController *(^)())setupRightView
{
    return ^{
        //  map右侧辅助视图
        CGFloat rangeToRight = 5 ;
        CGFloat rightViewW = 30 ;
        CGFloat rightViewX = kScreenWidth - rightViewW - rangeToRight ;
        CGFloat rightViewY = 10 ;
        CGFloat rightViewH = 180;
        YDRightView * rightView = [[YDRightView alloc]initWithFrame:CGRectMake(rightViewX, rightViewY, rightViewW, rightViewH)] ;
        rightView.TabBarButtonBlock = ^(UIButton * sender){ [self rightViewAction:sender] ;} ;
        [self.view addSubview:rightView] ;
        
        return self ;
    } ;
}

#pragma mark - 添加导航栏自定义titleView
- (YDNearbyViewController *(^)())setupTitleView
{
    return ^{
        //  添加导航栏自定义titleView
        YDTitleView * titleView =[[YDTitleView alloc]initWithFrame:CGRectMake(0, 0, 235, 20)] ;
        titleView.city.textFiled.delegate = self ;
        titleView.content.textFiled.delegate = self ;
        self.navigationItem.titleView = titleView ;
        self.titleView = titleView ;

        return self ;
    } ;
}

#pragma mark - 添加 navigationItem的左按钮 和 右按钮
- (YDNearbyViewController *(^)())setupLeftRightBarButtonItem
{
    return ^{
        //  添加 navigationItem的左按钮 和 右按钮
        UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchContentAtCity:)] ;
        self.navigationItem.leftBarButtonItem = leftBarButtonItem ;
        
        UIBarButtonItem * RightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(searchContentAtCityWithNextPage:)] ;
        self.navigationItem.rightBarButtonItem = RightBarButtonItem ;

        return self ;
    } ;
}

#pragma mark - 指南针
- (YDNearbyViewController *(^)())setupCompass
{
    return ^{
        //  指南针
        YDCompass * compass = [[YDCompass alloc]initWithFrame:CGRectMake(5, 5, 60, 60)] ;
        [self.view addSubview:compass] ;
        self.compass = compass ;
        

        return self ;
    } ;
}

#pragma mark - 路径查询View
- (YDNearbyViewController *(^)())setupRouteSelectView
{
    return ^{
        //  路径查询View
        self.routeSelectView = [[YDRouteSelectView alloc]initWithFrame:CGRectMake(0, 0, 150, 80)] ;
        self.routeSelectView.startTextFiled.textFiled.delegate = self ;
        self.routeSelectView.endTextFiled.textFiled.delegate = self ;
        self.routeSelectView.center = CGPointMake(140, 502);
        [self.routeSelectView.selectButton addTarget:self action:@selector(routeSelec:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:self.routeSelectView] ;
        self.routeSelectView.hidden = YES ;

        return self ;
    } ;
}

#pragma mark - 导航View
- (YDNearbyViewController *(^)())setupNavigationView
{
    return ^{
        //  导航View
        self.navigationView = [[YDNavigationView alloc]initWithFrame:CGRectMake(0, 0, 150, 55)] ;
        self.navigationView.destinationTextFiled.textFiled.delegate = self ;
        self.navigationView.center = CGPointMake(224, 514.5);
        [self.navigationView.NavigationButton addTarget:self action:@selector(startNavigation:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:self.navigationView] ;
        self.navigationView.hidden = YES ;

        return self ;
    } ;
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    self.mapView.delegate = self ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
    self.mapView.delegate = nil ;
    self.poiSearch.delegate = nil ;
}

#pragma mark - 地图底部功能按钮
- (void)bottonViewButtonAction:(UIButton * )sender
{
    switch (sender.tag) {
        case 100:
            //  搜索当前位置周边药店
            [self nearbySearch:sender] ;
            NSLog(@"附近");
            break;
            
        case 200:
         //  获取路线详细信息，并且绘制路径
            self.routeSelectView.hidden = NO ;
            break;
        case 300:
            //  导航
            self.navigationView.hidden = NO ;
            NSLog(@"导航");
            break;
            
        case 400:
            NSLog(@"更多");
            break;


            
        default:
            break;
    }
}

#pragma mark - 右侧功能按钮
- (void)rightViewAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            sender.selected = !sender.selected ;
            if (sender.selected) {
                //  卫星地图
                self.mapView.mapType = BMKMapTypeSatellite ;
            }
            else {
                //  标准地图
                self.mapView.mapType = BMKMapTypeStandard ;
            }
            break;
            
        case 200:
            sender.selected = !sender.selected ;
            if (sender.selected) {
                //  俯视 45度----取值0<--->45
                self.mapView.overlooking = - 45.0f;
            }
            else{
                //  俯视 0度
                self.mapView.overlooking = - 0.0f;
            }
            break;
            
            
        case 300:
            sender.selected = !sender.selected ;
            if (sender.selected) {
                //  打开实时交通
                [self.mapView setTrafficEnabled:YES] ;
            }
            else
            {
                //  关闭实时交通
                [self.mapView setTrafficEnabled:NO] ;
            }
            
            break;
            
        case 400:
        {
            //  地图定位到我当前位置
            CLLocationCoordinate2D center = self.locationServer.userLocation.location.coordinate ;
            [self currentShowContentForMapWithLocation:center] ;
        }
            break;
            
        default:
            break;
    }

}


#pragma mark - BMKPoiSearchDelegate协议方法
//  展示搜索结果
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
    
    
}

#pragma mark- 开始周边搜索
- (void)nearbySearch:(UIButton *)sender
{
    self.poiSearch.delegate = self ;
    //  发起检索
    BMKNearbySearchOption * option = [[BMKNearbySearchOption alloc]init] ;
    option.radius = 100000 ;
    option.pageIndex = 0 ;
    option.pageCapacity = 10000 ; //  一次显示10000家
    option.location = self.locationServer.userLocation.location.coordinate ;
    option.keyword = @"药店" ;
    BOOL flag = [self.poiSearch poiSearchNearBy:option] ;
    if (flag) {
        NSLog(@"周边检索发送成功");
    }
    else{
        NSLog(@"周边检索发送失败");
    }
}
#pragma mark - 定位服务
- (void)starLocationServer
{
    [self.locationServer startUserLocationService] ;
    //  定位跟随模式
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    self.mapView.showsUserLocation = YES ;
}
#pragma mark - BMKLocationServiceDelegate协议方法（更新用户位置）
//  每次用户位置改变时，触发该方法
//  userLocation：大头针模型
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    //  重新定位
    [self.mapView updateLocationData:userLocation] ;
    //  获得用户位置
    CLLocation * location = self.locationServer.userLocation.location ;
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placemark = [placemarks lastObject] ;
        userLocation.subtitle = placemark.name ;
    }] ;

}

#pragma mark - BMKLocationServiceDelegate协议方法（更新用户方向）
//  每次用户方向改变时，触发该方法
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //
    CGFloat angle = M_PI / 180.0f * userLocation.heading.headingAccuracy  ;
    self.compass.transform = CGAffineTransformMakeRotation(-angle) ;
}

#pragma mark -  设置地图当前显示区域
- (void)currentShowContentForMapWithLocation:(CLLocationCoordinate2D)center
{
    //  1.获取区域中心位置
    //  2.制定经纬的跨度
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.1, 0.1) ;
    //  3.将用户当前的位置作为显示区域的中心，并指定区域的跨度
    BMKCoordinateRegion region = BMKCoordinateRegionMake(center, span) ;
    //  4.设置地图显示区域
    [self.mapView setRegion:region animated:YES] ;
    
    NSLog(@"所在位置");
}


#pragma mark - navigationItem的左按钮触发方法（搜索）
- (void)searchContentAtCity:(UIButton *)sender
{
    self.poiSearch.delegate = self ;
    //  发起城市检索
    BMKCitySearchOption* option = [[BMKCitySearchOption alloc]init] ;
    option.pageIndex = 0 ;
    option.pageCapacity = 10 ; //  一次显示10家
    option.city = self.titleView.city.textFiled.text ;
    option.keyword = self.titleView.content.textFiled.text ;
    BOOL flag = [self.poiSearch poiSearchInCity:option] ;
    if (flag) {
        NSLog(@"城市检索发送成功");
    }
    else{
        NSLog(@"城市检索发送失败");
    }

}




#pragma mark - navigationItem的右按钮触发方法(下一页)
- (void)searchContentAtCityWithNextPage:(UIButton *)sender
{
    _curPage++;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = _curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= self.titleView.city.textFiled.text;
    citySearchOption.keyword = self.titleView.content.textFiled.text;
    BOOL flag = [self.poiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        
        NSLog(@"城市内检索发送成功");
    }
    else
    {
       
        NSLog(@"城市内检索发送失败");
    }
}

#pragma mark - 开始路径搜索
- (void)routeSelec:(UIButton *)sender
{
    NSString * startAddress = self.routeSelectView.startTextFiled.textFiled.text ;
    NSString * endAddress = self.routeSelectView.endTextFiled.textFiled.text ;
    self.routeSelectView.hidden = YES;
    if (startAddress.length == 0 || endAddress.length == 0 ) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"起点或者终点不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
        [alertView show] ;
        return ;
    }
    
    YDRouterSelectViewController * routeSelectVc = [[YDRouterSelectViewController alloc]init] ;
    routeSelectVc.startAddress = startAddress ;
    routeSelectVc.endAddress = endAddress;
    [self.navigationController pushViewController:routeSelectVc animated:YES] ;
    routeSelectVc = nil ;
}

#pragma mark - 启动导航
- (void)startNavigation:(UIButton *)sender
{
    self.navigationView.hidden = YES ;
    NSString * endLocation = self.navigationView.destinationTextFiled.textFiled.text;
    CLLocation * startLocation = self.locationServer.userLocation.location ;
    
    [self.geocoder geocodeAddressString:endLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0) return;
        
        // 目的地位置的地标
        CLPlacemark *endCLPlacemark = [placemarks lastObject];
        
        [self.geocoder reverseGeocodeLocation:startLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks.count == 0) return;
            //  起点位置地标
            CLPlacemark * startCLPlacemark = [placemarks lastObject] ;
            // 开始导航
            [self startNavigationWithstartCLPlacemark:startCLPlacemark endCLPlacemark:endCLPlacemark];
        }];
    }];
}

//  开始导航
- (void)startNavigationWithstartCLPlacemark:(CLPlacemark *)startCLPlacemark endCLPlacemark:(CLPlacemark *)endCLPlacemark
{
    // 0.创建起点和终点
    MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithPlacemark:startCLPlacemark];
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
    MKPlacemark *endPlacemark = [[MKPlacemark alloc] initWithPlacemark:endCLPlacemark];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPlacemark];
    
    // 1. 设置起点和终点数组
    NSArray *items = @[startItem, endItem];
    
    
    // 2.设置启动附加参数
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    // 导航模式(驾车/走路)
    md[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    // 地图显示模式
    md[MKLaunchOptionsMapTypeKey] = @(MKMapTypeHybrid);
    
    
    // 只要调用MKMapItem的open方法, 就可以打开系统自带的地图APP进行导航
    [MKMapItem openMapsWithItems:items launchOptions:md];
}



#pragma mark-  点击return回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder] ;
}



@end
