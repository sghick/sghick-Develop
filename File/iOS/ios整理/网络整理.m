/*
 ============================================================================================
 ======================================== 网络 ==============================================
 ============================================================================================
 
 =================================
 1.多线程         =================
 =================================
 
 1)NSThread
 for (int i = 0; i < 4; i++) {
 NSThread * task = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:self.urls[i]];
 [task setName:[NSString stringWithFormat:@"Thread%d", i]];
 [task start];
 // 如果要立即执行线程,可以加上下面一句
 [NSThread sleepForTimeInterval:0.0001f];
 }
 NSString * taskName = [[NSThread currentThread] name];
 
 // 线程锁
 NSCondition * condition;
 condition = [[NSCondition alloc] init];
 [condition lock];
 [condition unlock];
 
 2)NSOperationQueue并行队列
 NSOperationQueue * queue = [[NSOperationQueue alloc] init];
 // 设置并行任务数
 [queue setMaxConcurrentOperationCount:1];
 NSOperation * task = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:URL_IMAGE_0];
 [queue addOperation:task];
 // 设置等待队列中所有线程任务完成
 [queue waitUntilAllOperationsAreFinished];
 // 取消队列内所有线程任务
 [queue cancelAllOperations];
 
 3)带锁的单例
 + (SGKModel *)sharedModel{
 // 常见的带线程锁的单例对象的创建方式
 @synchronized(self){
 static SGKModel * model = nil;
 if (model == nil) {
 model = [[SGKModel alloc] init];
 }
 return model;
 }
 }
 
 4)GCD-OC自带的底层异步处理
 // 开启一个异步
 // dispatch_queue_t queue 指定是哪种队列
 // 1.dispatch_get_main_queue 主线程队列
 // 2.dispatch_get_global_queue 并行队列
 // 3.dispatch_queue_create 创建串行队列
 dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
 dispatch_async(queue, ^{
 NSDate * startDate = [NSDate date];
 
 NSString * data = [self downloadMessageFromServer];
 NSString * processData = [self processData:data];
 __block NSString * firstResult = nil;
 __block NSString * secondeResult = nil;
 __block NSString * resultString = nil;
 // 采用分配组的方式来处理这类问题:
 // 我们希望把多个耗时的任务并发执行,但也得保证所有任务完成后再做一些后续处理
 // 首先要构建一个分派组
 dispatch_group_t group = dispatch_group_create();
 // 分派组的方法,除了要指定一个可用的分派组,还要指定在组内分派的队列,这里我们抓取的全局并发队列
 dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
 firstResult = [self firstResult:processData];
 });
 dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
 secondeResult = [self secondResult:processData];
 });
 
 // 监听组内的任务全部完成后的方法
 dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
 resultString = [NSString stringWithFormat:@"firstResult:%@\nsecondResult:%@", firstResult, secondeResult];
 // 要在主线程中做更新UI操作
 dispatch_async(dispatch_get_main_queue(), ^{
 self.resultView.text = resultString;
 });
 NSDate * endDate = [NSDate date];
 NSLog(@"花费时间:%f秒", [endDate timeIntervalSinceDate:startDate]);
 });
 });

 =================================
 2.网络请求NSUrlGet================
 =================================
 // 1.封装URL地址
 NSString * urlStr = [NSString stringWithFormat:LIMIT_URL, 1];
 NSURL * url = [NSURL URLWithString:urlStr];
 // 2.封装请求对象
 NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
 // 3.开始请求
 // 同步请求 直接返回值 NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
 // 异步请求 委托传值 [NSURLConnection sendAsynchronousRequest:urlRequest queue:nil completionHandler:nil];
 //         委托传值 NSURLConnectionDataDelegate [NSURLConnection connectionWithRequest:urlRequest delegate:self];
 [NSURLConnection connectionWithRequest:urlRequest delegate:self];
 
 #pragma mark- NSURLConnectionDataDelegate
 // 当服务器端接收到请求时
 - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
 NSLog(@"创建连接成功");
 // 如果存在就清空，否则分配内存
 if (_dataSource) {
 [_dataSource setData:nil];
 }
 else{
 _dataSource = [[NSMutableData alloc] init];
 }
 }
 
 // 服务器开始回传数据，这人方法会被多次触发，为保证安全，服务器是分包发送的放在data中
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
 //    NSLog(@"发送中...%@", data);
 // 保存每一次服务器给我们回传的数据
 [_dataSource appendData:data];
 }
 
 // 当服务器回传结束后会触发
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection{
 // 当回传结束 这时才能确定_dataSource是完整的 我们在这里解析或者二次封装
 //    NSString * data = [[NSString alloc] initWithData:_dataSource encoding:NSUTF8StringEncoding];
 //    NSLog(@"data:%@",data);
 // 解析
 // JSONObjectWithData 一个JSON格式的NSData对象
 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:_dataSource options:NSJSONReadingMutableContainers error:nil];
 NSArray * dataArr = [dict objectForKey:@"applications"];
 [_tableSource addObjectsFromArray:dataArr];
 // 【注】要刷新操作
 [self.tableView reloadData];
 }
 
 // 请求数据失败时触发
 - (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
 NSLog(@"请求失败!%@", error);
 }

 =================================
 3.网络请求 ASI    ================
 =================================
 1)单任务请求
 NSString * urlStr = [NSString stringWithFormat:LIMIT_URL, 1];
 NSURL * url = [NSURL URLWithString:urlStr];
 ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:url];
 [request setDelegate:self];
 // startAsynchronous异步请求
 [request startAsynchronous];
 
 #pragma mark- ASIHTTPRequestDelegate
 // 开始请求
 - (void)requestStarted:(ASIHTTPRequest *)request{
 NSLog(@"连接成功");
 }
 - (void)requestFinished:(ASIHTTPRequest *)request{
 // 获取服务器回传的数据
 NSData * data = [request responseData];
 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
 NSLog(@"dict:%@", dict);
 }
 - (void)requestFailed:(ASIHTTPRequest *)request{
 NSLog(@"请求失败");
 }
 // 这个方法不用实现,不要被它迷惑
 //- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data{
 //
 //}
 
 2)多任务请求
 #import "ASINetworkQueue.h"
 #import "ASIHTTPRequest.h"
 
 ASINetworkQueue * queue = [[ASINetworkQueue alloc] init];
 [queue setDelegate:self];
 // 设定队列内请求任务连接成功的回调
 [queue setRequestDidReceiveResponseHeadersSelector:@selector(connectionResponse:)];
 // 设置队列请求任务开始的回调
 [queue setRequestDidStartSelector:@selector(connectionStart:)];
 // 设置队列内请求任务完成的回调
 [queue setRequestDidFinishSelector:@selector(connectionFinished:)];
 // 设置队列内请求任务失败时的回调
 [queue setRequestDidFailSelector:@selector(connectionFailed:)];
 // 设置队列完成所有请求任务时的回调
 [queue setQueueDidFinishSelector:@selector(connectionFinishedAll:)];
 for (int i = 0; i < 4; i++) {
 NSString * urlStr = URL_TOUXIANG;
 NSURL * url = [NSURL URLWithString:urlStr];
 ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:url];
 request.tag = i + 1;
 // 把每一个请求加入到队列中,这样请求就可以管理在队列的请求任务了
 [queue addOperation:request];
 }
 // 让队列开始工作
 [queue go];

 #pragma mark- selector ASIHTTPRequest
 - (void)connectionResponse:(ASIHTTPRequest *)request{
 NSLog(@"连接成功 任务%d", request.tag);
 }
 - (void)connectionStart:(ASIHTTPRequest *)request{
 NSLog(@"开始请求 任务%d", request.tag);
 }
 - (void)connectionFinished:(ASIHTTPRequest *)request{
 NSLog(@"请求完成 任务%d", request.tag);
 switch (request.tag) {
 case 1:
 _imageView1.image = [UIImage imageWithData:request.responseData];
 break;
 case 2:
 _imageView2.image = [UIImage imageWithData:request.responseData];
 break;
 case 3:
 _imageView3.image = [UIImage imageWithData:request.responseData];
 break;
 case 4:
 _imageView4.image = [UIImage imageWithData:request.responseData];
 break;
 default:
 break;
 }
 }
 - (void)connectionFailed:(ASIHTTPRequest *)request{
 NSLog(@"连接失败");
 }
 - (void)connectionFinishedAll:(ASIHTTPRequest *)request{
 NSLog(@"任务完成");
 }
 
 =================================
 3.Post请求       ================
 =================================
 // 1.确定请求地址
 // 2.封装URL
 NSURL * url = [NSURL URLWithString:URL_LIST];
 // 3.创建请求对象
 // 处理post请求使用NSMutableURLRequest类
 NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
 // 配置请求方式为POST
 [request setHTTPMethod:@"POST"];
 // 配置Content-Type Content-Length 有四种形式,请参见网址webService.www.
 [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
 // 配置Content
 NSString * bodyString = [NSString stringWithFormat:@"page=%d&number=%d", 1, 10];
 // Content-Length为二进制的长度值
 NSData * bodyData = [NSData dataWithBytes:[bodyString UTF8String] length:bodyString.length];
 NSInteger length = bodyData.length;
 NSString * lengthString = [NSString stringWithFormat:@"%ld", length];
 // value值是字符串类型
 [request addValue:lengthString forHTTPHeaderField:@"Content-Length"];
 // 配置POST请求体 也是二进制
 [request setHTTPBody:bodyData];
 
 // 发起请求
 [NSURLConnection connectionWithRequest:request delegate:self];
 
 #pragma mark- NSURLConnectionDataDelegate
 - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
 if (_dataSource) {
 [_dataSource setData:nil];
 }
 else{
 _dataSource = [[NSMutableData alloc] init];
 }
 }
 
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
 [_dataSource appendData:data];
 }
 
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection{
 NSString * data = [[NSString alloc] initWithData:_dataSource encoding:NSUTF8StringEncoding];
 NSLog(@"data:%@", data);
 }
 
 =================================
 4.Post请求 (第三方)===============
 =================================
 #import "ASIFormDataRequest.h"

 NSURL * url = [NSURL URLWithString:URL_LIST];
 ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:url];
 // 得手动配置委托
 request.delegate = self;
 [request setRequestMethod:@"POST"];
 // ASI处理post请求无须设定Content-Type和Content-Length
 // 配置参数Form表单 如果接口要传值,但我们不用这个值,就传一个空对象[NSNull null];
 // addPostValue
 [request addPostValue:@"1" forKey:@"page"];
 [request addPostValue:@"10" forKey:@"number"];
 // 开启请求
 [request startAsynchronous];
 
 #pragma mark- ASIHTTPRequestDelegate
 - (void)requestStarted:(ASIHTTPRequest *)request{
 NSLog(@"开始...");
 }
 - (void)requestFinished:(ASIHTTPRequest *)request{
 NSData * data = [request responseData];
 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
 NSLog(@"%@", dict);
 }
 - (void)requestFailed:(ASIHTTPRequest *)request{
 NSLog(@"失败...");
 }
 
 =================================
 5.xml解析SAX       ===============
 =================================
 NSString * path = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"txt"];
 NSString * xmlContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
 // NSXMLParser 解析xml
 NSData * xmlData = [xmlContent dataUsingEncoding:NSUTF8StringEncoding];
 NSXMLParser * parser = [[NSXMLParser alloc] initWithData:xmlData];
 // NSXMLParser 是使用协议方法回传数据的
 [parser setDelegate:self];
 // NSXMLParser 让解析器开始解析
 [parser parse];
 
 #pragma mark- NSXMLParserDelegate
 // 解析开始时调用 只被调用一次
 - (void)parserDidStartDocument:(NSXMLParser *)parser{
 NSLog(@"开始解析");
 if (_stations == nil) {
 _stations = [[NSMutableArray alloc] init];
 }
 else{
 [_stations removeAllObjects];
 }
 }
 // 发现开始标签时调用
 - (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
 if ([elementName isEqualToString:@"TrainDetailInfo"]) {
 if (_modelConten != nil) {
 _modelConten = nil;
 }
 _modelConten = [[SGKMSchem alloc] init];
 }
 }
 // 发现数据时调用 标签中的内容
 - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
 self.content = string;
 }
 // 发现结束标签时调用 </...>
 - (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
 if ([elementName isEqualToString:@"TrainStation"]) {
 self.modelConten.station = self.content;
 }
 else if ([elementName isEqualToString:@"ArriveTime"]) {
 self.modelConten.arriveTime = self.content;
 }
 else if ([elementName isEqualToString:@"StartTime"]) {
 self.modelConten.startTime = self.content;
 }
 else if ([elementName isEqualToString:@"KM"]) {
 self.modelConten.KM = self.content;
 }
 else if ([elementName isEqualToString:@"TrainDetailInfo"]){
 [_stations addObject:self.modelConten];
 }
 }
 // 解析完成时调用
 - (void)parserDidEndDocument:(NSXMLParser *)parser{
 for (SGKMSchem * sc in self.stations) {
 NSLog(@"%@", sc);
 }
 }
 
 =================================
 6.xml解析DOM         =============
 =================================
 #import "GDataXMLNode.h"
 NSString * path = [[NSBundle mainBundle] pathForResource:@"xml.txt" ofType:nil];
 NSData * data = [[NSData alloc] initWithContentsOfFile:path];
 
 // 树结构描述类
 GDataXMLDocument * document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
 // 根结点描述类
 GDataXMLElement * element = [document rootElement];
 // 子结点描述类
 GDataXMLNode * firstNode = [element childAtIndex:1];
 GDataXMLNode * secondNode = [firstNode childAtIndex:0];
 _dataSource = [[NSMutableArray alloc] init];
 for (int i = 0; i < secondNode.childCount; i++) {
 NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
 GDataXMLNode * detailInfo = [secondNode childAtIndex:i];
 for (int j = 0; j < detailInfo.childCount; j++) {
 // 保留最底层的子结点,这些内容就是我们要解析的信息
 GDataXMLNode * messageNode = [detailInfo childAtIndex:j];
 // 获取结点名称
 NSString * name = [messageNode name];
 // 获取结点值
 NSString * value = [messageNode stringValue];
 [dict setObject:value forKey:name];
 }
 [_dataSource addObject:dict];
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */