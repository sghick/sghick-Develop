/*
 ============================================================================================
 ======================================== OC ================================================
 ============================================================================================

 =================================
 1.类别语法========================
 =================================
 #import "NSObject+HelloWord.h"
 
 =================================
 2.延展_匿名类别====================
 =================================
 
 @interface Student()
 @end
 
 =================================
 3.归档&解档   ====================
 =================================
 1)
 // 遵守协议 NSCoding
 // 实现协议
 # pragma mark-NSCoding
 - (void)encodeWithCoder:(NSCoder *)aCoder{
 [aCoder encodeObject:self.name forKey:@"_name"];
 [aCoder encodeInteger:self.age forKey:@"_age"];
 }
 - (id)initWithCoder:(NSCoder *)aDecoder{
 self.name = [aDecoder decodeObjectForKey:@"_name"];
 self.age = [aDecoder decodeIntegerForKey:@"_age"];
 return self;
 }
 
 SGKTeacher * t1 = [[SGKTeacher alloc] initWithName:@"王红文" age:23];
 NSData * d1 = [NSKeyedArchiver archivedDataWithRootObject:t1];
 NSArray * arr = [NSArray arrayWithObjects:d1, nil];
 BOOL result = [arr writeToFile:[PATH stringByAppendingPathComponent:@"plist"] atomically:YES];
 
 NSArray * arr2 = [NSArray arrayWithContentsOfFile:[PATH stringByAppendingPathComponent:@"plist"]];
 for (NSData * sd in arr2) {
 [[NSKeyedUnarchiver unarchiveObjectWithData:sd] print];
 }
 
 2)
 NSMutableData* md = [[NSMutableData alloc] init];
 NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:md];
 [archiver encodeObject:t1 forKey:@"t1"];
 [archiver encodeObject:t2 forKey:@"t2"];
 [archiver finishEncoding];
 [md writeToFile:[PATH stringByAppendingPathComponent:@"plist"] atomically:YES];
 
 =================================
 5.深复制&浅复制====================
 =================================
 // 浅复制只copy指针,不重新分配内存,不加copy或者mutableCopy的为浅复制,我们常用的
 // 深复制会重新分配一块内存和用新的指针
 // 存放之前[str1 copy]或者[str mutableCopy]
 // 【注意】copy后的副本是一个不可变的,不论原副本是否可变
 // 【注意】mutableCopy后的副本才是可变的,不论原副本是否可变
 
 =================================
 6.instancetype作为构造方法的返回值==
 =================================
 instancetype表示构造方法所在的类
 
 =================================
 7.KVC                   =========
 =================================
 // 使用KVC的好处是 不用关注被赋值对象的结构
 if ([firstVC respondsToSelector:@selector(setColorString:)]) {
 [firstVC setValue:@"yellow" forKey:@"colorString"];
 }
 
 =================================
 8.KVO                   =========
 =================================
 _boy = [[SGKBoy alloc] init];
 _boy.name = @"郭靖";
 _girl1 = [[SGKGirl alloc] init];
 _girl1.name = @"黄蓉";
 _girl2 = [[SGKGirl alloc] init];
 _girl2.name = @"小昭";
 
 // 注册当前控制器为Boy对象的观察者身份,当boy对象的属性发生变化的时候,就会通知控制器
 //
 // 第一个参数:要成为观察者的对象,这里是self
 // 第二个参数:观察者要追踪的变化的属性名
 // 第三个参数:关注的属性的变化规则
 // 第四个参数:是一个const char *  一般用于传值
 //
[_boy addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];
[_girl1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];
[_girl2 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:NULL];
 
 // 观察者对象要实现的方法,当观察的属性发生变化时就会调用这个方法
 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
 // 参数object就是我们当前观察对象的指针
 // isMemberOfClass的参数可以是对象,可以是类,效果是一样的
 if ([object isMemberOfClass:[_boy class]]) {
 NSString * oldName = [change objectForKey:@"old"];
 NSString * newName = [change objectForKey:@"new"];
 NSLog(@"boy:%@,%@", oldName, newName);
 }
 if ([object isMemberOfClass:[SGKGirl class]]) {
 NSString * oldName = [change objectForKey:@"old"];
 NSString * newName = [change objectForKey:@"new"];
 NSLog(@"girl:%@,%@", oldName, newName);
 }
 }

 =================================
 9.通知中心               =========
 =================================
 // 注册通知中心
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAll:) name:@"changeAll" object:nil];
 
 - (void)changeAll:(NSNotification *)notice{
 // 使用通知中心的参数
 NSString * str = [notice object];
 if ([str isEqualToString:@"red"]) {
 [self.view setBackgroundColor:[UIColor redColor]];
 }
 }
 
 // 发送通知
 NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
 [center postNotificationName:@"changeAll" object:@"red"];
 
 =================================
 10.storyBoard           =========
 =================================
 1)singelView的模板
 2)静态单元格
 在storyBoard中才有效,把tableView的Content值设置为Static Cells
 
 =================================
 11.NSThread             =========
 =================================
 for (int i = 0; i < 4; i++) {
 NSThread * task = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:self.urls[i]];
 [task setName:[NSString stringWithFormat:@"Thread%d", i]];
 [task start];
 // 如果要立即执行线程,可以加上下面一句
 [NSThread sleepForTimeInterval:0.0001f];
 }
 
 =================================
 12.NSOperationQueue     =========
 =================================
 NSOperationQueue * queue = [[NSOperationQueue alloc] init];
 // 设置最大并行执行任务数
 [queue setMaxConcurrentOperationCount:1];
 NSOperation * task = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:URL_IMAGE_0];
 [queue addOperation:task];
 // 设置等待队列中所有线程任务完成
 [queue waitUntilAllOperationsAreFinished];
 // 取消队列内所有线程任务
 //    [queue cancelAllOperations];
 
 
 =================================
 13.GCD                  =========
 =================================
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
 13.FMDB                  ========
 =================================
 // 用于处理操作
 #import "FMDatabase.h"
 // 用于处理结果
 #import "FMResultSet.h"
 // sqlite3数据库操作
 FMDatabase * _dataBase;
 
 // 创建数据库
 - (void)createDataBase{
 NSString * dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/stu.db"];
 NSLog(@"dpPath:%@", dbPath);
 // 获取数据库
 _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
 // 如果有数据库,则打开,没有则创建一个再打开
 BOOL isSet = [_dataBase open];
 if (!isSet) {
 NSLog(@"打开数据库失败! %@\n请手动创建!", _dataBase.lastErrorMessage);
 }
 else{
 NSString * sqlCreateTable = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement,%@ varchar(128), %@ integer);", DB_TABLE_STUDENT_MESSAGE, DB_STUDENT_MESSAGE_NAME, DB_STUDENT_MESSAGE_AGE];
 // 执行sql语句,参数是对象
 BOOL isSuccess = [_dataBase executeUpdate:sqlCreateTable];
 if (!isSuccess) {
 NSLog(@"创建失败! %@", _dataBase.lastErrorMessage);
 }
 else{
 NSLog(@"创建成功!");
 }
 }
 }
 // 插入
 - (IBAction)addUser:(UIButton *)sender {
 NSString * name = self.nameField.text;
 NSString * age = self.ageField.text;
 if (name.length==0 || age.length==0) {
 NSLog(@"不能为空");
 return;
 }
 NSString * sql = SQL_INSERT;
 BOOL isSuccess = [_dataBase executeUpdate:sql, name, age];
 if (!isSuccess) {
 NSLog(@"插入失败! %@", _dataBase.lastErrorMessage);
 }
 else{
 NSLog(@"插入成功");
 }
 }
 // 删除
 - (IBAction)deleteUser:(UIButton *)sender {
 if (self.curUser == nil) {
 NSLog(@"请选择一项");
 return;
 }
 NSString * condition = [NSString stringWithFormat:SQL_CONDITION, DB_STUDENT_MESSAGE_ID];
 NSString * sql = [SQL_DELETE stringByAppendingString:condition];
 BOOL isSuccess = [_dataBase executeUpdate:sql, [NSNumber numberWithInteger:self.curUser.uid]];
 if (!isSuccess) {
 NSLog(@"删除失败! %@", _dataBase.lastErrorMessage);
 }
 else{
 NSLog(@"删除成功");
 }
 }
 // 修改
 - (IBAction)updateUser:(UIButton *)sender {
 NSString * name = self.nameField.text;
 NSString * age = self.ageField.text;
 if (self.curUser == nil) {
 NSLog(@"请选择一项");
 return;
 }
 if (name.length==0 || age.length==0) {
 NSLog(@"不能为空");
 return;
 }
 NSString * condition = [NSString stringWithFormat:SQL_CONDITION, DB_STUDENT_MESSAGE_ID];
 NSString * sql = [SQL_UPDATE stringByAppendingString:condition];
 BOOL isSuccess = [_dataBase executeUpdate:sql, name, age, [NSNumber numberWithInteger:self.curUser.uid]];
 if (!isSuccess) {
 NSLog(@"更新失败! %@", _dataBase.lastErrorMessage);
 }
 else{
 NSLog(@"更新成功");
 }
 }
 // 查询
 - (IBAction)searchUser:(UIButton *)sender {
 FMResultSet * set = [_dataBase executeQuery:SQL_SEARCH];
 NSMutableArray * source = [[NSMutableArray alloc] init];
 while ([set next]) {
 SGKUser * user = [[SGKUser alloc] init];
 user.uid = [set intForColumn:DB_STUDENT_MESSAGE_ID];
 user.name = [set stringForColumn:DB_STUDENT_MESSAGE_NAME];
 user.age = [set intForColumn:DB_STUDENT_MESSAGE_AGE];
 [source addObject:user];
 }
 self.dataSource = source;
 [self.userTableView reloadData];
 }
 
 =================================
 14.NSString =====================
 =================================
 // 转大写
 NSString * newStr1 = [@"aBcD" uppercaseString];
 // 转小写
 NSString * newStr2 = [@"aBcD" lowercaseString];
 // 判断前缀
 BOOL hasHttp = [@"http://www.baidu.com" hasPrefix:@"http://"];
 // 判断后缀
 BOOL hasCom = [@"http://www.baidu.com" hasSuffix:@".com"];
 
 
 
 
 
 
 */
