//
//  StyleResultViewControllerCell.m
//  GFTrademark
//
//  Created by ios－梁家安 on 2017/6/28.
//  Copyright © 2017年 gf. All rights reserved.
//

#import "StyleResultViewControllerCell.h"

@implementation StyleResultViewControllerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _equipmentNumber = [UILabel new];
        [self.contentView addSubview:_equipmentNumber];
        
        _equipmentTime = [UILabel new];
        [self.contentView addSubview:_equipmentTime];
        
        _equipment = [UILabel new];
        [self.contentView addSubview:_equipment];
        
        _equipmentDescribe = [UILabel new];
        [self.contentView addSubview:_equipmentDescribe];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat weidth1 = Device_Width * (66.0 / 540);
    CGFloat weidth2 = Device_Width * (134.0 / 540);
    CGFloat weidth3 = Device_Width * (122.0 / 540);
    
    [_equipmentNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(0);
        make.width.mas_equalTo(weidth1);
    }];
    
    
    [_equipmentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(_equipmentNumber.mas_right).with.offset(0);
        make.width.mas_equalTo(weidth2);
    }];
    
    [_equipment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(_equipmentTime.mas_right).with.offset(0);
        make.width.mas_equalTo(weidth3);
    }];
    
    [_equipmentDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(_equipment.mas_right).with.offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(0);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code      初始化代码
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state    为选定的状态配置视图
}


@end
