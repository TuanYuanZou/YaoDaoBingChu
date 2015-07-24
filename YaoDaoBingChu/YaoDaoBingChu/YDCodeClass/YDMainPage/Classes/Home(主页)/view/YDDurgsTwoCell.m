//
//  YDDurgsTwoCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDDurgsTwoCell.h"
#import "YDCategoryModel.h"
#import "UIImageView+AFNetworking.h"
@interface YDDurgsTwoCell ()

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UIImageView *picImage;
@property (nonatomic, strong) UILabel *durgsLabel;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIImageView *otc;


@end

@implementation YDDurgsTwoCell

- (NSMutableArray *)addui {
    if (_addui == nil) {
        _addui = [NSMutableArray array];
    }
    return _addui;
}

+ (instancetype)drugsCellWithTableView:(UITableView *)tableView {
    static NSString *Durgs = @"nimade";
    YDDurgsTwoCell *durgsCell = [tableView dequeueReusableCellWithIdentifier:Durgs];
    if (durgsCell == nil) {
        durgsCell = [[YDDurgsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Durgs];
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
            
            self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btn.tag = i + 200;
            [self.scrollview addSubview:_btn];
            self.btn.frame = CGRectMake(SCREEN_WIDTH / 2 * i  , 0, SCREEN_WIDTH / 2, self.scrollview.frame.size.height);
            
            
            self.picImage = [[UIImageView alloc] init];
            
            [self.btn addSubview:_picImage];
            self.picImage.frame = CGRectMake(5, 5, self.btn.frame.size.width - 10, self.btn.frame.size.height - 50);
            
            
            self.durgsLabel = [[UILabel alloc] init];
            [self.btn addSubview:_durgsLabel];
            self.durgsLabel.textAlignment = NSTextAlignmentCenter;
            self.durgsLabel.font = [UIFont systemFontOfSize:12];
            self.durgsLabel.frame = CGRectMake(self.picImage.frame.origin.x,  self.picImage.frame.origin.y + self.picImage.frame.size.height, self.picImage.frame.size.width, 20);
            
            
            self.price = [[UILabel alloc] init];
            [self.btn addSubview:_price];
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
            [self.btn addSubview:_otc];
            self.otc.frame = CGRectMake(self.picImage.frame.origin.x + self.picImage.frame.size.width - 20, self.price.frame.origin.y, 20, 16);
//            self.otc.image = [UIImage imageNamed:@"otc绿图标"];
            
            
            NSMutableArray *temp = [NSMutableArray array];
            [temp addObject:_btn];
            [temp addObject:_picImage];
            [temp addObject:_durgsLabel];
            [temp addObject:_price];
            [temp addObject:_otc];
            
            [self.addui addObject:temp];
        }
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
