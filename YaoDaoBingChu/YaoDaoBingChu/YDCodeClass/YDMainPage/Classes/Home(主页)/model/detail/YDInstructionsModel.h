//
//  YDInstructionsModel.h
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDInstructionsModel : NSObject

@property (nonatomic, assign) NSInteger _id;
@property (nonatomic, copy) NSString * namecn;
@property (nonatomic, copy) NSString * composition;
@property (nonatomic, copy) NSString * drugattribute;
@property (nonatomic, copy) NSString * gongneng;
@property (nonatomic, copy) NSString * unit;
@property (nonatomic, copy) NSString * usage;
@property (nonatomic, copy) NSString * adr;
@property (nonatomic, copy) NSString * pregnantwomentaboo;
@property (nonatomic, copy) NSString * contraindication;
@property (nonatomic, copy) NSString * childrentaboo;
@property (nonatomic, copy) NSString * elderlytaboo;
@property (nonatomic, copy) NSString * note;
@property (nonatomic, copy) NSString * interaction;
@property (nonatomic, copy) NSString * pharmacology;
@property (nonatomic, copy) NSString * storage;
@property (nonatomic, copy) NSString * shelflife;
@property (nonatomic, copy) NSString * codename;
@property (nonatomic, copy) NSString * standard;
@property (nonatomic, copy) NSString * specificationdate;
@property (nonatomic, copy) NSString * refdrugcompanyname;
@property (nonatomic, strong) NSArray * refspecifications;

@property (nonatomic, strong) NSArray * SameDrugs;

@property (nonatomic, assign) float score;  //得分
@property (nonatomic, copy) NSString * titleimg;

@property (nonatomic, assign) NSInteger medcare;  //医保   0, 2

@property (nonatomic, assign) NSInteger newotc; // otc

//图片,titleimg 药名,namecn  公司,refdrugcompanyname 功能,gongneng 星星,score 标识
@end


