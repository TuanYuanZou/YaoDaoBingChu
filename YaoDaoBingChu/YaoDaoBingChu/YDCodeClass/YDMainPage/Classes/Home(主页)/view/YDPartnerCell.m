//
//  YDPartnerCell.m
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDPartnerCell.h"

@interface YDPartnerCell ()

@end
@implementation YDPartnerCell

- (NSMutableArray *)uiarr {
    if (_uiarr == nil) {
        _uiarr = [NSMutableArray array];
    }
    return _uiarr;
}

+ (instancetype)tradeCellWithTableView:(UITableView *)tableView {
    static NSString *trademark = @"trade";
    YDPartnerCell *tradeCell = [tableView dequeueReusableCellWithIdentifier:trademark];
    if (tradeCell == nil) {
        tradeCell = [[YDPartnerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trademark];
    }
    return tradeCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
  
                // 0.总列数(一行最多3列)
                int totalColumns = 3;
                
                // 1.应用的尺寸
                CGFloat appW = SCREEN_WIDTH / 3;
                CGFloat appH = 80;
        
                // 3.根据应用个数创建对应的框框(index 0 ~ 11)
                for (int index = 0; index<6; index++) {
                    
                    // 3.1.创建1小框框
                    self.back = [UIButton buttonWithType:UIButtonTypeCustom];
                    self.back.tag = 100 + index;
                    
                    // 设置背景色
//                self.back.backgroundColor = [UIColor colorWithRed:(arc4random()%122) / 255.0 green:(arc4random()%122) / 255.0 blue:(arc4random()%122) / 255.0 alpha:1];
                        
                    // 3.2.计算框框的位置
                    // 计算行号和列号
                    int row = index / totalColumns;
                    int col = index % totalColumns;
                        
                    // 计算x和y
                    CGFloat appX =  col * appW;
                    CGFloat appY = row * appH;
                        
                    // 设置frame
                    self.back.frame = CGRectMake(appX, appY, appW, appH);
                        
                    // 3.3.添加框框到控制器的view
                    [self.contentView addSubview:_back];
                        
                        
                        
                    // 3.4.添加内部的小控件
                    
                    // 3.4.0.index位置对应的应用信息
//               NSDictionary *appInfo = self.apps[index];
                        
                    // 3.4.1.添加图片
                    self.trademark = [[UIImageView alloc] init];
//                self.trademark.backgroundColor = [UIColor colorWithRed:(arc4random()%122) / 255.0 green:(arc4random()%122) / 255.0 blue:(arc4random()%122) / 255.0 alpha:1];
                        
                    // 设置位置
                    CGFloat iconW = SCREEN_WIDTH / 3 - 10;
                    CGFloat iconH = 50;
                    CGFloat iconX = (appW - iconW) * 0.5;
                    CGFloat iconY = 5;
                    self.trademark.frame = CGRectMake(iconX, iconY, iconW, iconH);
                    [self.back addSubview:_trademark];
                        
                    // 3.4.2.添加名字
                    self.name = [[UILabel alloc] init];
                    // 设置位置
                    CGFloat nameW = appW;
                    CGFloat nameH = 20;
                    CGFloat nameX = 0;
                    CGFloat nameY = iconY + iconH;
                    
                    self.name.frame = CGRectMake(nameX, nameY, nameW, nameH);
                    
//                self.name.backgroundColor = [UIColor colorWithRed:(arc4random()%122) / 255.0 green:(arc4random()%122) / 255.0 blue:(arc4random()%122) / 255.0 alpha:1];
     
                    self.name.font = [UIFont systemFontOfSize:13];
                    self.name.textAlignment = NSTextAlignmentCenter;
                    [self.back addSubview:_name];

                    NSMutableArray *temp = [NSMutableArray array];
                    [temp addObject:_back];
                    [temp addObject:_trademark];
                    [temp addObject:_name];
                    
                    [self.uiarr addObject:temp];
                }
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
