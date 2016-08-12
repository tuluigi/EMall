//
//  EMGoodsModel.h
//  EMall
//
//  Created by Luigi on 16/7/3.
//  Copyright © 2016年 Luigi. All rights reserved.
//

#import "OCBaseModel.h"


/**
 *  商品规格model
 */
@interface EMSpecModel : OCBaseModel
@property(nonatomic,copy)NSString *pName;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger specID;//规格id
@property(nonatomic,assign)NSInteger infoID;//明细ID
@end

/**
 *  规格列表model
 */
@interface EMSpecListModel : OCBaseModel
@property(nonatomic,copy)NSString *pName;
@property(nonatomic,strong)NSArray <EMSpecModel *>*specsArray;//明细列表
@end

/**
 *  商品明细model
 */
@interface EMGoodsInfoModel : OCBaseModel
@property (nonatomic,assign)NSInteger goodsID;//商品ID
@property (nonatomic,assign)NSInteger infoID;//明细ID
@property (nonatomic,assign)CGFloat promotePrice;//促销价
@property (nonatomic,assign)NSInteger amount;//库存
@property (nonatomic,strong)NSArray *specListArray;//规格列表array
@end

/**
 *  商品基本信息model
 */
@interface EMGoodsModel : OCBaseModel
@property(nonatomic,assign)NSInteger goodsID;
@property(nonatomic,copy)NSString *goodsName;

@property(nonatomic,copy)NSString *goodsImageUrl;//商品主图
@property(nonatomic,strong,readonly)NSMutableArray <NSString *>*goodsImageArray;//商品其他图集<通过接口返回的5张图片来拼起来的>

@property(nonatomic,assign)NSInteger saleCount;//销售数量
@property(nonatomic,assign)CGFloat goodsPrice;
@property(nonatomic,assign)NSInteger commentCount;//评论数量

@property (nonatomic,copy)NSString *remark;//备注
@property (nonatomic,copy)NSString *goodsDetails;//详细信息

@property (nonatomic,copy)NSString *parameter;//

@property (nonatomic,copy)NSString *userName;//
@property (nonatomic,copy)NSString *avatar;//
@property (nonatomic,copy)NSString *commentContent;//用户的一条评论

@property (nonatomic,assign)NSInteger postage;
@property (nonatomic,assign)NSInteger state;


@property (nonatomic,strong)NSArray *specArray;//商品列表中可能用到的规格信息
@end



/**
 *  商品详细信息model
 */
@interface EMGoodsDetailModel : OCBaseModel
@property (nonatomic,strong)EMGoodsModel *goodsModel;//商品基本信息
@property (nonatomic,strong)NSArray *goodsInfoArray;//商品明细

@property (nonatomic,strong)NSMutableArray *goodsSpecListArray;//商品规格列表,通过单独接口获取，获取之后，给放到这个数组中

/**
 *  该商品的所有的明细分类
 */
@property (nonatomic,strong,readonly)NSMutableDictionary *specDic;
@end
