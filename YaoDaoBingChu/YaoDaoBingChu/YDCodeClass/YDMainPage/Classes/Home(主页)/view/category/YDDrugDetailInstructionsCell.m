//
//  YDDrugDetailInstructionsCell.m
//  text
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kURL @"http://openapi.db.39.net/app/GetDrugComments?Limit=30&app_key=app&curPage=1&drugId=767306&sign=9DFAAD5404FCB6168EA6840DCDFF39E5"
#import "YDDrugDetailInstructionsCell.h"
#import "MJExtension.h"
@interface YDDrugDetailInstructionsCell ()

@property (strong, nonatomic)  UIButton *like;
@property (strong, nonatomic)  UILabel *great;
@property (strong, nonatomic)  UILabel *name;
@property (strong, nonatomic)  UILabel *issue;

@end

@implementation YDDrugDetailInstructionsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"dinping";
    YDDrugDetailInstructionsCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YDDrugDetailInstructionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.name = [[UILabel alloc] init];
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textColor = [UIColor blueColor];
        self.name.frame = CGRectMake(10, 10, 100, 20);
        [self.contentView addSubview:_name];
        
        self.issue = [[UILabel alloc] init];
        self.issue.font = [UIFont systemFontOfSize:13];
        self.issue.frame = CGRectMake(10, 33, 328, 20);
//        self.issue.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_issue];
        
        self.great = [[UILabel alloc] init];
        self.great.font = [UIFont systemFontOfSize:14];
        self.great.textColor = [UIColor blueColor];
        self.great.textAlignment = NSTextAlignmentRight;
        self.great.frame = CGRectMake(10, 33, 328, 20);
        [self.contentView addSubview:_great];
        
        self.like = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.like setImage:[UIImage imageNamed:@"details_praise_normal@3x"] forState:UIControlStateNormal];
//        self.like.backgroundColor = [UIColor redColor];
        self.like.frame = CGRectMake(10, 33, 328, 20);
        [self.contentView addSubview:_like];
    }
    return self;
}

- (void)cellsetModel:(YDMedicationReviewsModel *)model
{
    
    CGRect name = [model.content boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName] context:nil];
    self.name.frame = CGRectMake(10, 10, name.size.width, 20);
    self.like.frame = CGRectMake(SCREEN_WIDTH - 50, 10, 20, 20);
    self.great.frame = CGRectMake(self.like.frame.origin.x - 30, 10, 30, 20);
    if ([model.username isEqualToString:@""]) {
        self.name.text = @"药品通用户";
    } else {
        self.name.text = model.username;
    }
    
    self.issue.text = model.content;
    self.great.text = [NSString stringWithFormat:@"%ld",model.useful];
    
    //计算介绍label的高度
    CGRect bounds=[model.content boundingRectWithSize:CGSizeMake(328, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName] context:nil];
    self.issue.numberOfLines = 0;
    self.issue.font=[UIFont systemFontOfSize:13];
    self.issue.frame=CGRectMake(10, 35, 328, bounds.size.height);

}

+ (CGFloat)heightForCell:(YDMedicationReviewsModel *)model
{
    CGRect bounds=[model.content boundingRectWithSize:CGSizeMake(328, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName] context:nil];
    return 10 + 40 + bounds.size.height;
}

- (void)likeAddTarget:(id)target action:(SEL)action {
    
//    NSLog(@"---------------------------");
    [self.like addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeImageWith:(YDMedicationReviewsModel *)model {
    
    [self.like setImage:[UIImage imageNamed:@"details_praise_selected"] forState:UIControlStateNormal];
    self.great.text = [NSString stringWithFormat:@"%ld",model.useful + 1];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
