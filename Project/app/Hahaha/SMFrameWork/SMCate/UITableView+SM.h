//
//  UITableView+SM.h
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMModel.h"

typedef NS_ENUM(NSInteger, SMCellState) {
    SMCellStateOff    = 0,
    SMCellStateOn
};

typedef NS_ENUM(NSInteger, SMCellStateType) {
    SMCellStateTypeA    = 0,
    SMCellStateTypeB
};

typedef NS_OPTIONS(NSInteger, SMMjOperationType) {
    SMMjOperationTypeDefault    = 0xFFFFFF,
    SMMjOperationTypeHeader     = 1 << 1,
    SMMjOperationTypeFooter     = 1 << 2
};

@interface SMCellStateModel : SMModel

@property (assign, nonatomic) BOOL state;
@property (assign, nonatomic) BOOL type;
@property (assign, nonatomic) NSInteger index;

@end

@interface SMExTabelViewResult : SMModel

@property (assign, nonatomic) BOOL fold;
@property (strong, nonatomic) NSIndexPath * operateIndexPath;
@property (strong, nonatomic) UITableViewCell * operateCellA;
@property (strong, nonatomic) UITableViewCell * operateCellB;

@end

typedef void(^OperationBlock)(int page);
typedef void(^MJOperationBlock)(void);
@interface SMMjOperation : NSObject

@property (assign, nonatomic) int page;
@property (copy, nonatomic) OperationBlock operationBlock;
@property (copy, nonatomic) MJOperationBlock mjHeaderOperationBlock;
@property (copy, nonatomic) MJOperationBlock mjFooterOperationBlock;

@end

@class SMUrlRequest;
@interface UITableView (SM)

@property (strong, nonatomic) SMMjOperation * mj_operation;

#pragma mark - 可展开关闭的tableViewCell
+ (NSMutableArray *)ex_indexDataSourceWithDataSource:(NSArray *)indexDataSource;

/**
 *  从复用队列中取得cell
 *
 *  @param indexPath       当前indexPath
 *  @param indexDataSource 索引数据源
 *  @param identifiers     两种类型的标识
 *
 *  @return 当前cell
 */
- (UITableViewCell *)ex_cellForRowAtIndexPath:(NSIndexPath *)indexPath indexDataSource:(NSMutableArray *)indexDataSource identifiers:(NSArray *)identifiers;

/**
 *  对数据源做展开折叠操作
 *
 *  @param indexPath         索引
 *  @param indexDataSource   数据源
 *  @param rotationAccessory 是否旋转挂件(只选择A类型cell)
 *  @param animate           是否动态旋转挂件
 *
 *  @return 返回结果
 */
- (SMExTabelViewResult *)ex_didSelectRowAtIndexPath:(NSIndexPath *)indexPath fillIndexDataSource:(NSMutableArray *)indexDataSource rotationAccessory:(BOOL)rotationAccessory animate:(BOOL)animate;

/**
 *  旋转挂件
 *
 *  @param accessory 挂件
 *  @param fold      状态
 *  @param animate   是否动画
 */
- (void)ex_rotationAccessory:(UIView *)accessory fold:(BOOL)fold animate:(BOOL)animate;

#pragma mark - MJRefresh刷新加载
/**
 *  初始化数据源并添加刷新加载的block
 *
 *  @param operaBlock   刷新(全开样式，并且加载立即刷新)
 */
- (void)mj_addMJRefreshOperationBlock:(OperationBlock)operationBlock;

/**
 *  初始化数据源并添加刷新加载的block
 *
 *  @param operaBlock       刷新
 *  @param operationType    添加样式(加footer还是header)
 *  @param refresh          立即刷新
 */
- (void)mj_addMJRefreshOperationBlock:(OperationBlock)operationBlock operationType:(SMMjOperationType)operationType refresh:(BOOL)refresh;

/**
 *  填充数据源
 *
 *  @param dataSource    原数据源
 *  @param curPage       请求的页数
 *  @param newDataSource 新数据源
 *
 *  @return 刷新加载后应该加载的页码
 */
- (int)mj_finishedFillDataSource:(NSMutableArray *)dataSource curPage:(int)curPage newDataSource:(NSArray *)newDataSource;

/**
 *  结束刷新加载
 */
- (void)mj_faildRefresh;

#pragma mark - action
/**
 *  给列表的FootView 加一个View 挡住没有数据的cell的分割线
 *
 *  @param tableView 要挡住的tableview
 */
- (void)setExtraCellLineHidden;

@end


