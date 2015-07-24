//
//  YDScanController.m
//  text
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 ZOL. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "YDScanController.h"
#import <AVFoundation/AVFoundation.h>
#import "YDConst.h"
//#import "AFNetworking.h"
#import "YDDrugDetailsController.h"
#define kURLH @"http://openapi.db.39.net/app/GetDrugByBar?app_key=app&barcode="
#define kURLF @"&sign=9DFAAD5404FCB6168EA6840DCDFF39E5"

@interface YDScanController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession * session;//输入输出的中间桥梁
    int num;
    BOOL _isClick;
    BOOL _upOrdown;
    NSTimer * timer;
}
//@property (strong,nonatomic)AVCaptureDevice * device;
//@property (strong,nonatomic)AVCaptureDeviceInput * input;
//@property (strong,nonatomic)AVCaptureMetadataOutput * output;
//@property (strong,nonatomic)AVCaptureSession * session;
//@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;


@end

@implementation YDScanController
- (IBAction)edit {
    NSLog(@"编辑");
}
- (IBAction)light {
    NSLog(@"闪光灯");
//    if (!_isClick) {
//        [self openFlashlight];
//    } else {
//        [self closeFlashlight];
//    }
//    _isClick = !_isClick;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"条码扫描";
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    left.image = [UIImage imageNamed:@"back"];
    self.navigationItem.leftBarButtonItem = left;
    

    
    self.backImage.image = [UIImage imageNamed:@"pick_bg.png"];
    
    _isClick = 0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 120, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];

    _upOrdown = NO;
    num =0;
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [session startRunning];
    
    
    //监听
    [YDNotificationCenter addObserver:self selector:@selector(Barcode:) name:YDPartnerNotification object:nil];
}

/**
 *  执行监听方法
 */
- (void)Barcode:(NSNotification *)notification {
    NSString *barcode = notification.userInfo[YDSelectPartnerName];
    NSLog(@"%@",barcode);
    
    
    
    YDDrugDetailsController *ddVc = [[YDDrugDetailsController alloc] init];
    ddVc.barcode = barcode;
    [self.navigationController pushViewController:ddVc animated:YES];
    
}
/**
 *  移除监听
 */
- (void)dealloc {
    [YDNotificationCenter removeObserver:self];
}

- (void)left {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)animation1
{
    if (_upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50, 120+2*num, 220, 2);
        if (2*num == 250) {
            _upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50, 120+2*num, 220, 2);
        if (num == 0) {
            _upOrdown = NO;
        }
    }
}



#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        
        //[session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        //输出扫描字符串
//        NSLog(@"%@",metadataObject.stringValue);
        
        
        [YDNotificationCenter postNotificationName:YDScanNotification object:nil userInfo:@{YDScanBarcode : metadataObject}];
    }
}




//- (void)openFlashlight {
//    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    if (device.torchMode == AVCaptureTorchModeOff) {
//        //Create an AV session
//        AVCaptureSession * session = [[AVCaptureSession alloc]init];
//        
//        // Create device input and add to current session
//        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
//        [session addInput:input];
//        
//        // Create video output and add to current session
//        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
//        [session addOutput:output];
//        
//        // Start session configuration
//        [session beginConfiguration];
//        [device lockForConfiguration:nil];
//        
//        // Set torch to on
//        [device setTorchMode:AVCaptureTorchModeOn];
//        
//        [device unlockForConfiguration];
//        
//        [session commitConfiguration];
//        
//        // Start the session
//        [session startRunning];
//        
//        // Keep the session around
//        [self setSession:session];
//    }
//}

//- (void)closeFlashlight {
//    [session stopRunning];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end