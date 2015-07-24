//
//  HealthLectureDetailViewController.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "HealthLectureDetailViewController.h"
#import "HealthLectureVedioModel.h"
#import "HealthLectureCommentModel.h"
#import "HealthLectureRecommendModel.h"
#import "HealthLectureCommentTableViewCell.h"
#import "HealthLectureRecommendTableViewCell.h"
#import "VideoView.h"
#import "PrefixHeader.pch"

#define healthLectureDetailURL @"http://phone.vodjk.com/video_play.php?commentid=0&userid=&rows=5&contentid="

@interface HealthLectureDetailViewController ()<UITableViewDataSource,UITableViewDelegate,HealthLectureVedioModelDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *bigView;

@property(nonatomic,strong)UIView *vedioVew;

@property(nonatomic,strong)UILabel *commentLabel;

@property(nonatomic,strong)UILabel *recommendLabel;

@property(nonatomic,strong)NSMutableArray *commentArray;

@property(nonatomic,strong)NSMutableArray *recommendArray;

@property(nonatomic,strong)NSMutableArray *vedioArray;

@property(nonatomic,strong)HealthLectureVedioModel *videoModel;

@property(nonatomic,strong)HealthLectureCommentTableViewCell *commentCell;

@property(nonatomic,strong)HealthLectureRecommendTableViewCell *recommendCell;

@property(nonatomic,assign)BOOL isClick;

@property(nonatomic,strong)VideoView *conView;

@property(nonatomic,assign)BOOL isTap;

@property(nonatomic,assign)BOOL isTouch;

@property(nonatomic,strong)UIView *screenView;

@property(nonatomic,assign)CGFloat videoDuration;

@property(nonatomic,strong)AVPlayerLayer *playerLayer;

@end

@implementation HealthLectureDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setHeaderView];
    
    [self requestDataWithHealthLectureDetailURL:[NSString stringWithFormat:@"%@",_model.contentid]];
    //[self requestDataWithHealthLectureDetailURL];
    
    self.navigationItem.title = _model.title;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, kScreenWidth, kScreenHeight - 250 - 68) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BackImageView *backImageView = [[BackImageView alloc] initWithFrame:CGRectMake(0, 250, kScreenWidth, kScreenHeight - 250 - 68) image:@"view.jpg"];
    self.tableView.backgroundView = backImageView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(itemAction:)];

    self.navigationItem.leftBarButtonItem = item;
    
    [self.view addSubview:_tableView];
    
    _isClick = NO;
    
    _isTap = YES;
    
    _isTouch = NO;
    
    [HealthLectureVedioModel shareInstance].isPlaying = YES;
    
    [self.tableView registerClass:[HealthLectureCommentTableViewCell class] forCellReuseIdentifier:@"commentCell"];
    
    [self.tableView registerClass:[HealthLectureRecommendTableViewCell class] forCellReuseIdentifier:@"recommendCell"];
}

- (void)itemAction:(UIBarButtonItem *)item
{
    //[HealthLectureVedioModel shareInstance].youCanPlay = NO;
    [self.navigationController popViewControllerAnimated:YES];
    [[HealthLectureVedioModel shareInstance].healthLecturePlayer pause];
}

- (void)requestDataWithHealthLectureDetailURL:(NSString *)string
{
    //NSLog(@"%@",_model.contentid);
    //[LORequestManger GET:[healthLectureDetailURL stringByAppendingString:[NSString stringWithFormat:@"%@",_model.contentid]]
    [LORequestManger GET:[healthLectureDetailURL stringByAppendingString:string]
        success:^(id response) {
        NSDictionary *dict = (NSDictionary *)response;
        NSDictionary *dict1 = dict[@"result"];
        self.commentArray = [NSMutableArray array];
        for (NSDictionary *commentDict in dict1[@"comment"])
        {
            HealthLectureCommentModel *commentModel = [[HealthLectureCommentModel alloc] init];
            [commentModel setValuesForKeysWithDictionary:commentDict];
            [self.commentArray addObject:commentModel];
        }
        
        self.recommendArray = [NSMutableArray array];
        for (NSDictionary *recommendDict in dict1[@"relevance"])
        {
            HealthLectureRecommendModel *recommendModel = [[HealthLectureRecommendModel alloc] init];
            [recommendModel setValuesForKeysWithDictionary:recommendDict];
            [self.recommendArray addObject:recommendModel];
        }
        
        [self.vedioArray removeAllObjects];
        self.vedioArray = [NSMutableArray array];
        NSDictionary *vedioDict = dict1[@"video"];
        self.videoModel = [[HealthLectureVedioModel alloc] init];
        [self.videoModel setValuesForKeysWithDictionary:vedioDict];
        
        [self videoPlay:self.videoModel.v_720];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isClick == YES)
    {
        return self.commentArray.count;
    }
    else
    {
        return self.recommendArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isClick == YES)
    {
        //评论信息
        _commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
        HealthLectureCommentModel *model = _commentArray[indexPath.row];
        [_commentCell setValueForCellWithModel:model];
        _commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _commentCell;
    }
    else
    {
        //推荐视频
        _recommendCell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell" forIndexPath:indexPath];
        HealthLectureRecommendModel *model = _recommendArray[indexPath.row];
        [_recommendCell setValueForCellWithModel:model];
        _recommendCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _recommendCell;
    }
}

- (void)setHeaderView
{
    self.bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
    [self.view addSubview:_bigView];
    
    self.vedioVew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
    self.vedioVew.backgroundColor = [UIColor blackColor];
    [self.bigView addSubview:self.vedioVew];
    
    UIView *belowLine = [[UIView alloc] initWithFrame:CGRectMake(0, 215, kScreenWidth, 1)];
    belowLine.backgroundColor = [UIColor lightGrayColor];
    belowLine.alpha = 0.5;
    [self.view addSubview:belowLine];
    self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 215, kScreenWidth / 2, 35)];
    self.commentLabel.text = @"评论信息";
    self.commentLabel.textAlignment = NSTextAlignmentCenter;
    self.commentLabel.font = [UIFont systemFontOfSize:15];
    self.commentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *commentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTap:)];
    commentTap.numberOfTouchesRequired = 1;
    commentTap.numberOfTapsRequired = 1;
    [self.commentLabel addGestureRecognizer:commentTap];
    [self.view addSubview:self.commentLabel];
    markLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 250 - 1.5, kScreenWidth / 2, 1.5)];
    markLine1.backgroundColor = [UIColor greenColor];
    markLine1.hidden = YES;
    [self.view addSubview:markLine1];
    
    UIView *midLine = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 215, 0.5, 35)];
    midLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:midLine];
    
    self.recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 215, kScreenWidth / 2, 35)];
    self.recommendLabel.text = @"推荐视频";
    self.recommendLabel.textAlignment = NSTextAlignmentCenter;
    self.recommendLabel.font = [UIFont systemFontOfSize:15];
    self.recommendLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *recommendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recommendTap:)];
    recommendTap.numberOfTapsRequired = 1;
    recommendTap.numberOfTouchesRequired = 1;
    [self.recommendLabel addGestureRecognizer:recommendTap];
    [self.view addSubview:self.recommendLabel];
    
    markLine2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 250 - 1.5, kScreenWidth / 2, 1.5)];
    markLine2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:markLine2];
    
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, 250 - 1, kScreenWidth, 1)];
    underLine.backgroundColor = [UIColor lightGrayColor];
    underLine.alpha = 0.5;
    [self.vedioVew addSubview:underLine];
    
    self.conView = [[VideoView alloc] initWithFrame:CGRectMake(0, 170, kScreenWidth, 40)];
    [self.bigView addSubview:_conView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.vedioVew addGestureRecognizer:tap];
    
    [self.conView.playButton addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [self.conView.playButton setBackgroundImage:[UIImage imageNamed:@"player_pause_hl@2x.png"] forState:UIControlStateNormal];
    [self.conView.scaleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.conView.progressSlider addTarget:self action:@selector(videoSlierChangeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)changeStatus:(UIButton *)button
{
    if ([HealthLectureVedioModel shareInstance].isPlaying == YES)
    {
        [HealthLectureVedioModel shareInstance].isPlaying = NO;
        [self.conView.playButton setBackgroundImage:[UIImage imageNamed:@"player_play_hl@2x.png"] forState:UIControlStateNormal];
        [[HealthLectureVedioModel shareInstance].healthLecturePlayer pause];
    }
    else
    {
        [HealthLectureVedioModel shareInstance].isPlaying = YES;
        [self.conView.playButton setBackgroundImage:[UIImage imageNamed:@"player_pause_hl@2x.png"] forState:UIControlStateNormal];
        [[HealthLectureVedioModel shareInstance].healthLecturePlayer play];
    }
}

- (void)videoPlay:(NSString *)string
{
    [HealthLectureVedioModel shareInstance].healthLecturePlayerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:string]];
    [[HealthLectureVedioModel shareInstance].healthLecturePlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[HealthLectureVedioModel shareInstance].healthLecturePlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [HealthLectureVedioModel shareInstance].healthLecturePlayer = [AVPlayer playerWithPlayerItem:[HealthLectureVedioModel shareInstance].healthLecturePlayerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:[HealthLectureVedioModel shareInstance].healthLecturePlayer];
    //_playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerLayer.frame = CGRectMake(0, 0, kScreenWidth, 210);
    [self.vedioVew.layer addSublayer:_playerLayer];
    [[HealthLectureVedioModel shareInstance].healthLecturePlayer play];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.healthLecturePlayer.currentItem];
}

- (void)monitorMovieProgress
{
    __block HealthLectureDetailViewController *blockSelf = self;
    [[HealthLectureVedioModel shareInstance].healthLecturePlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CMTime currentTime = [HealthLectureVedioModel shareInstance].healthLecturePlayer .currentItem.currentTime;
        CGFloat currentPlayTime = (CGFloat)currentTime.value / currentTime.timescale;
        blockSelf.videoDuration = (CGFloat)[HealthLectureVedioModel shareInstance].healthLecturePlayerItem.duration.value / [HealthLectureVedioModel shareInstance].healthLecturePlayerItem.duration.timescale;
        CGFloat playTime = blockSelf.videoDuration - currentPlayTime;
        blockSelf.conView.progressSlider.value = (CGFloat)currentPlayTime / blockSelf.videoDuration;

        blockSelf.conView.currentLabel.text = [blockSelf convertTime:currentPlayTime];
        blockSelf.conView.totalLabel.text = [blockSelf convertTime:playTime];
    }];

    [self.conView.progressSlider addTarget:self action:@selector(scrubbingDidBegin) forControlEvents:UIControlEventTouchDown];
    [self.conView.progressSlider addTarget:self action:@selector(scrubberIsScrolling) forControlEvents:UIControlEventValueChanged];
    [self.conView.progressSlider addTarget:self action:@selector(scrubbingDidEnd) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchCancel)];
}

- (NSString *)convertTime:(CGFloat)second
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1)
    {
        [formatter setDateFormat:@"HH:mm:ss"];
    }
    else
    {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}


-(void)scrubbingDidBegin
{
    [[HealthLectureVedioModel shareInstance].healthLecturePlayer pause];
}

//快进
-(void)scrubberIsScrolling
{
    double currentTime = floor(_videoDuration * self.conView.progressSlider.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(currentTime, 1);
    [[HealthLectureVedioModel shareInstance].healthLecturePlayer seekToTime:dragedCMTime completionHandler:
     ^(BOOL finish)
     {
         if ([HealthLectureVedioModel shareInstance].isPlaying == YES)
         {
             [[HealthLectureVedioModel shareInstance].healthLecturePlayer play];
         }
         //[self.Moviebuffer stopAnimating];
         //self.Moviebuffer.hidden = YES;
     }];
}

-(void)scrubbingDidEnd
{
//    self.Moviebuffer.hidden = NO;
//    [_Moviebuffer startAnimating];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = (AVPlayerItem*)object;
        if (playerItem.status == AVPlayerStatusReadyToPlay) {
            //视频加载完成
//            [self.Moviebuffer stopAnimating];
//            self.Moviebuffer.hidden = YES;
            [self monitorMovieProgress];
        }
    }
    if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        float bufferTime = [self availableDuration];
        NSLog(@"缓冲进度-----------%f",bufferTime);
//        float durationTime = CMTimeGetSeconds([[self.LGCustomMoviePlayerController.player currentItem] duration]);
//        [self.progressView setProgress:bufferTime/durationTime animated:YES];

    }
}

- (float)availableDuration
{
    NSArray *loadedTimeRanges = [[[HealthLectureVedioModel shareInstance].healthLecturePlayer currentItem] loadedTimeRanges];
    // Check to see if the timerange is not an empty array, fix for when video goes on airplay
    // and video doesn't include any time ranges
    if ([loadedTimeRanges count] > 0)
    {
        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        //return (startSeconds + durationSeconds);
        return durationSeconds;
    }
    else
    {
        return 0.0f;
    }
}

- (void)buttonAction:(UIButton *)button
{
    self.screenView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if (_isTouch == NO)
    {
        _isTouch = YES;
        [self.view addSubview:_screenView];
        self.vedioVew.frame = _screenView.frame;
        [_screenView addSubview:self.vedioVew];
        self.playerLayer.frame = self.vedioVew.frame;
    }
    else
    {
        _isTouch = NO;
        [self.screenView removeFromSuperview];
        self.vedioVew.frame = CGRectMake(0, 0, kScreenWidth, 210);
        self.playerLayer.frame = CGRectMake(0, 0, kScreenWidth, 210);
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (_isTap == YES)
    {
        _isTap = NO;
        [self.conView removeFromSuperview];
    }
    else
    {
        _isTap = YES;
        [self.bigView addSubview:_conView];
    }
}

- (void)commentTap:(UITapGestureRecognizer *)tap
{
    _isClick = YES;
    markLine1.hidden = NO;
    markLine2.hidden = YES;
    [self.tableView reloadData];
    [self.recommendCell removeFromSuperview];
}

- (void)recommendTap:(UITapGestureRecognizer *)tap
{
    _isClick = NO;
    markLine1.hidden = YES;
    markLine2.hidden = NO;
    [self.tableView reloadData];
    [self.commentCell removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isClick == YES)
    {
        HealthLectureCommentModel *commentModel = self.commentArray[indexPath.row];
        return [HealthLectureCommentTableViewCell heightForCell:commentModel];
    }
    else
    {
        return 116;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_recommendCell)
    {
        HealthLectureRecommendModel *recommendModel = self.recommendArray[indexPath.row];
        //[self videoPlay:<#(NSString *)#>]
        //NSLog(@"%@",recommendModel.contentid);
        [self requestDataWithHealthLectureDetailURL:[NSString stringWithFormat:@"%@",recommendModel.contentid]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
