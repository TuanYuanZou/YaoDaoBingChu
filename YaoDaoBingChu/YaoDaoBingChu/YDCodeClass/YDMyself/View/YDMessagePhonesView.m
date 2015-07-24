//
//  YDMessagePhoneView.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMessagePhonesView.h"

@interface YDMessagePhonesView ()

@property(nonatomic,strong)NSMutableArray * phonesArray ;

@end






@implementation YDMessagePhonesView

- (NSMutableArray *)phonesArray
{
    if (!_phonesArray) {
        _phonesArray = [NSMutableArray array] ;
    }
    return _phonesArray ;
}

//  将照片添加到自定义view上
- (void)addPhone:(UIImage *)image
{
    UIImageView * phoneView = [[UIImageView alloc]init] ;
    phoneView.image = image ;
    [self.phonesArray addObject:image] ;
    [self addSubview:phoneView] ;
}



//  来一个照片布局一个
- (void)layoutSubviews
{
    [super layoutSubviews] ;
    
    //  设置图片尺寸和位置
    NSUInteger count = self.subviews.count ;
    
    int maxCol = 4 ;       // 最大列数
    CGFloat imageWH = 70 ; // 图片宽高
    CGFloat range = 10 ;   // 图片间距
    
    
    for (int i = 0 ; i< count; i++) {
        UIImageView * phoneView = self.subviews[i] ;
        
        int col = i % maxCol ;
        CGFloat phoneViewX = col * (imageWH + range) ;
        int row = i /maxCol ;
        CGFloat phoneViewY = row * (imageWH + range) ;
        CGFloat phoneViewW = imageWH ;
        CGFloat phoneViewH = imageWH ;
        
        // 设置每张图片的位置
        phoneView.frame = CGRectMake(phoneViewX, phoneViewY, phoneViewW, phoneViewH) ;
    }
}

- (NSArray *)phones
{
    return _phonesArray ;
}

@end
