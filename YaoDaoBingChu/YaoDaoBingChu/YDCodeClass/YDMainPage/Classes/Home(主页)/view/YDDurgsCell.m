//
//  YDDurgsCell.m
//  YDMainPage
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDDurgsCell.h"
#import "YDCategoryModel.h"
#import "UIImageView+AFNetworking.h"
@interface YDDurgsCell ()

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *durgsLabel;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIImageView *otc;


@end

@implementation YDDurgsCell

- (NSMutableArray *)uiArr {
    if (_uiArr == nil) {
        _uiArr = [NSMutableArray array];
    }
    return _uiArr;
}

+ (instancetype)drugsCellWithTableView:(UITableView *)tableView {
    static NSString *Durgs = @"durgs";
    YDDurgsCell *durgsCell = [tableView dequeueReusableCellWithIdentifier:Durgs];
    if (durgsCell == nil) {
        durgsCell = [[YDDurgsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Durgs];
    }
    return durgsCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.scrollview = [[UIScrollView alloc] init];
        self.scrollview.showsHorizontalScrollIndicator = NO;
        self.scrollview.userInteractionEnabled = YES;
        self.scrollview.pagingEnabled = YES;
        [self.contentView addSubview:_scrollview];
        
        self.scrollview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        self.scrollview.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
        
        
        for (int i=0; i<4; i++) {

            self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.backBtn.tag = i + 300;
            [self.scrollview addSubview:_backBtn];
            self.backBtn.frame = CGRectMake(SCREEN_WIDTH / 2 * i  , 0, SCREEN_WIDTH / 2, self.scrollview.frame.size.height);
            
            
            self.pic = [[UIImageView alloc] init];
           
            [self.backBtn addSubview:_pic];
            self.pic.frame = CGRectMake(5, 5, self.backBtn.frame.size.width - 10, self.backBtn.frame.size.height - 50);

            
            self.durgsLabel = [[UILabel alloc] init];
            [self.backBtn addSubview:_durgsLabel];
            self.durgsLabel.textAlignment = NSTextAlignmentCenter;
            self.durgsLabel.font = [UIFont systemFontOfSize:12];
            self.durgsLabel.frame = CGRectMake(self.pic.frame.origin.x,  self.pic.frame.origin.y + self.pic.frame.size.height, self.pic.frame.size.width, 20);

            
            self.price = [[UILabel alloc] init];
            [self.backBtn addSubview:_price];
            self.price.textColor = [UIColor redColor];
            self.price.font = [UIFont systemFontOfSize:12];
            self.price.frame = CGRectMake(self.durgsLabel.frame.origin.x, self.durgsLabel.frame.origin.y + self.durgsLabel.frame.size.height, 60, 15);
            
            
//            if (_temp.count != 0) {
//                YDCategoryModel *model = self.temp[i];
//                NSMutableString *str = [model.TitleImg mutableCopy];
//                [str insertString:@"n" atIndex:7];
//                [self.pic setImageWithURL:[NSURL URLWithString:str]];
//                self.durgsLabel.text = model.NameCN;
//                self.price.text = [NSString stringWithFormat:@"￥%@",model.AvgPrice];
//            }
            
            
            self.otc = [[UIImageView alloc] init];
            [self.backBtn addSubview:_otc];
            self.otc.frame = CGRectMake(self.pic.frame.origin.x + self.pic.frame.size.width - 20, self.price.frame.origin.y, 20, 16);
//            self.otc.image = [UIImage imageNamed:@"otc绿图标"];
            
            
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:_backBtn];
            [temp addObject:_pic];
            [temp addObject:_durgsLabel];
            [temp addObject:_price];
            [temp addObject:_otc];
            
            [self.uiArr addObject:temp];
        }
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    self.scrollview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
//    self.scrollview.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
//    
//    for (int i=0; i<4; i++) {
//        
//        self.backBtn.frame = CGRectMake(SCREEN_WIDTH / 2 * i  , 0, SCREEN_WIDTH / 2, self.scrollview.frame.size.height);
//        
//        self.pic.frame = CGRectMake(5, 5, self.backBtn.frame.size.width - 10, self.backBtn.frame.size.height - 50);
//        
//        self.durgsLabel.frame = CGRectMake(self.pic.frame.origin.x,  self.pic.frame.origin.y + self.pic.frame.size.height, self.pic.frame.size.width, 20);
//        
//        self.price.frame = CGRectMake(self.durgsLabel.frame.origin.x, self.durgsLabel.frame.origin.y + self.durgsLabel.frame.size.height, 40, 15);
//        
//        self.otc.frame = CGRectMake(self.pic.frame.origin.x + self.pic.frame.size.width - 20, self.price.frame.origin.y, 20, 16);
//    }
//    self.horizontal.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1); //横
//    self.vertical.frame = CGRectMake(self.frame.size.width / 2, 0, 1, self.frame.size.height); //竖
//}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
