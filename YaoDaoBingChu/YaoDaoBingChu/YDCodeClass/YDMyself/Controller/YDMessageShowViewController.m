
//
//  YDMessageShowViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMessageShowViewController.h"
#import "YDMessageShowTabBar.h"
#import "YDMessageViewController.h"
#import "YDMessageTool.h"
#import "YDMessage.h"
#import "YDMessagePhonesView.h"

#import "NSString+YDStringToAttributedString.h"
@interface YDMessageShowViewController ()
{
    //  当前显示的留言ID
    NSInteger _currentID ;
}

// 显示历史留言
@property(nonatomic,strong)UITextView * textView ;
//  所有ID
@property(nonatomic,strong)NSArray * messageIDs ;
//  相册
@property(nonatomic,strong)YDMessagePhonesView * phonesView ;

@end

@implementation YDMessageShowViewController
#pragma mark - 懒加载
#pragma mark -  添加相册
- (YDMessagePhonesView *)phonesView
{
    if (!_phonesView) {
        _phonesView = [[YDMessagePhonesView alloc]init] ;
        CGFloat phonesViewX = 10 ;
        CGFloat phonesViewY = 100 ;
        CGFloat phonesViewW = kScreenWidth - 2 * phonesViewX ;
        CGFloat phonesViewH = kScreenHeight - phonesViewY ;
        _phonesView.frame = CGRectMake(phonesViewX, phonesViewY, phonesViewW  , phonesViewH);
        [self.textView addSubview:_phonesView] ;
    }
    //  数组中的元素，都执行一遍removeFromSuperview方法
    [_phonesView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) ] ;
     return _phonesView ;
    
}



- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 44)]  ;
        _textView.userInteractionEnabled = NO ;
        [self.view addSubview:_textView] ;
        
    }
    return _textView ;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor whiteColor] ;
    
    YDMessageShowTabBar * messageShowTabBar = [[YDMessageShowTabBar alloc]initWithFrame:CGRectMake(0, kScreenHeight - 44 - 64 , kScreenWidth, 44)] ;
    messageShowTabBar.messageShowTabBarBlock = ^(UIButton * sender){[self messageShowTabBarButtonClink:sender];} ;
    [self.view addSubview:messageShowTabBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"留言" style:UIBarButtonItemStylePlain target:self action:@selector(message)] ;
    
    
    
    //  取出所有的留言ID
    self.messageIDs = [[YDMessageTool shareMessageTool]messageIDs] ;
    _currentID =  self.messageIDs.count - 1;
    if (_currentID == -1) {
        return ;
    }
    NSNumber * ID = [self.messageIDs objectAtIndex:_currentID] ;
    [self showMessage:ID.intValue] ;
}




//  点击按钮触发方法
- (void)messageShowTabBarButtonClink:(UIButton *)sender
{
    switch (sender.tag) {
        case YDMessageShowTabBarButtonTypeFirstPage:// 首页
        {
            _currentID =  self.messageIDs.count - 1;
            if (_currentID == -1) {
                return ;
            }
            NSNumber * ID = [self.messageIDs objectAtIndex:_currentID] ;
            [self showMessage:ID.intValue] ;
            break;
        }
        case YDMessageShowTabBarButtonTypeBeforePage:
        {
            if (_currentID == 0) {
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"当前是首页" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
                [alertView show] ;
                return ;
            }
            if (_currentID == -1) {
                return ;
            }
            //  取出前一个id
            _currentID = (_currentID - 1) > 0 ? (_currentID) - 1:0 ;
            NSNumber * ID = [self.messageIDs objectAtIndex:_currentID] ;
            [self showMessage:ID.intValue] ;
            
            NSLog(@"上一页");
            break;
        }
            
        case YDMessageShowTabBarButtonTypeNextPage:
        {
            //  取出下一个id
            int count = self.messageIDs.count ;
            if (_currentID == -1) {
                return ;
            }
            if (_currentID == count - 1) {
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"当前是末页" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
                [alertView show] ;
                return ;
            }
            _currentID = (_currentID + 1) < count ?(_currentID + 1):count - 1 ;
            NSNumber * ID = [self.messageIDs objectAtIndex:_currentID] ;
            [self showMessage:ID.intValue];
            NSLog(@"下一页");
            break;
            
        }
        case YDMessageShowTabBarButtonTypeLastPage://  末页
        {
            //  取出第一个id
            _currentID =  0;
            NSNumber * firstID = [self.messageIDs objectAtIndex:_currentID] ;
            [self showMessage:firstID.intValue];
            NSLog(@"末页");
            break;
        }
        default:
            break;
    }
}


#pragma mark - 展示留言
- (void)showMessage:(int)ID
{
    YDMessage * message = [[YDMessageTool shareMessageTool]messagelWithID:ID] ;
    NSAttributedString * attr = [NSString attributedTextWithText:message.message] ;
    self.textView.attributedText = attr ;
    self.phonesView ;
    if (!message.image) {
        return ;
    }
    [self.phonesView addPhone:message.image] ;
}

#pragma mark - 继续留言
- (void)message
{
    YDMessageViewController * massageVc = [[YDMessageViewController alloc]init] ;
    [self.navigationController pushViewController:massageVc animated:YES];
}





@end
