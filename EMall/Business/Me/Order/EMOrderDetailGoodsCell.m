//
//  EMCartSubmitCell.m
//  EMall
//
//  Created by Luigi on 16/7/24.
//  Copyright © 2016年 Luigi. All rights reserved.
//

#import "EMOrderDetailGoodsCell.h"
#import "NSAttributedString+Price.h"
#import "EMOrderModel.h"
@interface EMOrderDetailGoodsCell ()
@property (nonatomic,strong)UIImageView *goodsImageView;
@property (nonatomic,strong)UILabel *goodsNameLabel;
@property (nonatomic,strong)UILabel *descLabel,*priceLabel;//规格数量
@property (nonatomic,strong)UIButton *commentButton;
@end

@implementation EMOrderDetailGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType=UITableViewCellAccessoryNone;
        self.selectionStyle=UITableViewCellAccessoryNone;
        [self onInitContentView];
    }
    return self;
}
- (void)onInitContentView{
    self.contentView.backgroundColor=[UIColor whiteColor];
    WEAKSELF
    
    
    _goodsImageView=[[UIImageView alloc] init];
    [self.contentView addSubview:_goodsImageView];
    UIFont *font=[UIFont oc_systemFontOfSize:13];
    UIColor *color=[UIColor colorWithHexString:@"#272727"];
    _goodsNameLabel=[UILabel labelWithText:@"" font:font textColor:color textAlignment:NSTextAlignmentLeft];
    _goodsNameLabel.numberOfLines=2;
    [self.contentView addSubview:_goodsNameLabel];
    
    
    _descLabel=[UILabel labelWithText:@"" font:font textColor:[UIColor colorWithHexString:@"#949090"] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_descLabel];
    
    
    _priceLabel=[[UILabel alloc]  init];
    //    _priceLabel.textColor=RGB(227, 0, 0);
    _priceLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:self.commentButton];
 


    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(OCUISCALE(12));
        make.top.mas_equalTo(self.contentView.mas_top).offset(OCUISCALE(15));
        make.size.mas_equalTo(CGSizeMake(OCUISCALE(92), OCUISCALE(65)));
       // make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(OCUISCALE(-15)).priorityHigh();
    }];
    
    
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_top);
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).offset(OCUISCALE(5));
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(OCUISCALE(-12));
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsNameLabel);
        make.bottom.mas_equalTo(weakSelf.goodsImageView.mas_bottom);
        make.right.mas_equalTo(weakSelf.priceLabel.mas_left);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.goodsNameLabel.mas_right);
        make.top.mas_equalTo(weakSelf.descLabel);
        make.width.mas_lessThanOrEqualTo(OCUISCALE(100));
    }];
    UIView *lineView=[UIView new];
     lineView.backgroundColor=RGB(225, 225, 225);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(kEMOffX);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-kEMOffX);
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_bottom).offset(5);
        make.height.mas_equalTo(0.5);
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-kEMOffX);
        make.top.mas_equalTo(lineView.mas_bottom).offset(OCUISCALE(10));
        make.size.mas_equalTo(CGSizeMake(OCUISCALE(50), OCUISCALE(25)));
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(OCUISCALE(-15)).priorityHigh();
    }];
}
-(UIButton *)commentButton{
    if (nil==_commentButton) {
        UIFont *font=[UIFont oc_systemFontOfSize:13];
        UIColor *color=[UIColor colorWithHexString:@"#272727"];
        _commentButton=[UIButton buttonWithTitle:@"评论" titleColor:color font:font];
        _commentButton.layer.cornerRadius=5.0;
        _commentButton.layer.masksToBounds=YES;
        _commentButton.layer.borderColor=[color CGColor];
        _commentButton.layer.borderWidth=1.0;
        [_commentButton addTarget:self action:@selector(didCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _commentButton;
}
- (void)didCommentButtonPressed{
    [[self nextResponder] routerEventName:kEMOrderDetailGoodsCommentEvent userInfo:@{kEMOrderDetailGoodsCommentEvent:self.orderGoodsModel}];
}


- (void)setOrderGoodsModel:(EMOrderGoodsModel *)orderGoodsModel{
    _orderGoodsModel=orderGoodsModel;
     
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:_orderGoodsModel.goodsImageUrl] placeholderImage:EMDefaultImage];
    self.goodsNameLabel.text=_orderGoodsModel.goodsName;
    
    self.descLabel.text=[NSString stringWithFormat:@"%@  %ld件",stringNotNil(_orderGoodsModel.spec),_orderGoodsModel.buyCount];
    self.priceLabel.attributedText=[NSAttributedString  goodsPriceAttrbuteStringWithPrice:_orderGoodsModel.discountPrice];
}

@end
