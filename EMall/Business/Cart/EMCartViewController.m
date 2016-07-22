//
//  EMCartViewController.m
//  EMall
//
//  Created by Luigi on 16/6/22.
//  Copyright © 2016年 Luigi. All rights reserved.
//

#import "EMCartViewController.h"
#import "EMCartListCell.h"
#import "EMShopCartModel.h"
#import "EMCartBottomView.h"
@interface EMCartViewController ()<EMCartListCellDelegate,EMCartBottomViewDelegate>
@property (nonatomic,strong)EMCartBottomView *bottomView;
@end

@implementation EMCartViewController
- (UITableView *)tableView{
    if (nil==_tableView) {
        _tableView=[[TPKeyboardAvoidingTableView alloc]  initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.tableFooterView=[UIView new];
    }
    return _tableView;
}
- (EMCartBottomView *)bottomView{
    if (nil==_bottomView) {
        _bottomView=[[EMCartBottomView alloc] init];
        _bottomView.delegate=self;
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onInitData];
}
- (void)onInitData{
    self.navigationItem.title=@"购物车";
    [self.tableView registerClass:[EMCartListCell class] forCellReuseIdentifier:NSStringFromClass([EMCartListCell class])];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(didEditButtonPressed)];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.bottomView];
   CGRect tabarBounds= self.tabBarController.tabBar.bounds;
    WEAKSELF
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-OCUISCALE(tabarBounds.size.height));
        make.height.mas_equalTo(OCUISCALE(50));
    }];
   UIEdgeInsets inset= self.tableView.contentInset;
    inset.bottom+=OCUISCALE(50);
    self.tableView.contentInset=inset;

    for (NSInteger i=0; i<20; i++) {
        EMShopCartModel *model=[[EMShopCartModel alloc]  init];
        model.goodsImageUrl=@"http://img4.cache.netease.com/photo/0008/2016-06-22/BQ54OKL42FKJ0008.550x.0.jpg";
        model.goodsName=@"仿真盆栽现代家居装饰家室美式装修";
        model.buyCount=1;
        model.goodsPrice=53;
        model.spec =@"100cm*30cm";
        [self.dataSourceArray addObject:model];
    }
    [self.tableView reloadData];
    [self calcuteMyShopCart];
}
- (void)didEditButtonPressed{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}
//计算当前购物车的购买人数和总价
- (void )calcuteMyShopCart{
    CGFloat totalPrice=0;
    NSInteger count=0;
    for (EMShopCartModel *model in self.dataSourceArray) {
        if (!model.unSelected) {
            count++;
            totalPrice+=model.goodsPrice*model.buyCount;
        }
    }
    [self.bottomView updateCartBottomWithSelectItemCount:count totalItems:self.dataSourceArray.count totalPrice:totalPrice];
}
- (void)updateAllShopCartModelSelectState:(BOOL)select{
    for (EMShopCartModel *model in self.dataSourceArray) {
        model.unSelected=!select;
    }
    [self.tableView reloadData];
}
#pragma mark -tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EMCartListCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EMCartListCell class]) forIndexPath:indexPath];
    cell.delegate=self;
    cell.shopCartModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  __block  EMShopCartModel *cartModel=[self.dataSourceArray objectAtIndex:indexPath.row];
    CGFloat height=[tableView fd_heightForCellWithIdentifier:NSStringFromClass([EMCartListCell class]) configuration:^(id cell) {
        [(EMCartListCell *)cell setShopCartModel:cartModel];
    }];
    return height;
}
#pragma mark -cell delegate
//选中状态
- (void)cartListCellDidSelectStateChanged:(EMShopCartModel *)shopCartModel{
    [self calcuteMyShopCart];
}
//购买数量改变
- (void)cartListCellDidBuyCountChanged:(EMShopCartModel *)shopCartModel{
    [self calcuteMyShopCart];
}

#pragma mark -bottom view delegate
//选中
- (void)cartBottomViewDidSelectAllButtonSelected:(BOOL)selected{
    [self updateAllShopCartModelSelectState:selected];
    [self calcuteMyShopCart];
}
//购物车结算
- (void)cartBottomViewSettlementShopCart{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
