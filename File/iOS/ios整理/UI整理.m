/*
 ============================================================================================
 ======================================== UI ================================================
 ============================================================================================
 =================================
 1.UIImageView动画=================
 =================================
 UIImageView * backView = [[UIImageView alloc] initWithFrame:self.view.frame];
 backView.frame = CGRectMake(100, 100, backView.frame.size.width, backView.frame.size.height);
 backView.animationImages = images;
 backView.animationDuration = duration;
 backView.animationRepeatCount = repeatCount;
 [backView startAnimating];
 
 =================================
 2.UIView动画======================
 =================================
 [UIView beginAnimations:nil context:nil];
 [UIView setAnimationDuration:0.5];
 [UIView setAnimationRepeatCount:1];
 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
 [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.imageView cache:YES];
 [UIView commitAnimations];
 
 =================================
 3.block动画======================
 =================================
 // 一个动画块结束后 继续执行completion动画块
 [UIView animateWithDuration:2.0f animations:^{
 [view1 setCenter:CGPointMake(10, 400)];
 [view1 setBackgroundColor:[UIColor yellowColor]];
 }completion:^(BOOL finished){
 // 设置透明度
 view1.alpha = 0.2;
 }];
 
 =================================
 4.停靠模式========================
 =================================
 UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(70, 150, 180, 180)];
 [backView setAutoresizesSubviews:YES];
 UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 120, 120)];
 [redView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
 [backView addSubview:redView];
 
 ================================
 5.模态视图=======================
 ================================
 [self presentViewController:self.subVC animated:YES completion:nil];
 [self dismissViewControllerAnimated:YES completion:nil];

 ================================
 6.触摸背景隐藏键盘=================
 ================================
   1)使用touchesBegan:withEvent:回调
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 NSLog(@"touchesBegan:%@\n\nevent:%@", touches, event);
 UITextField * field = (UITextField *)[self.view viewWithTag:FIELD_TAG];
 [field resignFirstResponder];
 }
   2)把view变成control对象
 UIControl * control = [[UIControl alloc] initWithFrame:self.view.frame];
 [control addTarget:self action:@selector(touchScreen:) forControlEvents:UIControlEventTouchUpInside];
 self.view = control;
 - (void)touchScreen:(id)sender{
 NSLog(@"touchScreen:%@", sender);
 UITextField * field = (UITextField *)[self.view viewWithTag:FIELD_TAG];
 [field resignFirstResponder];
 }
 
 ================================
 7.设置导航条======================
 ================================
 设置导航栏背景图片时，对图片的像素要求是严格的：
 人像模式(竖屏):320*44 640*88
 风景模式(横屏):480*32 960*64
 
 ================================
 8.UITextField===================
 ================================
 UITextField * txtFdName = [[UITextField alloc] initWithFrame:CGRectMake(40, 40, 240, 20)];
 // 设置文本框样式
 [txtFdName setBorderStyle:UITextBorderStyleRoundedRect];
 [txtFdName setMinimumFontSize:15];
 // 设置提示文字
 [txtFdName setPlaceholder:@"请输入文字"];
 // 设置清除键显示条件
 [txtFdName setClearButtonMode:UITextFieldViewModeWhileEditing];
 // 设置弹出键盘样式
 [txtFdName setKeyboardType:UIKeyboardTypeDefault];
 // 设置键盘返回键样式
 [txtFdName setReturnKeyType:UIReturnKeyGo];
 // 设置键盘弹出的样式
 [txtFdName setKeyboardAppearance:UIKeyboardAppearanceDark];
 // 强制控件变成第一响应者
 [txtFdName becomeFirstResponder];
 
 ================================
 9.UIAlertView UIActionSheet (本例是用nib构建的控件)
 ================================
 - (IBAction)alertBtn:(UIButton *)sender {
 UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"信息:" message:@"我是一个AlertView" delegate:self cancelButtonTitle:@"取消!" otherButtonTitles:@"给个好评吧,亲!", @"残忍地拒绝", @"容大爷想想", nil];
 [alert show];
 }
 // 此方法要指定弹出警示框的父视图
 - (IBAction)actionSheetBtn:(UIButton *)sender {
 UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"信息" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: @"再想想", nil];
 [actionSheet showInView:self.view];
 }
 
 ================================
 10.标签栏控制器===================
 ================================
 UITabBarItem * bti4 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:13];
 [vc4 setTabBarItem:bti4];
 // 设置提示信息 【重要】
 [vc4.tabBarItem setBadgeValue:@"4"];
 
 #pragma mark- UITabBarControllerDelegate
 // 当导航栏上的按钮被按下时 触发调用
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
     NSLog(@"%@", NSStringFromSelector(_cmd));
     NSLog(@"title:%@", viewController.tabBarItem.title);
 }
 
 // 当More界面的edit按钮按下时 触发调用
 // viewControllers所有子控制器都在里面 移动 其所在数组索引会发生变化
 - (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers{
     NSLog(@"%@", NSStringFromSelector(_cmd));
     for (UIViewController * vc in viewControllers) {
         NSLog(@"titels:%@", vc.tabBarItem.title);
     }
 }
 
 // 当More界面的done按钮按下时 触发调用
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    NSLog(@"%@%d", NSStringFromSelector(_cmd), changed);
    for (UIViewController * vc in viewControllers) {
    NSLog(@"titels:%@", vc.tabBarItem.title);
    }
 }
 
 ================================
 11.自定义标签栏控制器==============
 ================================
 SGKViewController1 * svc1 = [[SGKViewController1 alloc] init];
 SGKViewController2 * svc2 = [[SGKViewController2 alloc] init];
 SGKViewController3 * svc3 = [[SGKViewController3 alloc] init];
 SGKViewController4 * svc4 = [[SGKViewController4 alloc] init];
 // 把所有的ViewController加入
 [self setViewControllers:@[svc1, svc2, svc3, svc4]];
 // 我们只能隐藏自带的标签栏,实现一个假的标签栏,来达到自定义样式的目的
 [self.tabBar setHidden:YES];
 // 创建自己的标签样式 标签栏的大小是 320*49 图片大小也是这么大 可以使用图片大小来设定
 // 打开UIImageView的响应事件的能力
 [backView setUserInteractionEnabled:YES];
 // 切换当前显示的ViewController
 [self setSelectedIndex:sender.tag - COMMON_BTN_TAG];
 
 ================================
 12.NSUserDefaults===============
 ================================
 // 获取NSUserDefaults对象
 NSUserDefaults * udf = [NSUserDefaults standardUserDefaults];
 // 查找默认的某个值是否存在
 NSString * results = [udf objectForKey:@"firstLogin"];
 if (results.length == 0) {
 [self.lblResult setText:@"程序首次运行"];
 }
 else{
 [self.lblResult setText:@"程序非首次运行"];
 }
 [udf setObject:@"YES" forKey:@"firstLogin"];
 
 ================================
 13.视图控制器=====================
 ================================
 // 用下面的语句可以判断该视图是否被加载到某视图或者视图控制器上
 if (self.blueVC.view.superview != nil){}
 
 ================================
 14.触摸事件=======================
 ================================
 // 开启多触摸开关 模拟器上按option可模拟2根手指
 [self.view setMultipleTouchEnabled:YES];
 // touches触摸信息
 // event触摸的事件
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 UILabel * lblTips = (UILabel *)[self.view viewWithTag:11];
 [lblTips setText:@"开始触摸"];
 // 获取触摸屏的手指
 UITouch * finger = [touches anyObject];
 // 获取在触摸屏上的坐标
 CGPoint location = [finger locationInView:self.view];
 NSLog(@"location:%@", NSStringFromCGPoint(location));
 
 self.beginLocation = location;
 
 // 多屏触发
 // 获取轻击次数
 NSInteger tapCount = [finger tapCount];
 // 获取当前屏的手指数
 NSInteger fingerSum = [touches count];
 UILabel * lblTips2 = (UILabel *)[self.view viewWithTag:12];
 [lblTips2 setText:[NSString stringWithFormat:@"有%d根手指触摸,轻击%d次", fingerSum, tapCount]];
 
 }
 
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
 UILabel * lblTips = (UILabel *)[self.view viewWithTag:11];
 [lblTips setText:@"触摸移动"];
 }
 
 -(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
 UILabel * lblTips = (UILabel *)[self.view viewWithTag:11];
 [lblTips setText:@"触摸结束"];
 // 获取触摸屏的手指
 UITouch * finger = [touches anyObject];
 // 获取在触摸屏上的坐标
 CGPoint location = [finger locationInView:self.view];
 NSLog(@"location:%@", NSStringFromCGPoint(location));
 
 // 条件1：求位置
 CGFloat offsetX = fabs(location.x - self.beginLocation.x);
 CGFloat offsetY = fabs(location.y - self.beginLocation.y);
 CGFloat distance = sqrt(offsetX * offsetX + offsetY * offsetY);
 // 条件2：求偏移量
 CGFloat offset = offsetY / 2;
 if (distance > MIN_DISTANCE && offset < MAX_OFFSET) {
 [lblTips setText:@"横扫触发"];
 }
 }
 
 -(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    UILabel * lblTips = (UILabel *)[self.view viewWithTag:11];
    [lblTips setText:@"触摸取消"];
 }
 
 ================================
 15.手势识别器=====================
 ================================
 // 创建手势识别器
 UITapGestureRecognizer * tapGestureSingle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureSingleAction:)];
 // 设置轻击手势能识别的点击次数
 [tapGestureSingle setNumberOfTapsRequired:1];
 // 设置轻击手势能识别触摸手指的数量
 [tapGestureSingle setNumberOfTouchesRequired:1];
 // 将手势识别器添加到视图上去
 [self.view addGestureRecognizer:tapGestureSingle];
 // 如果要识别多种手势,为了不让其被干扰,应该设置单击事件的优先级,如下:
 // 【重要】设置单击事件的优先级 ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
 [tapGestureSingle requireGestureRecognizerToFail:tapGestureDouble];
 
 ================================
 16.长按手势识别器=================
 ================================
 // 创建一个长按手势识别器对象
 UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
 // 设置长按手势的最在持续时间
 longPressGesture.minimumPressDuration = 1;
 // 设置长按手势的触摸数量
 longPressGesture.numberOfTouchesRequired = 1;
 // 添加长按手势到视图上去
 [self.view addGestureRecognizer:longPressGesture];
 
 - (void)longPressGestureAction:(UILongPressGestureRecognizer *)sender{
 [[self lblTips] setText:@"长按事件产生"];
 }
 
 ================================
 17.轻扫手势识别器=================
 ================================
 // 创建一个轻扫手势识别器对象
 UISwipeGestureRecognizer * swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
 // 设置触摸数量
 [swipeGesture setNumberOfTouchesRequired:1];
 // 设置轻扫方向(似乎只有两两识别)
 [swipeGesture setDirection:
 UISwipeGestureRecognizerDirectionLeft |
 UISwipeGestureRecognizerDirectionRight |
 UISwipeGestureRecognizerDirectionUp |
 UISwipeGestureRecognizerDirectionDown];
 [self.view addGestureRecognizer:swipeGesture];
 
 - (void)swipeGestureAction:(UISwipeGestureRecognizer *)sender{
 [[self lblTips] setText:@"轻扫手势"];
 [self.navigationController popViewControllerAnimated:YES];
 }
 
 ================================
 18.拖拽手势识别器=================
 ================================
 // 创建拖拽手势识别器对象
 UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
 [lblPan addGestureRecognizer:panGesture];
 
 - (void)panGestureAction:(UIPanGestureRecognizer *)sender{
 //    CGPoint velocit = [sender velocityInView:self.view];
 //    CGPoint location = [sender locationInView:self.view];
 CGPoint translation = [sender translationInView:self.view];
 UILabel * lblPan = (UILabel *)sender.view;
 CGPoint center = CGPointMake(lblPan.center.x+translation.x, lblPan.center.y+translation.y);
 [lblPan setCenter:center];
 // 清空拖拽手势识别器在父视图中的位移量
 [sender setTranslation:CGPointZero inView:self.view];
 }
 
 ================================
 19.捏合手势识别器=================
 ================================
 // 创建捏合手势识别器对象
 UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureAction:)];
 // 捏合手势识别器可以自动让视图识别两个触摸
 [imageView addGestureRecognizer:pinchGesture];
 
 - (void)pinchGestureAction:(UIPinchGestureRecognizer *)sender{
 UIImageView * imageView = (UIImageView *)sender.view;
 // 获取捏合比例
 CGFloat scale = [sender scale];
 // 按照比例修改视图大小
 [imageView setTransform:CGAffineTransformMakeScale(scale, scale)];
 }
 
 ================================
 20.旋转手势识别器=================
 ================================
 // 创建旋转手势识别器对象
 UIRotationGestureRecognizer * rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureAction:)];
 [imageView addGestureRecognizer:rotationGesture];
 
 - (void)rotationGestureAction:(UIRotationGestureRecognizer *)sender{
 // 旋转的角度
 CGFloat rotation = sender.rotation;
 UIImageView * imageView = (UIImageView *)sender.view;
 [imageView setTransform:CGAffineTransformMakeRotation(rotation)];
 }
 
 ================================
 21.block========================
 ================================
 int(^block)(int a, int b) = ^(int a, int b){
 return a+b;
 };
 NSLog(@"C:%d", block(5, 3));
 
 ================================
 22.滚动视图======================
 ================================
 // 关闭自适应
 [self setAutomaticallyAdjustsScrollViewInsets:NO];
 // 创建UIScrollView对象
 UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 40, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT)];
 // 设置滚动视图内容视图的滚动范围 它必须比scrollView的frame大
 [scrollView setContentSize:CGSizeMake(SCROLL_VIEW_WIDTH * 4, SCROLL_VIEW_HEIGHT * 4)];
 // 内容的起始位置
 [scrollView setContentOffset:CGPointMake(0, 0)];
 // 关闭边界反弹效果
 [scrollView setBounces:NO];
 // 关闭横向滚动条
 [scrollView setShowsHorizontalScrollIndicator:NO];
 // 关闭纵向滚动条
 [scrollView setShowsVerticalScrollIndicator:NO];
 // 设置滚动视图的内容视图缩放倍数，最大和最小不能相等
 [scrollView setMaximumZoomScale:10];
 [scrollView setMinimumZoomScale:0.1];
 // 开启滚动视图的缩放是通过协议实现的
 [scrollView setDelegate:self];
 // 创建一个UIImageView对象作为内容视图,直接加在subView上
 UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scrollView.jpg"]];
 [imageView setFrame:CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)];
 // 直接加在subView上
 [scrollView addSubview:imageView];
 
 #pragma mark- UIScrollViewDelegate
 // 如果要开启缩放功能
 - (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
 // 把支持缩放的内容视图返回
 return [scrollView.subviews objectAtIndex:0];
 }
 // 滚动视图的内容在滚动期间 是经历了 加速-滑动-减速 三个过程
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 NSLog(@"%@:%d", NSStringFromSelector(_cmd), decelerate);
 NSLog(@"offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
 }
 // 本方法是当内容在减速阶段结束 获取内容视图ContentOffset
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 NSLog(@"%@", NSStringFromSelector(_cmd));
 NSLog(@"offset:%@", NSStringFromCGPoint(scrollView.contentOffset));
 }
 
 ================================
 23.滚动视图+PageControl==========
 ================================
 UIScrollView * backView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 30, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT)];
 // 开启视图分页效果
 [backView setDelegate:self];
 [backView setPagingEnabled:YES];
 [backView setBounces:NO];
 [backView setShowsHorizontalScrollIndicator:NO];
 [backView setContentSize:CGSizeMake(SCROLL_VIEW_WIDTH * 15, SCROLL_VIEW_HEIGHT)];
 for (int i = 0; i < 15; i++) {[backView addSubview:imageView];}
 
 UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(10, 30+SCROLL_VIEW_HEIGHT-25, SCROLL_VIEW_WIDTH, 25)];
 [pageView setBackgroundColor:[UIColor blackColor]];
 [pageView setAlpha:0.7];
 [self.view addSubview:pageView];
 _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
 [_pageControl setNumberOfPages:15];
 [_pageControl setCurrentPage:0];
 // 设置控件识别事件能力 默认是打开的
 [_pageControl setEnabled:NO];
 [pageView addSubview:_pageControl];
 
 // 设置pageControl对象的显示
 [_pageControl setCurrentPage:_curPage];
 // 设置背景图的偏移
 [backView setContentOffset:CGPointMake(_curPage * SCROLL_VIEW_WIDTH, 0)];
 
 ================================
 24.表格UITableView==============
 ================================
 NSInteger section = indexPath.section;
 NSInteger row = indexPath.row;
 NSString * msg = [[self.dataSource objectAtIndex:section] objectAtIndex:row];
 // 设置单元格的正标题
 [cell.textLabel setText:msg];
 // 设置单元格的副标题
 [cell.detailTextLabel setText:@"详细"];
 // 设置单元格背景色
 [cell setBackgroundColor:[UIColor whiteColor]];
 // 设置单元格图片
 [cell.imageView setImage:[UIImage imageNamed:@"36_7.jpg"]];
 // 设置单元格挂件
 [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
 // 设置单元格自定义挂件 用自定义样式时要谨慎
 UISwitch * swc = [[UISwitch alloc] init];
 [swc setOn:YES];
 [swc addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
 [cell setAccessoryView:swc];
 // 设置单元格中样式
 UIView * selectView = [[UIView alloc] init];
 [selectView setBackgroundColor:[UIColor blueColor]];
 [cell setSelectedBackgroundView:selectView];
 
 // 单元格的操作
 // 添加编辑键
 [self.navigationItem setRightBarButtonItem:self.editButtonItem];
 // 设置编辑键的显示等
 - (void)setEditing:(BOOL)editing animated:(BOOL)animated{
 // 想实现表格的插入、删除、移动操作
 //    editing = !editing;
 // 【注】此句必须写上
 [super setEditing:editing animated:YES];
 // 激活表格编辑状态后，默认是删除操作，如果想实现插入操作（只有两种编辑类型），通过协议实现
 [_tableView setEditing:editing animated:YES];
 }
 
 #pragma mark= UITableViewDelegate
 // 选中行
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 SGKDetailViewController * dvc = [[SGKDetailViewController alloc] init];
 [dvc.navigationItem setTitle:[self.dataSource objectAtIndex:indexPath.row]];
 [self.navigationController pushViewController:dvc animated:YES];
 }
 
 // 反选行
 - (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
 }
 
 // 指定编辑类型
 - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
 if (indexPath.row < 6) {
 return  UITableViewCellEditingStyleDelete;
 }
 else{
 return UITableViewCellEditingStyleInsert;
 }
 }
 
 // 除了激活表格视图的编辑状态和制定某一行支持的编辑状态之外，还要实现如下方法，对表格进行插入和删除操作
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 // 如果选中的是插入行，就在对应的数据源中插入新的数据
 if (editingStyle == UITableViewCellEditingStyleInsert) {
 NSString * newData = @"sghick";
 [self.dataSource insertObject:newData atIndex:indexPath.row];
 // 我们还需要重新加载表格数据(更新UI操作)
 //        [_tableView reloadData];
 [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
 }
 else if (editingStyle == UITableViewCellEditingStyleDelete) {
 [self.dataSource removeObjectAtIndex:indexPath.row];
 [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
 }
 }
 
 // 开启可移动状态
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
 if (indexPath.row > 0) {
 return YES;
 }
 return NO;
 }
 
 // 当表格被移动的时候调用，我们要在这里更新数据源结构
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
 // 我们要做的是把两个数据进行交换 sourceIndexPath是源索引 destinationIndexPath是目标索引
 NSString * sourceData = [self.dataSource objectAtIndex:sourceIndexPath.row];
 //    NSString * destinationData = [self.dataSource objectAtIndex:destinationIndexPath.row];
 // 不要用exchange函数
 // 我们采用的最原始的办法把目标索引处插入 再在移动数据删除掉
 [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
 [self.dataSource insertObject:sourceData atIndex:destinationIndexPath.row];
 }
 
 1)加载普通动态单元格
 static NSString * identifier = @"cell";
 UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
 }

 2)加载普通动态单元格Nib
 static NSString * identifier = @"nibCell";
 // 加载nib文件资源
 UINib * nib = [UINib nibWithNibName:@"SGKCell" bundle:nil];
 [tableView registerNib:nib forCellReuseIdentifier:identifier];
 UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];

 3)加载普通动态单元格自定义的
 SGKCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
 if (cell == nil) {
 cell = [[SGKCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
 }

 ================================
 25.表格分组展开===================
 ================================
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 // 当用户需要隐藏某个分区时 返回0即可/或者把行高设置为0
 NSNumber * flagNum = [_flag objectAtIndex:section];
 BOOL flag = [flagNum boolValue];
 if (!flag) {
 return 0;
 }
 else{
 return [[self.dataSource objectAtIndex:section] count];
 }
 }
 
 - (void)titleBtnClick:(UIButton *)sender{
 // 切换标识
 [self resetFlagWithIndex:sender.tag - 1];
 // 【核心代码】
 NSIndexSet * set = [[NSIndexSet alloc] initWithIndex:sender.tag - 1];
 [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
 }
 
 ================================
 26.表格多行删除===================
 ================================
 // 返回编辑界面的状态...下面两个一起表示可移动状态
 - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
 return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
 }
 
 #pragma mark- UITableViewDelegate
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 // 获取当前选中的单元格
 UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
 // 获取数据
 NSString * str = cell.textLabel.text;
 [_selectedRows addObject:str];
 }
 
 - (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
 // 获取当前选中的单元格
 UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
 // 获取数据
 NSString * str = cell.textLabel.text;
 [_selectedRows removeObject:str];
 }
 
 ================================
 26.表格搜索======================
 ================================
 UITableView * _tableView;
 UISearchDisplayController * _searchDC;
 UISearchBar * _searchBar;
 
 _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
 [_searchBar setSearchBarStyle:UISearchBarStyleMinimal];
 [_tableView setTableHeaderView:_searchBar];
 // initWithSearchBar:用于搜索内容的_searchBar
 // contentsController:提供给表格视图数据源的控制对象，这个对象必须是实现了表格协议的
 _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
 // 设置自带的searchController的表格视图
 [_searchDC setSearchResultsDataSource:self];
 [_searchDC setSearchResultsDelegate:self];
 
 
 #pragma mark- UITableViewDataSource
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 // 判断当前tableView 是不是我们原始的tableView
 // [核心代码]  如果不是，说明这是searchBar自带的 我们用单分区表来显示搜索结果
 if (tableView != _tableView) {
 return 1;
 }
 else{
 return self.dataSource.count;
 }
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 if (tableView != _tableView) {
 // 先把之前的搜索结果清空
 [_resultSearch removeAllObjects];
 // 获取最新关键字
 NSString * msg = _searchBar.text;
 for (int i = 0; i < _dataSource.count; i++) {
 NSArray * section = _dataSource[i];
 for (int j = 0; j < section.count; j++) {
 NSString * str = section[j];
 // 判读是否包涵搜索关键字
 NSRange range = [str rangeOfString:msg];
 if (range.location != NSNotFound) {
 [_resultSearch addObject:str];
 }
 }
 }
 return _resultSearch.count;
 }
 else{
 return [[self.dataSource objectAtIndex:section] count];
 }
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 static NSString * identifier = @"sgk";
 UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
 }
 if (tableView != _tableView) {
 [cell.textLabel setText:[self.resultSearch objectAtIndex:indexPath.row]];
 }
 else{
 [cell.textLabel setText:[[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
 }
 return cell;
 }
 
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
 if (tableView != _tableView) {
 return nil;
 }
 else{
 return [NSString stringWithFormat:@"%c", 'A'+section];
 }
 }
 
 ================================
 27.侧滑的界面(第三方)==============
 ================================
 #import @"DDMenuController.h"
 // 支持ARC 不需要其它框架
 SGKRootViewController * rvc = [[SGKRootViewController alloc] init];
 UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:rvc];
 // 主视图控制器
 DDMenuController * mc = [[DDMenuController alloc] initWithRootViewController:nav];
 // 左视图控制器
 SGKLeftViewController * leftvc = [[SGKLeftViewController alloc] init];
 [mc setLeftViewController:leftvc];
 // 右视图控制器
 SGKRightViewController * rightvc = [[SGKRightViewController alloc] init];
 [mc setRightViewController:rightvc];
 [self.window setRootViewController:mc];
 
 ================================
 28.Nib创建控件===================
 ================================
 // .xib文件的名字和它是一样的可以直接用int构建
 //    SGKRootViewController * rvc = [[SGKRootViewController alloc] init];
 // .xib名字不一致时用下面的方法 bundle:nil表示路径在默认文件
 SGKRootViewController * rvc = [[SGKRootViewController alloc] initWithNibName:@"SGKRootViewController" bundle:nil];
 [self.window setRootViewController:rvc];
 
 ================================
 29.自适应Cell高度 ================
 ================================
 // [核心]取得字符串在指定范围内,指定字体大小的Frame
 CGRect rect = [str boundingRectWithSize:CGSizeMake(200, 998) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
 // 设置label自动换行
 [label setLineBreakMode:NSLineBreakByCharWrapping];
 // setNumberOfLines设置为0也可以
 [label setNumberOfLines:rect.size.height/17];
 
 
 
 
 
 */



