//
//  YDDrugCounselingCelll.m
//  text
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDDrugCounselingCelll.h"

@interface YDDrugCounselingCelll ()

@property (nonatomic, strong) UIImageView *Qimage;
@property (nonatomic, strong) UIImageView *Aimage;

@property (nonatomic, strong) UILabel *QName;
@property (nonatomic, strong) UILabel *AName;

@property (nonatomic, strong) UILabel *Question;
@property (nonatomic, strong) UILabel *Answer;
@end

@implementation YDDrugCounselingCelll

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.Qimage = [[UIImageView alloc] init];
        self.Qimage.image = [UIImage imageNamed:@"提问图标"];
        [self.contentView addSubview:_Qimage];
        
        self.QName = [[UILabel alloc] init];
        [self.contentView addSubview:_QName];
        self.QName.font = [UIFont systemFontOfSize:12];
        self.QName.textColor = [UIColor blueColor];
        
        
        self.Question = [[UILabel alloc] init];
        [self.contentView addSubview:_Question];
        self.Question.numberOfLines = 0;
        self.Question.font = [UIFont systemFontOfSize:12];
        
        
        self.Aimage = [[UIImageView alloc] init];
        self.Aimage.image = [UIImage imageNamed:@"回答图标"];
        [self.contentView addSubview:_Aimage];
        
        
        self.AName = [[UILabel alloc] init];
        [self.contentView addSubview:_AName];
        self.AName.font = [UIFont systemFontOfSize:12];
        self.AName.textColor = [UIColor blueColor];
        

        self.Answer = [[UILabel alloc] init];
        [self.contentView addSubview:_Answer];
        self.Answer.numberOfLines = 0;
        self.Answer.font = [UIFont systemFontOfSize:12];
        
        
        
//        self.QName.backgroundColor = [UIColor redColor];
//        self.Question.backgroundColor = [UIColor yellowColor];
//        self.AName.backgroundColor = [UIColor greenColor];
//        self.Answer.backgroundColor = [UIColor grayColor];
        
        self.Qimage.frame = CGRectMake(10, 10, 20, 20);
        
        
        self.QName.frame = CGRectMake(self.Qimage.frame.origin.x + self.Qimage.frame.size.width + 5, self.Qimage.frame.origin.y, SCREEN_WIDTH / 1.2, 20);
        
        self.Question.frame = CGRectMake(self.QName.frame.origin.x, self.QName.frame.origin.y + self.QName.frame.size.height + 5, SCREEN_WIDTH / 1.2, 20);
        
        self.Aimage.frame = CGRectMake(10, self.Question.frame.origin.y + self.Question.frame.size.height + 5, 20, 20);
        
        self.AName.frame = CGRectMake(self.Aimage.frame.origin.x + self.Aimage.frame.size.width + 5, self.Question.frame.origin.y + self.Question.frame.size.height + 5, SCREEN_WIDTH / 1.2, 20);
        
        self.Answer.frame = CGRectMake(self.AName.frame.origin.x, self.AName.frame.origin.y + self.AName.frame.size.height + 5, SCREEN_WIDTH / 1.2, 20);
    }
    return self;
}

- (void)cellsetModel:(YDDrugCounselingModel *)model
{
    self.QName.text = model.username;
    
    self.Question.text = model.mainbody;
    
    //计算介绍label的高度
    CGRect bounds=[model.mainbody boundingRectWithSize:CGSizeMake(SCREEN_WIDTH / 1.2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    self.Question.numberOfLines = 0;
    self.Question.font=[UIFont systemFontOfSize:12];
    self.Question.frame = CGRectMake(self.QName.frame.origin.x, self.QName.frame.origin.y + self.QName.frame.size.height + 5, SCREEN_WIDTH / 1.2, bounds.size.height);
    
    NSString *str = @"医生的回答";
    
    self.AName.text = [NSString stringWithFormat:@"%@%@",model.doctorname,str];
    self.Answer.text = model.answer;
    
    self.Aimage.frame = CGRectMake(10, self.Question.frame.origin.y + self.Question.frame.size.height + 5, 20, 20);
    
    self.AName.frame = CGRectMake(self.Aimage.frame.origin.x + self.Aimage.frame.size.width + 5, self.Question.frame.origin.y + self.Question.frame.size.height + 5, SCREEN_WIDTH / 1.2, 20);
    
    //计算介绍label的高度
    CGRect boundz=[model.answer boundingRectWithSize:CGSizeMake(SCREEN_WIDTH / 1.2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    self.Answer.numberOfLines = 0;
    self.Answer.font=[UIFont systemFontOfSize:12];
    self.Answer.frame = CGRectMake(self.AName.frame.origin.x, self.AName.frame.origin.y + self.AName.frame.size.height + 5, SCREEN_WIDTH / 1.2, boundz.size.height);
    
}

+ (CGFloat)heightForCell:(YDDrugCounselingModel *)model
{
    CGRect bounds=[model.mainbody boundingRectWithSize:CGSizeMake(SCREEN_WIDTH / 1.2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName] context:nil];
    
    CGRect boundz=[model.answer boundingRectWithSize:CGSizeMake(SCREEN_WIDTH / 1.2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    
    return 30 + 40 + bounds.size.height + boundz.size.height;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
