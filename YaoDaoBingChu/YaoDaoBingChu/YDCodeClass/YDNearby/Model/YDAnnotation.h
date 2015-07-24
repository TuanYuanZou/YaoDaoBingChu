//
//  YDAnnotation.h
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YDAnnotation : NSObject<MKAnnotation>


//  大头针位置
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

//  大头针标题
@property (nonatomic,  copy) NSString *title;
//  大头针子标题
@property (nonatomic,  copy) NSString *subtitle;
//  图标
@property (nonatomic,copy)UIImage * icon ;




@end
