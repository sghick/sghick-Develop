//
//  WPAPITest.m
//  WisdomPark
//
//  Created by 丁治文 on 15/1/31.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "WPAPITest.h"
#import "WPUrlRequest.h"
#import "WPUrlRequest+WP.h"
#import "WPNetManager.h"
#import "WPDalFactory.h"

#import "WPBatchMain.h"

@implementation WPAPITest{
    WPMyHomeDal * _myHomeDal;
    WPDailyLifeDal * _dailyLifeDal;
    WPWorkDal * _workDal;
    WPOperationDal * _operationDal;
}

- (void)run{
    [self setUp];
    @try {
        // add testCode here
        WpLog(@"========================================================================================================================");
        WpLog(@"====================================================Start===============================================================");
        
        // 我的首页
//        [self test101];
//        [self test102];
//        [self test103];
//        [self test104];
//        [self test105];
//        [self test106];
//        [self test107];
//        [self test108];
//        [self test109];
//        [self test110];
//        [self test111];
//        [self test112];
//        [self test113];
//        [self test114];
//        [self test115];
//        [self test116];
//        [self test117];
//        [self test118];
        
        // 日常生活
//        [self test201];
//        [self test202];
//        [self test203];
//        [self test204];
//        [self test205];
//        [self test206];
//        [self test207];
//        [self test208];
//        [self test209];
//        [self test210];
//        [self test211];
//        [self test216];
//        [self test217];
//        [self test218];
//        [self test219];
//        [self test220];
//        [self test221];
//        [self test222];
//        [self test223];
//        [self test224];
        
        // 行政办公
//        [self test301];
//        [self test302];
//        [self test303];
//        [self test304];
//        [self test305];
//        [self test306];
//        [self test307];
//        [self test308];
//        [self test309];
//        [self test310];
//        [self test311];
//        [self test312];
//        [self test313];
//        [self test314];
        
        // 园区运营
//        [self test401];
//        [self test402];
//        [self test403];
//        [self test404];
//        [self test405];
//        [self test406];
//        [self test407];
//        [self test408];
//        [self test409];
//        [self test410];
//        [self test411];
//        [self test412];
//        [self test413];
//        [self test414];
//        [self test415];
        
        WpLog(@"=====================================================end================================================================");
        WpLog(@"========================================================================================================================");
    }
    @catch (NSException *exception) {
        WpLog(@"测试失败");
    }
    @finally {
        [self tearDown];
    }
}

// 初始化条件
- (void)setUp{
    // 初始化一个工厂
    WPDalFactory * factory = [[WPDalFactory alloc] initWithDelegate:self finishedSelector:@selector(finished:) faildSelector:@selector(faild:)];
    // 我的首页
    _myHomeDal = [factory createMyHomeDal];
    // 日常生活
    _dailyLifeDal = [factory createDailyLifeDal];
    // 行政办公
    _workDal = [factory createWorkDal];
    // 园区运营
    _operationDal = [factory createOperationDal];
    
    WPUserSession * session = [WPUserSession userSessionFromUserDefaults];
    if (session) {
        WpDebugLog(@"%@ %@", session.userName, session.userToken);
    }
}

// 结束
- (void)tearDown{
    
}


- (void)finished:(WPUrlRequest *)request{
    WPBaseModel * model = (WPBaseModel *)[request responseParserObject];
    if ([@"requestUserLogin" isEqualToString:request.key]) {
        WPUserLoginModel * userLogin = (WPUserLoginModel *)model;
        if (!userLogin || !userLogin.token || !userLogin.userName) {
            WpWarmLog(@"登陆失败");
            [WPNetManager cancelAllTask];
            return;
        }
        WPUserSession * session = [WPUserSession userSessionFromUserDefaults];
        if (!session) {
            session = [[WPUserSession alloc] init];
        }
        session.userName = userLogin.userName;
        session.userToken = userLogin.token;
        [session save];
    }
}

- (void)faild:(WPUrlRequest *)request{
    if (request.responseErrorMsg) {
        WpErrorLog(@"%@", request.responseErrorMsg);
    }
    WpDebugLog(@"测试请求失败:%@ %@", request.key, request.urlString);
}

#pragma mark - 我的首页
- (void)test101{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestUserLogin];
    [request.paramsDict setObject:@"app" forKey:@"userName"];
    [request.paramsDict setObject:@"app=" forKey:@"password"];
    [request.paramsDict setObject:@"iphone" forKey:@"phoneType"];
    [request.paramsDict setObject:@"IOS8" forKey:@"appOpr"];
    [request.paramsDict setObject:@"1.0" forKey:@"appVersion"];
    [request.parserMapper setObject:@"WPUserMessageModel" forKey:parserReturnTypeMainModelOfKey];
    [WPNetManager addRequest:request];
}

- (void)test102{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestUserloginOut];
    [WPNetManager addRequest:request];
}

- (void)test103{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestUserMsg];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"2" forKey:@"messageType"];
    [WPNetManager addRequest:request];
}

- (void)test104{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestUserMessage];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test105{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestMenu];
    [request.paramsDict setObject:@"0" forKey:@"type"];
    [WPNetManager addRequest:request];
}

- (void)test106{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestMenu];
    [request.paramsDict setObject:@"1" forKey:@"type"];
    [WPNetManager addRequest:request];
}

- (void)test107{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestUserMsgPer];
    [request.paramsDict setObject:@"5" forKey:@"messageID"];
    [WPNetManager addRequest:request];
}

- (void)test108{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestUserMsgDel];
    [request.paramsDict setObject:@"5" forKey:@"messageID"];
    [WPNetManager addRequest:request];
}

- (void)test109{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestClosePushMsg];
    [request.paramsDict setObject:@"1,1;3,1" forKey:@"messageSwitch"];
    [WPNetManager addRequest:request];
}

- (void)test110{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestMsgReader];
    [request.paramsDict setObject:@"1" forKey:@"messageId"];
    [WPNetManager addRequest:request];
}

- (void)test111{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestPwChang];
    [request.paramsDict setObject:@"123" forKey:@"oldPwd"];
    [request.paramsDict setObject:@"LbaEr5emVyk=" forKey:@"newPwd"];
    [WPNetManager addRequest:request];
}

- (void)test112{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestUpdateVersion];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test113{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestCheckUpdateVersion];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test114{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestFastMenu];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test115{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestAddFastMenu];
    [request.paramsDict setObject:@"263" forKey:@"menuId"];
    [WPNetManager addRequest:request];
}

- (void)test116{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestDeleteFastMenu];
    [request.paramsDict setObject:@"263" forKey:@"menuId"];
    [WPNetManager addRequest:request];
}

- (void)test117{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestWeather];
    [WPNetManager addRequest:request];
}

- (void)test118{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_myHomeDal requestHomeMsg];
    [WPNetManager addRequest:request];
}

#pragma mark - 日常生活
- (void)test201{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetBookType];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test202{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestBookBorrow];
    [request.paramsDict setObject:@"1234" forKey:@"bookid"];
//    [request.paramsDict setObject:@"0" forKey:@"borrowType"];
//    [request.paramsDict setObject:@"2015-02-03 15:30" forKey:@"borrowTime"];
    [WPNetManager addRequest:request];
}

- (void)test203{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetBookByType];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"1" forKey:@"bookType"];
    [WPNetManager addRequest:request];
}

- (void)test204{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetBorrowBookByUserId];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test205{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetBookByName];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"书籍1" forKey:@"bookName"];
    [WPNetManager addRequest:request];
}

- (void)test206{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetperson];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test207{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetfoodList];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"1" forKey:@"dining_id"];
    [WPNetManager addRequest:request];
}

- (void)test208{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetmenuList];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"2" forKey:@"dining_id"];
    [WPNetManager addRequest:request];
}

- (void)test209{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestDaliyMeals];
    [WPNetManager addRequest:request];
}

- (void)test210{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestRestaurantStars];
    [WPNetManager addRequest:request];
}

- (void)test211{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestMealApply];
    [request.paramsDict setObject:@"1:2,2:3" forKey:@"dishMes"];
    [request.paramsDict setObject:@"13" forKey:@"dishTotalprice"];
    [WPNetManager addRequest:request];
}

- (void)test216{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestScheduledBus];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test217{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestEnrollScheduledBus];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"4" forKey:@"shuttleBusId"];
    [WPNetManager addRequest:request];
}

- (void)test218{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetSportsSiteInfo];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test219{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestSiteCourseApply];
    [request.paramsDict setObject:@"02-03" forKey:@"subscribeDate"];
    [request.paramsDict setObject:@"17" forKey:@"subscribeTime"];
    [request.paramsDict setObject:@"" forKey:@"subscribeContent"];
    [request.paramsDict setObject:@"2" forKey:@"gymId"];
    [WPNetManager addRequest:request];
}

- (void)test220{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetSportsExerciseInfo];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test221{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestGetFitnessCourse];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test222{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestPublicsSY];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test223{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestPublicALL];
    [WPNetManager addRequest:request];
}

- (void)test224{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_dailyLifeDal requestSavepublicSubmit];
    [request.paramsDict setObject:@"12689" forKey:@"surveyId"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:@"12689" forKey:@"surveyId"];
    [dic setObject:@"a,b" forKey:@"answer"];
    [dic setObject:@"2" forKey:@"type"];
    [request.paramsDict setObject:@[dic, dic] forKey:@"userAnswer"];
    [WPNetManager addRequest:request];
}

#pragma mark - 行政办公
- (void)test301{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestWait];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test302{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestWaitdelete];
    [request.paramsDict setObject:@"1" forKey:@"id"];
    [WPNetManager addRequest:request];
}

- (void)test303{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestPbInfo];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test304{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestPb];
    [request.paramsDict setObject:@"2011-05" forKey:@"scheduling_info"];
    [WPNetManager addRequest:request];
}

- (void)test305{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestPbdelete];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"2011-05" forKey:@"pbDate"];
    [WPNetManager addRequest:request];
}

- (void)test306{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestTrainAll];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test307{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestTrianWaitdelete];
    [request.paramsDict setObject:@"1" forKey:@"id"];
    [WPNetManager addRequest:request];
}

- (void)test308{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestAddMeetingInfo];
    [request.paramsDict setObject:@"12" forKey:@"employeeno"];
    [request.paramsDict setObject:@"222" forKey:@"meeting_code"];
    [request.paramsDict setObject:@"测试" forKey:@"meeting_name"];
    [request.paramsDict setObject:@"体育部" forKey:@"host_department"];
    [request.paramsDict setObject:@"哈哈" forKey:@"contact"];
    [request.paramsDict setObject:@"110" forKey:@"contact_phone"];
    [request.paramsDict setObject:@"2015-02-06 11:12" forKey:@"meeting_starttime"];
    [request.paramsDict setObject:@"20" forKey:@"meeting_times"];
    [request.paramsDict setObject:@"2" forKey:@"meeting_spaces"];
    [request.paramsDict setObject:@"30" forKey:@"meeting_number_expected"];
    [request.paramsDict setObject:@"张三 李四 王五" forKey:@"participants"];
    [WPNetManager addRequest:request];
}

- (void)test309{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestGetMeetingInfo];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test310{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestDeleteMeetingInfo];
    [request.paramsDict setObject:@"12347" forKey:@"meetingId"];
    [WPNetManager addRequest:request];
}

- (void)test311{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestGetMeetingRoom];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test312{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestGetInfo];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test313{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestValidateInfo];
    [request.paramsDict setObject:@"12401" forKey:@"id"];
    [request.paramsDict setObject:@"01" forKey:@"infoStatus"];
    [WPNetManager addRequest:request];
}

- (void)test314{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_workDal requestDeleteInfo];
    [request.paramsDict setObject:@"12401" forKey:@"id"];
    [WPNetManager addRequest:request];
}

#pragma mark - 园区运营
- (void)test401{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestCard];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test402{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestRepairList];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [WPNetManager addRequest:request];
}

- (void)test403{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestSaveRepairApply];
    [request.paramsDict setObject:@"18988880001" forKey:@"reporterTel"];
    [request.paramsDict setObject:@"2015-02-09" forKey:@"reportDate"];
    [request.paramsDict setObject:@"报修" forKey:@"comment"];
    [request.paramsDict setObject:@"" forKey:@"voice"];
    [WPNetManager addRequest:request];
}

- (void)test404{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestStatus];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"1" forKey:@"faultStatus"];
    [WPNetManager addRequest:request];
}

- (void)test405{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestDevicefault];
    [request.paramsDict setObject:@"01" forKey:@"faultId"];
    [WPNetManager addRequest:request];
}

- (void)test406{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestUploadfault];
    [request.paramsDict setObject:@"1" forKey:@"pageNumber"];
    [request.paramsDict setObject:@"10" forKey:@"pageCount"];
    [request.paramsDict setObject:@"01" forKey:@"faultId"];
    [request.paramsDict setObject:@"" forKey:@"note"];
    [WPNetManager addRequest:request];
}

- (void)test407{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestEnergy];
    [request.paramsDict setObject:@"2011-05" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test408{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestElectM];
    [request.paramsDict setObject:@"2011-05" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test409{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestSystemelect];
    [request.paramsDict setObject:@"2015-02" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test410{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestWaterM];
    [request.paramsDict setObject:@"2015-02" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test411{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestWaterItem];
    [request.paramsDict setObject:@"2015-02" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test412{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestGetLoadEnergy];
    [request.paramsDict setObject:@"2015-02" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test413{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestHeatM];
    [request.paramsDict setObject:@"2015-02" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test414{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestHeatItem];
    [request.paramsDict setObject:@"2015-02" forKey:@"date"];
    [WPNetManager addRequest:request];
}

- (void)test415{
    WpLog(@"%@:", NSStringFromSelector(_cmd));
    WPUrlRequest * request = [_operationDal requestGetbuildscore];
    [request.paramsDict setObject:@"" forKey:@"floorNumber"];
    [request.paramsDict setObject:@"2015-02-10" forKey:@"date"];
    [WPNetManager addRequest:request];
}
@end
