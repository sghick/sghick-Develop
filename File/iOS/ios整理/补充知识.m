/*
 ============================================================================================
 ======================================== 补充 ================================================
 ============================================================================================
 
 =================================
 1.mac apache  ===================
 =================================
 ter启动终端
 sudo apachectl start
 sudo apachectl stop
 
 =================================
 2.设置导航条  ====================
 =================================
 // 设置导航条的背影色
 [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
 
 // 给tabBar设置背景
 [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
 // 设置点击下去的阴影
 [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabBar_Slider.png"]];


 =================================
 3.CocoaPods工具 ==================
 =================================
 1)安装CocoaPods
 a.打开终端
 ter
 b.用淘宝 的 Ruby 镜像来访问 cocoapods
 $ gem sources --remove https://rubygems.org/
 $ gem sources -a http://ruby.taobao.org/
 c.验证 Ruby 镜像是并且仅是 taobao
 $ gem sources –l
 成功结果:
 *** CURRENT SOURCES ***
 
 http://ruby.taobao.org/
 d.下载安装CocoaPods
 $ sudo gem install cocoapods
 e.查看版本
 $ git --version
 f.gem是管理Ruby库和程序的标准包，版本过低会安装失败，要升级gem，执行下述命令即可：
 $ sudo gem update --system
 g.安装完成后
 $ pod setup
 如果报错则再执行:$ rvm use ruby-x.x.x-xxxx
 h.升级CocoaPods
 $ sudo gem install cocoapods
 2)使用CocoaPods
 a.创建Podfile
 b.Podfile内容
 platform :ios
 pod 'Reachability',  '~> 3.0.0'
 pod 'SBJson', '~> 4.0.0'
 
 platform :ios, '7.0'
 pod 'AFNetworking', '~> 2.0'
 c.导入第三方库
 $ pod install
 如果不成功就用
 $ pod update
 3)打开新的工程文件,以后使用它就行了
 $ pod search ASIHttpRequest
 
 4)如果路径不对
 $ sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
 $ pod setup
 
 =================================
 4.屏幕适配  ======================
 =================================
 在View的InterfaceBuilderDocument的UseAutoLayout勾去掉
 
 配置成四个方向的,在targets里把upsideDown勾上
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 // Return YES for supported orientations
 return YES;
 }
 - (NSUInteger)supportedInterfaceOrientations
 {
 return (1 << UIInterfaceOrientationPortrait)|(1 << UIInterfaceOrientationLandscapeLeft)|(1 << UIInterfaceOrientationLandscapeRight)|(1 << UIInterfaceOrientationPortraitUpsideDown);
 }
 
 1)用两个nib实现
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
 
 self.hengpin = [[[NSBundle mainBundle] loadNibNamed:@"Hengpin" owner:self options:nil] lastObject];
 self.shupin = [[[NSBundle mainBundle] loadNibNamed:@"Shupin" owner:self options:nil] lastObject];
 [self adjustsScreen];
 }
 -(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
 [self adjustsScreen];
 }
 - (void)adjustsScreen{
 // 竖屏
 if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
 [self.hengpin removeFromSuperview];
 [self.view addSubview:self.shupin];
 }
 // 横屏
 if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
 [self.shupin removeFromSuperview];
 [self.view addSubview:self.hengpin];
 }
 }
 
 2)Autosizing布局
 第三方布局:Masonry.h
 
 =================================
 5.可执行文件 ======================
 =================================
 $0当前Shell程序的文件名
 dirname $0，获取当前Shell程序的路径
 cd `dirname $0`，进入当前Shell程序的目录
 
 使用lipo命令将设备和模拟器的.a合并成一个通用的.a文件，将合并后的通用.a文件拖拽至工程中即可，具体命令如下： 
 lipo -create Release-iphoneos/libbaidumapapi.a Release-iphonesimulator/libbaidumapapi.a -output libbaidumapapi.a

 
 
 =================================
 6.去掉xcode中警告的一些经验 ========
 =================================
 1)编译时，编译警告忽略掉某些文件
 只需在在文件的Compiler Flags 中加入 -w 参数
 
 2)编译时，编译警告忽略掉某段代码
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wmultichar"
 char b = 'df'; // no warning.
 #pragma clang diagnostic pop
 参考网址：http://stackoverflow.com/questions/7897429/ignore-all-warnings-in-a-specific-file-using-llvm-clang/8087544#8087544
 
 3)编译时，analyse警告忽略掉某些文件
 只需在文件的Compiler Flags 中加入 "-w -Xanalyzer -analyzer -disable -checker"
 参考网址：http://stackoverflow.com/questions/7897429/ignore-all-warnings-in-a-specific-file-using-llvm-clang
 
 4)编译时，analyse警告忽略掉某段代码
 #ifndef __clang_analyzer__
 // Code not to be analyzed
 #endif
 参考网址：http://stackoverflow.com/questions/5806101/is-it-possible-to-suppress-xcode-4-static-analyzer-warnings
 
 5)项目使用arc以后，调用[someTarget performSelector:someAction]会报警告，有如下三种解决方法：
 a)当ARC检查警告时，忽略掉该段代码
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
 [object performSelector:action];
 #pragma clang diagnostic pop
 
 对于多处出现该警告时，可以定义一个宏来替换，比如
 #define NoWarningPerformSelector(target, action, object) \
 _Pragma("clang diagnostic push") \
 _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
 [target performSelector:action withObject:object]; \
 _Pragma("clang diagnostic pop") \
 
 b)使用objc_msgSend函数进行替换
 #import <objc/message.h>
 objc_msgSend(object, action);
 
 c)在该代码文件的的Compiler Flags 中加入 "-Wno-arc-performSelector-leaks" 参数
 参考网址：http://stackoverflow.com/questions/7017281/performselector-may-cause-a-leak-because-its-selector-is-unknown/7073761#7073761
 
 6)对于category覆盖类里面方法导致的警告，可能就要修改源代码了。因为苹果是不建议在category中覆盖类方法的，以为这种行为会产生未知的结果。
 If the name of a method declared in a category is the same as a method in the original class, or a method in another category on the same class (or even a superclass), the behavior is undefined as to which method implementation is used at runtime.
 参考网址：http://stackoverflow.com/questions/13388440/xcode-4-5-warns-about-method-name-conflicts-between-categories-for-parent-child
 https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html  （Avoid Category Method Name Clashes段落）
 
 7)对于某个类中存在方法名和系统某个类的方法名相同的情形，如果你在此类的静态方法中使用self来调用该方法，可能引发警告，所以尽量避免此种情况。比如
 我自定义一个类 RequestTask 继承自NSObject，里面有个静态方法：
 + (id)taskWithRequest:(BaseRequest *)request delegate:(id)delegate
 {
  return [[self alloc] initWithRequest:request delegate:delegate];
 }
 而在我的RequestTask确实有一个方法的定义为：
 - (id)initWithRequest:(BaseRequest *)req delegate:(id)delegate;
 理论上讲这个是没有任何问题的，但是编译器编译的时候却有一个警告，因为NSURLConnection有一个相同的方法，编译器认为我调用的是NSURLConnection类的该方法，参数类型不对报错。
 所以此种情况，我们应该避免直接在静态方法中使用self调用类的实例方法。
 
 8)当使用两个不匹配的enum类型或者enum类型默认也是会报警告的，此种情况可以通过直接强制类型转换解决，也可以在编译器中规避掉此种警告。例如：
 
 9)当Enum类型和Enum类型中未定义的整形范围进行比较时，编译器也会给警告。此种解决方法目前查到的就是强制类型转化。
 
 =================================
 7. svn服务器搭建          ========
 =================================
 http://www.cnblogs.com/mjios/archive/2013/03/10/2952258.html
 
 1)配置
 a.创建代码仓库
 svnadmin create /Users/qf/svn/mycode
 b.配置svnserve.conf
 anon-access = read
 auth-access = write
 password-db = passwd
 authz-db = authz
 c.配置passwd
 [users]
 qf=qf
 sghick=qf
 d.配置authz
 [groups]
 qfgroup=qf,sghick
 [/]
 @qfgroup=rw
 
 2)开启
 在终端输入下列指令：svnserve -d -r /Users/qf/svn
 或者输入：svnserve -d -r /Users/qf/svn/mycode
 
 3)使用
 a.初始化导入
 svn import 工程目录所在路径 svn://localhost/mycode/工程目录名 --username=sghick --password=qf -m "初始化导入"
 b.checkout
 svn checkout svn://localhost/mycode --username=mj --password=123 工程目录所在路径
 c.checkin(要在工程目录所在路径)
 svn commit -m "修改了main.m文件"
 d.update
 svn update
 f.help
 svn help
 
 3)使用Versions工具
 a.登陆:svn://sghick@10.0.185.7/mycode
 
 =================================
 8. UDP和TCP套接字(socket) ========
 =================================
 1)UDP
 #import "AsyncUdpSocket.h"
 // 套接字对象,负责发送和接收数据
 AsyncUdpSocket * _udpSocket;
 
 ===客户端===
 // 创建一个udp的套接字对象
 _udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
 // 主机地址,区别某个设备
 NSString * host = @"127.0.0.1";
 // 端口号,区别某个设置上的应用程序
 UInt16 port = 8080;
 // timeout -1,表示永不超时
 // tag 区分每个请求
 [_udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:1000];
 #pragma mark- UDPDelegate
 - (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
 if (tag == 1000) {
 NSLog(@"sendToServer");
 }
 }
 ===服务器===
 _udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
 // 需要绑定一个端口号
 [_udpSocket bindToPort:8080 error:nil];
 [_udpSocket receiveWithTimeout:60 tag:200];
 #pragma mark- UDPDelegate
 - (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
 NSString * message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 [_dataSource addObject:message];
 NSLog(@"host:%@:%u", host, port);
 if (_dataSource.count) {
 NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_dataSource.count-1 inSection:0];
 [_tableView reloadData];
 [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
 }
 [_udpSocket receiveWithTimeout:60 tag:200];
 return YES;
 }
 
 2)TCP
 #import "AsyncSocket.h"
 // 客户端接收和发送数据的套接字
 AsyncSocket * _clientSocket;
 ===客户端===
 _clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
 NSString * host = @"10.0.185.115";
 UInt16 port = 8888;
 [_clientSocket connectToHost:host onPort:port withTimeout:30 error:nil];
 #pragma mark- AsyncSocketDelegate
 // 发送数据的方法得判断是否连接成功
 - (void)sendMessageToServer:(UIBarButtonItem *)item{
 // 连接失败
 if ([_clientSocket isConnected] == NO) {
 return;
 }
 NSString * message = @"message from DingDaye";
 NSData * data = [message dataUsingEncoding:NSUTF8StringEncoding];
 [_clientSocket writeData:data withTimeout:60 tag:100];
 }
 // 连接服务器失败时调用
 - (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
 NSLog(@"客户端连接失败:%@", [err localizedDescription]);
 }
 // 连接服务器成功时调用
 - (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
 NSLog(@"客户端连接成功:%@:%u", host, port);
 }
 ===服务器===
 _serverSocket = [[AsyncSocket alloc] initWithDelegate:self];
 [_serverSocket acceptOnPort:8888 error:nil];
 #pragma mark- AsyncSocketDelegate
 - (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
 // [重要]保留引用计数
 [_clients addObject:newSocket];
 // 服务器要响应
 [newSocket readDataWithTimeout:-1 tag:100];
 }
 - (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
 NSLog(@"服务器被连接成功:%@:%u", host, port);
 }
 - (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
 NSLog(@"服务器被连接失败:%@", [err localizedDescription]);
 }
 - (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
 if (tag == 100) {
 NSString * message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 [_dataSource addObject:message];
 [_tableView reloadData];
 }
 }
 
 =================================
 9. 本地通知:UILocalNotification===
 =================================
 1)
 UILocalNotification *localNotification = [[UILocalNotification alloc] init];
 //设置通知5秒后触发
 localNotification.fireDate = [[NSDate alloc] initWithTimeIntervalSinceNow:5];
 localNotification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
 localNotification.timeZone=[NSTimeZone defaultTimeZone];// 时区
 //设置通知消息
 localNotification.alertBody = @"计划通知，新年好!";
 //设置通知标记数
 localNotification.applicationIconBadgeNumber = 1;
 //设置通知出现时候声音
 localNotification.soundName = UILocalNotificationDefaultSoundName;
 //设置动作按钮的标题
 localNotification.alertAction = @"View Details";
 //计划通知
 [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

 //结束计划通知
 [[UIApplication sharedApplication] cancelAllLocalNotifications];
 
 UILocalNotification *localNotification = [[UILocalNotification alloc] init];
 //设置通知消息
 localNotification.alertBody = @"立刻通知，新年好!";
 //设置通知徽章数
 localNotification.applicationIconBadgeNumber = 5;
 //设置通知出现时候声音
 localNotification.soundName = UILocalNotificationDefaultSoundName;
 //设置动作按钮的标题
 localNotification.alertAction = @"View Details";
 //立刻发通知
 [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
 

 =================================
 10. 远程通知  RemoteNotification==
 =================================
 //注册接收通知类型
 [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
 (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
 //设置图标标记
 application.applicationIconBadgeNumber = 1;
 - (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
 {
 //先对token进行处理 <d8d42e5e b38dcc5c 0c445d81 32f7cb21 694e5527 5d021c1c dfd81378 21c2b499> 我们需要对< 空格进行处理
 // NSString*str=[[NSString alloc]initWithData:deviceToken encoding:NSUTF8StringEncoding];
 //以上方法返回是nil
 NSString *tokeStr=deviceToken.description;
 NSLog(@"%@",tokeStr);
 //去掉<>和空格
 tokeStr=[[[tokeStr stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
 tokeStr = [tokeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
 NSString *strURL = @"http://192.168.1.103/mynotes/push_chat_service.php";
 NSURL *url = [NSURL URLWithString:strURL];
 ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
 [request setPostValue:tokeStr forKey:@"token"];
 [request setPostValue:@"98Z3R5XU29.com.liyuechun.PushChat" forKey:@"appid" ];
 [request setDelegate:self];
 NSLog(@"发送给服务器");
 [request startAsynchronous];
 }
 - (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
 {
 NSLog(@"获得令牌失败: %@", error);
 }
 - (void)requestFinished:(ASIHTTPRequest *)request
 {
 NSLog(@"成功");
 NSString *str = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] ;
 NSLog(@"%@",str);
 }
 - (void)requestFailed:(ASIHTTPRequest *)request
 {
 NSError *error = [request error];
 NSLog(@"%@", [error localizedDescription]);
 }
 
 
 =================================
 11.SPNS原生推送              =====
 =================================
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 {
 self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 // 本地推送应用场景
 // 1、本地提醒业务，比如你该吃药了，闹铃
 // 2、游戏业务，比如该收取金币了
 // 3、骚扰业务，你前男友召唤你呢
 // 4、图书类业务，定时看书
 // 好处就是不需要网络，但是需要程序中提前设定
 for (int i=0; i<10; i++) {
 //初始化本地推送
 UILocalNotification*local=[[UILocalNotification alloc]init];
 //设置推送弹出时间
 local.fireDate=[NSDate dateWithTimeIntervalSinceNow:5*(i+1)];
 //弹出的内容
 local.alertBody=@"小强你该吃药了，别忘记关灯吃药";
 //设置推送的声音 苹果支持多种格式包含MP3 caf，要求小于30秒，有部分声音格式不支持，需要在开发时候提前测试
 local.soundName=@"CAT2.WAV";
 //把推送加入到系统底层，这样程序被系统杀掉，依然可以执行推送
 //获取系统当前的未读消息的条数，也就是icon上面的红色数字
 NSInteger num=[[UIApplication sharedApplication]applicationIconBadgeNumber];
 num=[[UIApplication sharedApplication]scheduledLocalNotifications].count+num;
 //以上这样写有问题 我们默认是顺序到达这些这些消息，如果你推送的消息，一条是5秒以后达到，一条是1小时以后到达，最后一条是30分钟以后到达
 //如果采用循环方式添加，就会产生问题
 //我们设计的1 2 3  用户看到的是132
 //需要在每次插入一条，要查看当前所有推送的时间，设计在推送时间前进行计算
 local.applicationIconBadgeNumber=num+1;
 [[UIApplication sharedApplication]scheduleLocalNotification:local];
 }
 //网络推送
 //先判断是否开启推送了
 UIRemoteNotificationType type=[[UIApplication sharedApplication]enabledRemoteNotificationTypes];
 if (type!=UIRemoteNotificationTypeNone) {
 //已经开启推送
 }else{
 //未开启推送，需要开启推送，如果程序第一次启动，则会询问用户是否接受推送
 //开启推送
 [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound ];
 //UIRemoteNotificationTypeNewsstandContentAvailability该类型为报刊杂志，一般不加入
 //声音依然是接受30秒以内的即可 声音的文件是由服务器端来进行设置推送过来的，但是你程序内必须有这个声音文件即可，并且类型中也要加入UIRemoteNotificationTypeSound
 //如何关闭推送
 // [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeNone];
 }
 [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound ];
 //网络推送剩余信息在代理中完成
 self.window.backgroundColor = [UIColor whiteColor];
 [self.window makeKeyAndVisible];
 return YES;
 }
 //注册成功，开启推送，获得token
 -(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
 {
 //先对token进行处理 <d8d42e5e b38dcc5c 0c445d81 32f7cb21 694e5527 5d021c1c dfd81378 21c2b499> 我们需要对< 空格进行处理
 // NSString*str=[[NSString alloc]initWithData:deviceToken encoding:NSUTF8StringEncoding];
 //以上方法返回是nil
 NSString*str=deviceToken.description;
 NSLog(@"%@",str);
 //去掉<>和空格
 str=[[[str stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
 
 //将处理好的字符串发送给服务器即可
 NSLog(@"~~~~%@",str);
 }
 //注册失败，开启推送失败
 -(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
 {
 NSLog(@"error~~~~%@",error);
 }
 //iOS7的新方法，推送过来以后，用户点击，我们获得的消息，具体消息在userinfo里
 -(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
 {
 //新方法block的回调，主要用户程序间的通信
 
 //服务器推送过来消息，用户点击获得的内容
 NSLog(@"~~~~~%@",userInfo);
 }
 //iOS7以前的旧方法
 -(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
 {
 
 }
 //当用户点击推送，会在代理中返回推送内容
 -(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
 {
 //当用户点击推送，我们的程序会被唤醒
 NSLog(@"%@",notification.alertBody);
 //消除徽标
 [UIApplication sharedApplication].applicationIconBadgeNumber=0;
 //终止其他的推送
 //获得所有的本地推送
 NSArray*array=[[UIApplication sharedApplication]scheduledLocalNotifications];
 //如果取消所有的推送
 //[[UIApplication sharedApplication]cancelAllLocalNotifications];
 //如果单独取消某个推送
 for (UILocalNotification*local in array) {
 //首先遍历得到推送的指针，可以判断消息内容
 if ([local.alertBody isEqualToString:@"你该吃药了，别忘记关灯吃药"]) {
 //取消符合这个条件的推送
 [[UIApplication sharedApplication]cancelLocalNotification:local];
 }
 }
 }
 
 =================================
 12. 激光推送  =====
 =================================
 第三方网络推送服务
 友盟推送服务
 百度推送服务
 极光推送服务
 蝴蝶推送服务
 个推推送服务
 以上推送服务主要解决安卓平台上推送问题，最早是极光和蝴蝶推送，百度推送开始于13年5月开始使用，最开始相当不稳定，后来逐步稳定的，最开始百度推送的到达率只有60%，后来现在提高到了95%
 
 //激光推送官方文档：http://docs.jpush.cn/pages/viewpage.action?pageId=2621727
 #import "APService.h"
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 {
 self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 //极光推送的用户名密码  ios1427  123456 地址https://www.jpush.cn
 //appkey 4ffd66eae36454916428cfaa
 //极光推送初始化，添加头文件
 [APService setupWithOption:launchOptions];
 //极光是仿照苹果原生进行注册，他底层使用的同样是苹果原生
 [APService registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert];
 //最后全部设置完成后，不要忘记修改appid，才能够正常接收推送服务我们的appid  com.1427.push
 self.window.backgroundColor = [UIColor whiteColor];
 [self.window makeKeyAndVisible];
 return YES;
 }
 
 -(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
 {
 NSLog(@"userInfo~~~~%@",userInfo);
 // 推送过来接收到得信息，其中aps，alert，badge，sound是苹果固定的格式，不能修改，其他的可以根据需求进行添加，但是苹果推送消息，不能超过256字节也就是128个汉字，输入超过，推送失败
 // {
 // "_j_msgid" = 1712542540;
 // aps =     {
 // alert = "\U5c0f\U9ed1\U8bf4\Uff1a\U4f60\U5988\U903c\U4f60\U56de\U5bb6\U7ed3\U5a5a\U5462\Uff0c\U8d76\U7d27\U5a36\U51e4\U59d0\U5427";
 // badge = 1;
 // sound = default;
 // };
 // }
 
 //判断程序是在前台还是后台
 if ([UIApplication sharedApplication].applicationState==UIApplicationStateBackground) {
 //在后台
 NSLog(@"后台");
 }else{
 //在前台
 NSLog(@"前台");
 }
 }

 =================================
 13. 真机测试  =====
 =================================
 1.配置证书
 2.生成.cer文件
 
 =================================
 14. 二维码产生(第三方libqrencode)
 =================================
 #import "QRCodeGenerator.h"
 // 根据字符串产生 二维码图片
 UIImage *img = [QRCodeGenerator qrImageForString:@"笑傲人生" imageSize:300];
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 300, 300)];
 imageView.tag = 100;
 imageView.image = img;
 [self.window addSubview:imageView];
 
 =================================
 15. Zbar二维码识别(第三方libqrencode)
 =================================
 
 
 =================================
 16. Masonry屏幕适配(第三方Masonry)
 =================================
 
 =================================
 17. 屏幕旋转检测通用方法
 =================================
 1)注册UIApplicationDidChangeStatusBarOrientationNotification通知
 注意这种方式监听的是StatusBar也就是状态栏的方向，所以这个是跟你的布局有关的，你的布局转了，才会接到这个通知，而不是设备旋转的通知。
 当我们关注的东西和布局相关而不是纯粹设备旋转，我们使用上面的代码作为实现方案比较适合
 2)注册UIDeviceOrientationDidChangeNotification通知
 注意到这种方式里面的方向还包括朝上或者朝下，很容易看出这个完全是根据设备自身的物理方向得来的，当我们关注的只是物理朝向时，我们通常需要注册该通知来解决问题（另外还有一个加速计的api，可以实现类似的功能，该api较底层，在上面两个方法能够解决问题的情况下建议不要用，使用不当性能损耗非常大）
 
 
 */