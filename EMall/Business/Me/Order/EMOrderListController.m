//
//  EMOrderListController.m
//  EMall
//
//  Created by Luigi on 16/7/17.
//  Copyright © 2016年 Luigi. All rights reserved.
//

#import "EMOrderListController.h"
#import "EMOrderListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface EMOrderListController ()<EMOrderListCellDelegate>

@end

@implementation EMOrderListController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[EMOrderListCell class] forCellReuseIdentifier:NSStringFromClass([EMOrderListCell class])];
    
    for (NSInteger i=0; i<10; i++) {
        EMOrderModel *orderModel=[[EMOrderModel alloc]  init];
        orderModel.goodsName=@"仿真盆栽现代家居装饰家室美式装修";
        orderModel.goodsImageUrl=@"http://img4.cache.netease.com/photo/0008/2016-06-22/BQ54OKL42FKJ0008.550x.0.jpg";
        orderModel.goodsPrice=102;
        orderModel.buyCount=i+1;
        orderModel.spec=@"100x20";
        [self.dataSourceArray addObject:orderModel];
    }
    [self.tableView reloadData];
}

#pragma mark -tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EMOrderListCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EMOrderListCell class]) forIndexPath:indexPath];
    cell.orderModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  __block  EMOrderModel *orderModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    CGFloat height=[tableView fd_heightForCellWithIdentifier:NSStringFromClass([EMOrderListCell class]) configuration:^(id cell) {
        [(EMOrderListCell *)cell setOrderModel:orderModel];
    }];
    return height;
}
#pragma mark -page delegate
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear: (BOOL)isFirstTime{
    if (isFirstTime) {
        self.tableView.frame=self.view.bounds;
    }
    EMOrderState state=[EMOrderStateModel orderStateWithStateName:title];
    
}

#pragma mark -cell delegate
//重新购买
- (void)orderListCellShouldReBuyThisGoods{
    
}
//查看订单详情
- (void)orderListCellShouldCheckOrderDetail{

}
@end