//
//  YDAnnotationView.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface YDAnnotationView : MKAnnotationView


//  快速创建自定义大头针的方法
//  mapView:地图对象
//  返回大头针视图
+ (instancetype)annotationViewWithMap:(MKMapView *)mapView;

@end
