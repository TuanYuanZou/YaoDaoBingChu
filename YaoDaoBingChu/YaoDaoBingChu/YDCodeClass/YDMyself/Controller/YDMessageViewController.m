//
//  YDMessageViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMessageViewController.h"
#import "YDEmotionPlaceholderTextView.h"
#import "YDMessageToolBar.h"
#import "YDMessagePhonesView.h"
#import "YDEmotionTool.h"

#import "YDEmotionKeyboard.h"

#import "YDEmotionButton.h"
#import "YDMessageTool.h"



@interface YDMessageViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    //  标示是否正在切换键盘
    BOOL _isSwithKeyboard ;
}

//  输入控件
@property(nonatomic,strong)YDEmotionPlaceholderTextView * emotionPlaceholderTextView ;



//  工具条
@property(nonatomic,strong)YDMessageToolBar  * messageToolBar ;


// 相册（存放拍照或者相册中取得照片）
@property(nonatomic,strong)YDMessagePhonesView * phonesView ;
//  表情键盘
@property(nonatomic,strong)YDEmotionKeyboard * emotionKeyboard ;

@end

@implementation YDMessageViewController

#pragma mark - 懒加载(表情键盘)
- (YDEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        _emotionKeyboard  = [[YDEmotionKeyboard alloc]init] ;
    }
    return _emotionKeyboard ;
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO ;
    //  设置导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)] ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"留言" style:UIBarButtonItemStyleDone target:self action:@selector(message)] ;
    
    //  没有输入内容时关闭留言按钮
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //  自定义title
    [self setupTitle];
    //  添加输入控件
    [self setupTextView] ;
    //  添加工具条
    [self setupMessageToolBar] ;
    
    //  添加相册
    [self setupPhoneView] ;    
    
}


- (void)dealloc
{
    //  移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
    
}


#pragma mark - 初始化方法
#pragma mark - 自定义title
- (void)setupTitle
{
    //  创建一个带有样式的字符串
    NSString * prefix = @"留言" ;
    NSString * name = @"小圆子" ;
    if (name) {
        //  自定义title
        UILabel * title = [[UILabel alloc]init] ;
        title.frame = CGRectMake(0, 0, 200, 44) ;
        title.textAlignment = NSTextAlignmentCenter ;
        //  自动换行
        title.numberOfLines = 0 ;
        NSString * str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:str] ;
        NSRange PrefixRange = [str rangeOfString:name] ;
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:PrefixRange] ;
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:PrefixRange] ;
        [attributeStr addAttribute:NSKernAttributeName value:@(10.0f) range:PrefixRange] ;
        
        
        
        NSRange nameRange = [str rangeOfString:name] ;
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:nameRange] ;
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:nameRange] ;
        [attributeStr addAttribute:NSKernAttributeName value:@(10.0f) range:nameRange] ;
        title.attributedText = attributeStr ;
        self.navigationItem.titleView = title ;
    }else{
        self.title = prefix ;
    }
}
#pragma mark - 添加输入控件
- (void)setupTextView
{
    YDEmotionPlaceholderTextView * emotionPlaceholderTextView = [[YDEmotionPlaceholderTextView alloc]init] ;
    emotionPlaceholderTextView.frame = self.view.bounds ;
    //  垂直方向总是可以拖拽（弹簧效果）
    emotionPlaceholderTextView.alwaysBounceVertical = YES ;
    emotionPlaceholderTextView.delegate = self ;
    emotionPlaceholderTextView.placeholder = @"请留言...." ;
    self.emotionPlaceholderTextView = emotionPlaceholderTextView ;
    [self.view addSubview:emotionPlaceholderTextView] ;
    
    //  通知：输入文本的改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:emotionPlaceholderTextView] ;
    // 通知：关注键盘frame改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil] ;
    //  通知：关注表情按钮被点击
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionButtonClink:) name:@"YDEmotionDidChoiceNotification" object:nil] ;
    //  通知：关注表情删除按钮被点击
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDeleteButtonClink) name:@"YDEmotionDeleteButtonClink" object:nil] ;
    //  成为第一响应者（弹出键盘）
    [emotionPlaceholderTextView becomeFirstResponder] ;
    
}
#pragma mark - 添加工具条
- (void)setupMessageToolBar
{
    YDMessageToolBar * messageToolBar = [[YDMessageToolBar alloc]init] ;
    CGFloat x = 0;
    CGFloat h = 44;
    CGFloat y = kScreenHeight - h - 64;
    CGFloat w = kScreenWidth;
    messageToolBar.frame = CGRectMake(x , y , w , h) ;
    self.messageToolBar = messageToolBar ;
    
    messageToolBar.didClinkButton = ^(UIButton * sender){[self didClinkButton:sender];} ;
    [self.view addSubview:messageToolBar] ;
}

#pragma mark -  添加相册
- (void)setupPhoneView
{
    YDMessagePhonesView * phonesView = [[YDMessagePhonesView alloc]init] ;
    CGFloat phonesViewX = 10 ;
    CGFloat phonesViewY = 100 ;
    CGFloat phonesViewW = kScreenWidth - 2 * phonesViewX ;
    CGFloat phonesViewH = kScreenHeight - phonesViewY ;
    phonesView.frame = CGRectMake(phonesViewX, phonesViewY, phonesViewW  , phonesViewH);
    //phonesView.backgroundColor = [UIColor orangeColor];
    [self.emotionPlaceholderTextView addSubview:phonesView] ;
    self.phonesView = phonesView ;
}


#pragma mark - 监听方法
#pragma mark - 取消
- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES ] ;
}

#pragma mark - 留言
- (void)message
{
    // 保存留言
    [[YDMessageTool shareMessageTool]insertDataWithEmotionPlaceholderTextView:self.emotionPlaceholderTextView messagePhonesView:self.phonesView] ;
    
}


#pragma mark - 输入控件文字改变
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.emotionPlaceholderTextView.hasText ;
}




#pragma mark - 拖拽textView，退下键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.emotionPlaceholderTextView resignFirstResponder];
}

#pragma 键盘frame改变时 触发方法
- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    //  正在切换键盘并且工具条不在底部 直接返回；可以保证工具条位置固定不变
    CGFloat tabBarYFact = self.messageToolBar.frame.origin.y ;
    CGFloat tabBarYTheory = kScreenHeight - 44 ;
    CGFloat range = tabBarYTheory - tabBarYFact ;
    if (_isSwithKeyboard && fabs(range) > 5) {
        return ;
    }
    NSDictionary * userInfo = notification.userInfo ;
    //  键盘 frame
    CGRect rect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //  动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] ;
    //  键盘高度
    CGFloat y = rect.origin.y;
    CGFloat centerX = kScreenWidth / 2.0f ;
#warning y - 22(根据导航栏是否透明，y的参考点不同)---64：是导航栏的高度
    CGFloat centery = y - 22 - 64;
    NSLog(@"%f",centery);
    
    [UIView animateWithDuration:duration animations:^{
        self.messageToolBar.center = CGPointMake(centerX, centery) ;
        
    }] ;
}

#pragma mark - 点击工具条按钮触发方法
- (void)didClinkButton:(UIButton *)sender
{
    switch (sender.tag) {
        case YDMessageToolBarButtonTypeCamera:
            [self openCamera] ;
            NSLog(@"照相");
            break;
            
        case YDMessageToolBarButtonTypePicture:
            [self openPicture] ;
            NSLog(@"图片");
            break;
            
        case YDMessageToolBarButtonTypeMention:
            NSLog(@"@");
            break;
            
        case YDMessageToolBarButtonTypeTrend:
            NSLog(@"#");
            break;
            
        case YDMessageToolBarButtonTypeEmotion:
            //   键盘切换
            [self switchKeyboard] ;
        
            break;
            
        default:
            break;
    }
}

#pragma mark - 拍照
- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - 照片
- (void)openPicture
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary] ;
}

#pragma mark - openImage
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    //  相机或者图库不可用
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return ;
    }
    UIImagePickerController * ipc = [[UIImagePickerController alloc]init] ;
    ipc.sourceType = type ;
    ipc.delegate = self ;
    [self presentViewController:ipc animated:YES completion:nil] ;

}


#pragma mark - UIImagePickerControllerDelegate
//  从UIImagePickerControll选着完图片结束（拍照完毕或者取照片结束）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil] ;
    //  info中就保存了我们选着的照片
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    // 添加图片到phoneView中
    [self.phonesView addPhone:image] ;
    //  当取完照片，弹出键盘
    [self.emotionPlaceholderTextView becomeFirstResponder] ;
}

#pragma mark - 键盘切换
- (void)switchKeyboard
{
    if (self.emotionPlaceholderTextView.inputView == nil)
    {
        self.messageToolBar.isShowEmotionKeyboardButton = YES ;
        
        CGFloat keyboardW = kScreenWidth;
        CGFloat keyboardH = 260 ;
        //  表情键盘
        self.emotionKeyboard.frame = CGRectMake(0, 0, keyboardW, keyboardH) ;
        //  成为 PlaceholderTextView 的键盘,x，y由系统确定
        self.emotionPlaceholderTextView.inputView = self.emotionKeyboard ;
    }
    else
    {
        self.messageToolBar.isShowEmotionKeyboardButton = NO ;
        self.emotionPlaceholderTextView.inputView = nil ;
    }
    
    
    // 开始切换键盘
    _isSwithKeyboard = YES ;
    // 退下键盘
    [self.emotionPlaceholderTextView resignFirstResponder] ;
    // 结束切换键盘
    _isSwithKeyboard = NO ;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.emotionPlaceholderTextView becomeFirstResponder] ;
    });
}

#pragma mark - 接到表情按钮被点击的通知，触发的方法
- (void)emotionButtonClink:(NSNotification *)notification
{
    YDEmotion * emotion = notification.userInfo[@"selectEmotion"] ;
    //  插入表情
    [self.emotionPlaceholderTextView insertEmotion:emotion] ;
    
    //  保存被点击的按钮，作为“最近”的数据源
    [YDEmotionTool addRecentlyEmotion:emotion] ;
    
    
}

#pragma mark - 接到表情删除按钮被点击的通知，触发的方法
- (void)emotionDeleteButtonClink
{
    NSLog(@"表情删除按钮");
    [self.emotionPlaceholderTextView deleteBackward];
}
@end
