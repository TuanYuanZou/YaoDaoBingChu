//
//  HealthLectureCommentTableViewCell.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "HealthLectureCommentTableViewCell.h"

@implementation HealthLectureCommentTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
//        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, KScreenWidth, KScreenHeight - 180 - 68)];
//        self.scrollView.contentSize = CGSizeMake(KScreenWidth * 2, KScreenHeight - 180 - 68);
//        //self.scrollView.delegate = self;
//        self.scrollView.pagingEnabled = YES;
//        self.scrollView.showsHorizontalScrollIndicator = NO;
//        [self.contentView addSubview:_scrollView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 200, 20)];
        self.nameLabel.textColor = [UIColor lightGrayColor];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, kScreenWidth - 30, 100)];
        self.commentLabel.textColor = [UIColor blackColor];
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_commentLabel];
        
//        self.commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 180 - 68) style:UITableViewStylePlain];
//        self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.commentTableView.scrollEnabled = NO;
//        self.commentTableView.dataSource = self;
//        self.commentTableView.delegate = self;
//        [self.scrollView addSubview:self.commentTableView];
//        
//        self.recommendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 180 - 68) style:UITableViewStylePlain];
//        self.recommendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.recommendTableView.scrollEnabled = NO;
//        self.recommendTableView.dataSource = self;
//        self.recommendTableView.delegate = self;
//        [self.scrollView addSubview:self.recommendTableView];
    }
    return self;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}

- (void)setValueForCellWithModel:(HealthLectureCommentModel *)model
{
    self.nameLabel.text = model.name;
    
    CGRect bounds = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    self.commentLabel.text = model.content;
    self.commentLabel.frame = CGRectMake(15, 45, kScreenWidth - 30, bounds.size.height);
}

+ (CGFloat)heightForCell:(HealthLectureCommentModel *)model
{
    CGRect bounds = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName] context:nil];
    return 45 + bounds.size.height + 10;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
