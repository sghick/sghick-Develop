//
//  UITableView+SM.m
//  Demo-SMFrameWork
//
//  Created by 丁治文 on 15/8/9.
//  Copyright (c) 2015年 buding. All rights reserved.
//

#import "UITableView+SM.h"
#import <objc/runtime.h>
#import "MJRefresh.h"
#import "SMUrlRequest.h"

@implementation SMCellStateModel

@end

@implementation SMExTabelViewResult

@end

@implementation SMMjOperation

static int staticPage = 1;

- (MJOperationBlock)mjHeaderOperationBlock{
    if (self.operationBlock) {
        __weak __typeof(OperationBlock) block=self.operationBlock;
        _mjHeaderOperationBlock = ^(void){
            staticPage = 1;
            __strong __typeof(block)strongblock=block;
            strongblock(staticPage);
        };
    }
    return _mjHeaderOperationBlock;
}

- (MJOperationBlock)mjFooterOperationBlock{
    if (self.operationBlock) {
        __block OperationBlock block = self.operationBlock;
        _mjHeaderOperationBlock = ^(void){
            staticPage++;
            block(staticPage);
        };
    }
    return _mjHeaderOperationBlock;
}

- (void)setPage:(int)page {
    staticPage = page;
}

- (int)page {
    return staticPage;
}

@end

@implementation UITableView (WP)
+ (NSMutableArray *)ex_indexDataSourceWithDataSource:(NSArray *)dataSource{
    NSMutableArray * rtn = [[NSMutableArray alloc] initWithCapacity:dataSource.count];
    // 创建索引
    for (int i = 0; i < dataSource.count; i++) {
        SMCellStateModel * model = [[SMCellStateModel alloc] init];
        model.type = SMCellStateTypeA;
        model.state = SMCellStateOff;
        model.index = i;
        [rtn addObject:model];
    }
    return rtn;
}

- (UITableViewCell *)ex_cellForRowAtIndexPath:(NSIndexPath *)indexPath indexDataSource:(NSMutableArray *)indexDataSource identifiers:(NSArray *)identifiers{
    if (identifiers.count != 2) {
        return nil;
    }
    NSString * identifier = identifiers[0];
    // 取得索引
    SMCellStateModel * iDataSource = [indexDataSource objectAtIndex:indexPath.row];
    // 当前cell类型B
    if (iDataSource.type == SMCellStateTypeB) {
        identifier = identifiers[1];
    }
    // 从复用队列中取出该类型的cell
    UITableViewCell * cell = [self dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

- (SMExTabelViewResult *)ex_didSelectRowAtIndexPath:(NSIndexPath *)indexPath fillIndexDataSource:(NSMutableArray *)dataSource rotationAccessory:(BOOL)rotationAccessory animate:(BOOL)animate{
    SMExTabelViewResult * rtn = [[SMExTabelViewResult alloc] init];
    // 取得选中索引
    SMCellStateModel * iDataSource = [dataSource objectAtIndex:indexPath.row];
    // 操作行索引下标,默认当前选中
    NSIndexPath * curIndexPath = indexPath;
    // 如果是类型A的cell
    if (iDataSource.type == SMCellStateTypeA) {
        // 操作的cellA
        rtn.operateCellA = [self cellForRowAtIndexPath:indexPath];
        // 操作索引为下一个
        curIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        // 操作的cellB
        rtn.operateCellB = [self cellForRowAtIndexPath:curIndexPath];
        // 如果是关闭状态,插入一个cell,做打开效果
        if (iDataSource.state == SMCellStateOff) {
            // 打开状态
            rtn.fold = YES;
            // 修改选中数据源为打开状态
            iDataSource.state = SMCellStateOn;
            // 插入B类cell的数据源
            SMCellStateModel * model = [[SMCellStateModel alloc] init];
            model.type = SMCellStateTypeB;
            model.index = iDataSource.index;
            [dataSource insertObject:model atIndex:curIndexPath.row];
            // 编辑表
            [self beginUpdates];
            [self insertRowsAtIndexPaths:@[curIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            [self endUpdates];
        }
        //如果是关闭状态,删除一个cell,做关闭效果
        else{
            // 关闭状态
            rtn.fold = NO;
            // 修改选中数据源为关闭状态
            iDataSource.state = SMCellStateOff;
            // 删除B类cell的数据源
            [dataSource removeObjectAtIndex:curIndexPath.row];
            // 编辑表
            [self beginUpdates];
            [self deleteRowsAtIndexPaths:@[curIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self endUpdates];
        }
    }
    // 如果是类型B的cell
    else{
        // 关闭状态
        rtn.fold = NO;
        // 操作的cellB
        rtn.operateCellB = [self cellForRowAtIndexPath:indexPath];
        // 操作索引为上一个
        curIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        // 操作的cellA
        rtn.operateCellA = [self cellForRowAtIndexPath:curIndexPath];
        // 修改操作数据源为关闭状态
        iDataSource = [dataSource objectAtIndex:curIndexPath.row];
        iDataSource.state = SMCellStateOff;
        // 删除选中cell,做关闭效果
        [dataSource removeObjectAtIndex:indexPath.row];
        // 编辑表
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self endUpdates];
    }
    rtn.operateIndexPath = curIndexPath;
    // 旋转挂件
    if (rotationAccessory && rtn.operateCellA.accessoryView) {
        [self ex_rotationAccessory:rtn.operateCellA.accessoryView fold:rtn.fold animate:animate];
    }
    return rtn;
}

- (void)ex_rotationAccessory:(UIView *)accessory fold:(BOOL)fold animate:(BOOL)animate{
    CGFloat rotation = M_PI_2*fold;
    if (animate) {
        [UIView animateWithDuration:0.2f animations:^{
            accessory.transform = CGAffineTransformMakeRotation(rotation);
        }];
    }
    else{
        accessory.transform = CGAffineTransformMakeRotation(rotation);
    }
}

- (void)setExtraCellLineHidden{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}



//为Mj_operation添加setter 和getter 并且可以用KVO。检测该值的变化。
static char SMMjOperationKey;
- (void)setMj_operation:(SMMjOperation *)mj_operation{
    if (self.mj_operation != mj_operation) {
        [self willChangeValueForKey:@"mjOperation"];
        objc_setAssociatedObject(self, &SMMjOperationKey,
                                 mj_operation,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"mjOperation"];
    }
}

- (SMMjOperation *)mj_operation{
    return objc_getAssociatedObject(self, &SMMjOperationKey);
}

- (SMMjOperation *)addOperation{
    if (!self.mj_operation) {
        SMMjOperation *operation = [[SMMjOperation alloc] init];
        self.mj_operation = operation;
    }
    return self.mj_operation;
}

- (void)mj_addMJRefreshOperationBlock:(OperationBlock)operationBlock{
    [self mj_addMJRefreshOperationBlock:operationBlock operationType:SMMjOperationTypeDefault refresh:YES];
}

- (void)mj_addMJRefreshOperationBlock:(OperationBlock)operationBlock operationType:(SMMjOperationType)operationType refresh:(BOOL)refresh {
    SMMjOperation * operation = [self addOperation];
    operation.page = 1;
    operation.operationBlock = operationBlock;
    if (operationType&SMMjOperationTypeHeader) {
        [self addLegendHeaderWithRefreshingBlock:operation.mjHeaderOperationBlock];
    }
    if (operationType&SMMjOperationTypeFooter) {
        [self addLegendFooterWithRefreshingBlock:operation.mjFooterOperationBlock];
    }
    if (refresh) {
        if (operation.mjHeaderOperationBlock) {
            operation.mjHeaderOperationBlock();
        }
    }
}

- (int)mj_finishedFillDataSource:(NSMutableArray *)dataSource curPage:(int)curPage newDataSource:(NSArray *)newDataSource {
    if (curPage == 1) {
        [dataSource removeAllObjects];
        [dataSource addObjectsFromArray:newDataSource];
        [self.footer endRefreshing];
        [self.header endRefreshing];
    }
    else{
        [dataSource addObjectsFromArray:newDataSource];
        [self.footer endRefreshing];
        [self.header endRefreshing];
    }
    return curPage;
}

- (void)mj_faildRefresh{
    [self.header endRefreshing];
    [self.footer endRefreshing];
}

@end
