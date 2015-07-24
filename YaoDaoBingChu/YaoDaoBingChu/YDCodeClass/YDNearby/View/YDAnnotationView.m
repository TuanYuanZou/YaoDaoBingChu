//
//  YDAnnotationView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDAnnotationView.h"
#import "YDAnnotation.h"

@implementation YDAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier] ;
    if (self)
    {
        //  初始化：
        //  设置点击大头针时显示标题
        self.canShowCallout = YES ;
        
        //  设置大头针标题显示的偏移位
        self.calloutOffset = CGPointMake(10, 10) ;
        //  设置大头针左边的辅助视图
        //self.leftCalloutAccessoryView =
        //  设置大头针左边的辅助视图
    }
    return self ;
}


//  快速创建自定义大头针的方法
//  mapView:地图对象
//  返回大头针视图
+ (instancetype)annotationViewWithMap:(MKMapView *)mapView;
{
   //  1.定义标示
    static NSString * indentifer = @"annotationView" ;
    //  2.从缓冲池中取一个大头针视图
    YDAnnotationView * annotationView = (YDAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:indentifer] ;
    //  3.若为空，则新建
    if (annotationView == nil) {
        annotationView = [[YDAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:indentifer] ;
    }
    return annotationView ;
}

//  从写annotation的setting方法，添加自定义大头针模型 特有的数据
- (void)setAnnotation:(YDAnnotation *)annotation
{
    [super setAnnotation:annotation];
    //  处理自己特有的数据
    self.image = annotation.icon ;
}

@end
