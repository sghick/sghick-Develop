/*
 ============================================================================================
 ======================================== 其它 ================================================
 ============================================================================================
 
 =================================
 1.多媒体 =========================
 =================================
 1)框架:AudioToolbox.framework
 #import <AudioToolbox/AudioToolbox.h>

 - (IBAction)play:(UIButton *)sender {
 // 定义一个用于保存声音ID的变量
 SystemSoundID soundID = 0;
 NSString * path = [[NSBundle mainBundle] pathForResource:@"sound.wav" ofType:nil];
 // 加载本地url
 NSURL * url = [NSURL fileURLWithPath:path];
 // 注册系统声音的函数
 // 使用__bridge关键字来实现id类型与void*类型的相互转换
 AudioServicesCreateSystemSoundID(((__bridge CFURLRef)url), &soundID);
 // 注册声音系统播放完成后调用的方法
 AudioServicesAddSystemSoundCompletion(soundID, 0, 0, completeFun, NULL);
 // 播放系统音乐
 AudioServicesPlaySystemSound(soundID);
 
 }
 
 // 声音系统播放完成后调用的方法
 static void completeFun(SystemSoundID SID, void * inclientdata){
 AudioServicesDisposeSystemSoundID(SID);
 }
 
 2)框架:AVFoundation.framework
 #import <AVFoundation/AVFoundation.h>
 // 播放器对象
 @property (strong, nonatomic) AVAudioPlayer * player;
 
 NSString * path = [[NSBundle mainBundle] pathForResource:@"k001" ofType:@"m4r"];
 NSURL * url = [NSURL fileURLWithPath:path];
 self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
 // 先导入内存,再进行播放
 [self.player prepareToPlay];
 // 播放
 [self.player play];
 // 停止
 [self.player stop];
 
 3)框架:MediaPlayer.framework
 #import <MediaPlayer/MediaPlayer.h>
 @property (strong, nonatomic) MPMoviePlayerViewController * player;
 - (IBAction)play:(UIButton *)sender {
 NSString * path = [[NSBundle mainBundle] pathForResource:@"xiatianweidao" ofType:@"mp4"];
 NSURL * url = [NSURL fileURLWithPath:path];
 self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
 [self.player.moviePlayer setControlStyle:MPMovieControlStyleDefault];
 // 使用通知中心获取结束调用
 // MPMoviePlayerPlaybackDidFinishNotification表示调用结束时
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myComplete) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
 [self.view addSubview:self.player.view];
 }
 - (void)myComplete{
 NSLog(@"播放完了");
 }
 
 =================================
 2.沙箱 ==========================
 =================================
 // NSBundle 应用程序束,用来获取媒体文件
 // 获取沙箱目录的方法
 NSString * str = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
 // 直接获取沙箱目录
 NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 
 =================================
 3.UIWebView浏览器 ================
 =================================
 UIWebView * _webView;
 _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 30, 300, 410)];
 NSString * urlString = @"http://9yin.woniu.com";
 NSURL * url = [NSURL URLWithString:urlString];
 NSURLRequest * request = [NSURLRequest requestWithURL:url];
 [_webView loadRequest:request];
 [self.view addSubview:_webView];
 // 前进
 [_webView goBack];
 // 后退
 [_webView goForward];
 
 - (void)btnSearchClick:(UIButton *)sender{
 UITextField * textFiled = (UITextField *)[self.view viewWithTag:TAG_SEARCH_FILED];
 NSString * urlString = [textFiled.text lowercaseString];
 NSString * prefix1 = @"http://";
 if (![urlString hasPrefix:prefix1]) {
 urlString = [NSString stringWithFormat:@"%@%@",prefix1,urlString];
 }
 NSURL * url = [NSURL URLWithString:urlString];
 NSURLRequest * request = [NSURLRequest requestWithURL:url];
 [_webView loadRequest:request];
 NSLog(@"url:%@",urlString);
 }
 - (void)webViewDidStartLoad:(UIWebView *)webView{
 NSString * urlString = [NSString stringWithFormat:@"%@", webView.request.URL];
 UITextField * textFiled = (UITextField *)[self.view viewWithTag:TAG_SEARCH_FILED];
 textFiled.text = urlString;
 }
 
 =================================
 4.获取地理位置 ====================
 =================================
 框架:AddressBook.framework
     CoreLocation.framework
 #import <CoreLocation/CoreLocation.h>
 
 - (void)addLocationManager{
 _manager = [[CLLocationManager alloc] init];
 _manager.delegate = self;
 [_manager setDesiredAccuracy:kCLLocationAccuracyKilometer];
 // 设置移动多少米调用一次方法
 [_manager setDistanceFilter:10.0f];
 }
 
 // 为了节省流量,做以下处理
 - (void)viewWillAppear:(BOOL)animated{
 // 开始获取位置
 [_manager startUpdatingLocation];
 }
 // 为了节省流量,不在后台运行
 - (void)viewWillDisappear:(BOOL)animated{
 // 暂停获取位置
 [_manager stopUpdatingLocation];
 }
 
 - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
 // locations 中保留用户所有更新的历史信息
 // CLLocation 类对象用于保存用户信息
 // 其coordinate:latitude longitude
 //   altitude
 CLLocation * curlocation = [locations lastObject];
 _longitude = curlocation.coordinate.longitude;
 _latitude = curlocation.coordinate.latitude;
 [self locationFinishedGetLocation];
 }
 
 // 取地理位置的接口
 http://api.map.baidu.com/geocoder?output=json&location=39.58,116.47&key=dc40f705157725fc98f1fee6a15b6e60
 
 =================================
 5.分享插件    ====================
 =================================
 第三方:UMSocial_Sdk_4.2
 #import "UMSocial.h"
 // 注册
 [UMSocialData setAppKey:UM_APPKEY];
 
 // 快速分享
 [UMSocialSnsService presentSnsIconSheetView:self
 appKey:UM_APPKEY
 shareText:[NSString stringWithFormat:@"我看到一款游戏:%@ 好好玩!", self.titleLabel.text]
 shareImage:self.headImageView.image
 shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
 delegate:nil];
 
 
 
 */