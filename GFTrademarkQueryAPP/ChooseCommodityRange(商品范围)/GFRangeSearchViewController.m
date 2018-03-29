//
//  GFRangeSearchViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/22.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFRangeSearchViewController.h"
#import "GFButton.h"
#import "GFRangeDao.h"
#import "GFRangeVo.h"

@interface GFRangeSearchViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UIButton *firstKind;
@property (nonatomic, strong) UIButton *secondKind;
@property (nonatomic, strong) UITextField *nameInput;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic ,assign) NSInteger mark;

@property BOOL isFirstKind;
@property NSMutableArray *datas;

@end

@implementation GFRangeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initSearchView];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  初始化数据
 */
- (void)initData {
    _isFirstKind = YES;
    _datas = [[NSMutableArray alloc] init];
    _mark = 0;
}

/**
 *  初始化搜索栏
 */
- (void)initSearchView {
    _searchView = [[UIView alloc] init];
    [self.view addSubview:_searchView];
    [_searchView setBackgroundColor:[UIColor whiteColor]];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(85);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    // 提示语“通过商品名称选：”
    UILabel *chooseKind = [[UILabel alloc] init];
    [_searchView addSubview:chooseKind];
    [chooseKind setFont:[UIFont systemFontOfSize:14]];
    [chooseKind setText:@"通过商品名称选："];
    [chooseKind setTextAlignment:NSTextAlignmentRight];
    [chooseKind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(115);
        make.height.mas_equalTo(35);
        make.top.equalTo(_searchView).with.offset(5);
        make.left.equalTo(_searchView).with.offset(5);
    }];
    
    
    // checkBox，选择类别
    _firstKind = [[UIButton alloc] init];
    [_searchView addSubview:_firstKind];
    [_firstKind.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_firstKind addTarget:self action:@selector(chooseKind:) forControlEvents:UIControlEventTouchUpInside];
    [_firstKind setBackgroundColor:[UIColor whiteColor]];
    [_firstKind setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_firstKind setTitle:@"类别" forState:UIControlStateNormal];
    [_firstKind setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_firstKind setImage:[UIImage imageNamed:@"ic_check_yes"] forState:UIControlStateNormal];
    [_firstKind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(chooseKind);
        make.top.equalTo(chooseKind);
        make.left.equalTo(chooseKind.mas_right);
    }];
    
    // checkBox，选择类似群
    _secondKind = [[UIButton alloc] init];
    [_searchView addSubview:_secondKind];
    [_secondKind.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_secondKind addTarget:self action:@selector(chooseKind:) forControlEvents:UIControlEventTouchUpInside];
    [_secondKind setBackgroundColor:[UIColor whiteColor]];
    [_secondKind setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_secondKind setTitle:@"类似群" forState:UIControlStateNormal];
    [_secondKind setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_secondKind setImage:[UIImage imageNamed:@"ic_check_no"] forState:UIControlStateNormal];
    [_secondKind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_firstKind);
        make.height.equalTo(_firstKind);
        make.top.equalTo(_firstKind);
        make.left.equalTo(_firstKind.mas_right).with.offset(-10);
    }];
    
    
    // 确认按钮
    UIButton *confirmButton = [[UIButton alloc] init];
    [_searchView addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(actionConfirm) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor colorWithRed:106.0/255 green:175.0/255 blue:240.0/255 alpha:1] forState:UIControlStateHighlighted];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_secondKind);
        make.height.equalTo(_secondKind);
        make.top.equalTo(_secondKind);
        make.left.equalTo(_secondKind.mas_right);
        make.right.equalTo(_searchView).with.offset(-5);
    }];
    
    // 提示语“商品名称：”
    UILabel *commodityName = [[UILabel alloc] init];
//    commodityName.backgroundColor = [UIColor yellowColor];
    [_searchView addSubview:commodityName];
    [commodityName setFont:[UIFont systemFontOfSize:14]];
    [commodityName setText:@"商品名称："];
    [commodityName setTextAlignment:NSTextAlignmentRight];
    [commodityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(35);
        make.top.equalTo(chooseKind.mas_bottom).with.offset(5);
        make.left.equalTo(_searchView).with.offset(5);
    }];
    
    // 全选按钮
    UIButton *allDataButton = [[UIButton alloc] init];
    [_searchView addSubview:allDataButton];
    [allDataButton addTarget:self action:@selector(actionAllSearch) forControlEvents:UIControlEventTouchUpInside];
    [allDataButton setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
    [allDataButton setTitle:@"全选" forState:UIControlStateNormal];
    [allDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [allDataButton setTitleColor:[UIColor colorWithRed:106.0/255 green:175.0/255 blue:240.0/255 alpha:1] forState:UIControlStateHighlighted];
    [allDataButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [allDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.top.equalTo(chooseKind.mas_bottom).with.offset(5);
        make.width.mas_equalTo(50);
        make.right.equalTo(_searchView).with.offset(-5);
    }];
    
    
    // 查找按钮
    UIButton *searchButton = [[UIButton alloc] init];
    [_searchView addSubview:searchButton];
    [searchButton addTarget:self action:@selector(actionSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
    [searchButton setTitle:@"查找" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:106.0/255 green:175.0/255 blue:240.0/255 alpha:1] forState:UIControlStateHighlighted];
    [searchButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.top.equalTo(chooseKind.mas_bottom).with.offset(5);
        make.width.mas_equalTo(50);
        make.right.mas_equalTo(allDataButton.mas_left).with.offset(-5);
    }];
    

    // 商品名称输入框
    _nameInput = [[UITextField alloc] init];
    [_searchView addSubview:_nameInput];
    [_nameInput setDelegate:self];
    [_nameInput setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_nameInput setBackgroundColor:[UIColor whiteColor]];
    [_nameInput setFont:[UIFont systemFontOfSize:14]];
    [_nameInput setTextAlignment:NSTextAlignmentCenter];
    [_nameInput.layer setMasksToBounds:YES];
    [_nameInput.layer setBorderWidth:1.0f];
    [_nameInput.layer setCornerRadius:4.0f];
    [_nameInput.layer setBorderColor:[UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor];
    //[_nameInput.layer setBorderColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1].CGColor];
    [_nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.top.equalTo(chooseKind.mas_bottom).with.offset(5);
        make.left.mas_equalTo(commodityName.mas_right).with.offset(5);
        make.right.mas_equalTo(searchButton.mas_left).with.offset(-5);
    }];
}

/**
 *  初始化列表
 */
- (void)initTableView {
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SearchCell"];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchView.mas_bottom).with.offset(1);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

/**
 *  “类别”与“类似群”checkbox的点击时间
 *  @param button 点击checkbox
 */
- (void)chooseKind:(UIButton *)button {
    if (button == _firstKind) {
        [_firstKind setImage:[UIImage imageNamed:@"ic_check_yes"] forState:UIControlStateNormal];
        [_secondKind setImage:[UIImage imageNamed:@"ic_check_no"] forState:UIControlStateNormal];
        _isFirstKind = YES;
    } else {
        [_firstKind setImage:[UIImage imageNamed:@"ic_check_no"] forState:UIControlStateNormal];
        [_secondKind setImage:[UIImage imageNamed:@"ic_check_yes"] forState:UIControlStateNormal];
        _isFirstKind = NO;
    }
    
    [_tableView reloadData];
}

// 列表代理方法：返回item高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

// 列表代理方法：返回Section数目
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 列表代理方法：返回item数目
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_datas count];
}

// 列表代理方法：配置Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // cell重用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    GFRangeVo *data = [_datas objectAtIndex:indexPath.row];
    
    // 选中状态
    NSString *imageName;
    if (data.isCheck) {
        imageName = @"ic_check_yes";
    } else {
        imageName = @"ic_check_no";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).with.offset(10);
    }];
    
    // 类似群信息
    UILabel *secondLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:secondLabel];
    [secondLabel setFont:[UIFont systemFontOfSize:14]];
    [secondLabel setTextAlignment:NSTextAlignmentRight];
    NSString *name = @"";
    if (_isFirstKind == NO) {
        
        name = [NSString stringWithFormat:@"%@%@%@", @"第", data.secondRangeID, @"类"];
    } else {
        
        name = [NSString stringWithFormat:@"%@%@%@", @"第", data.firstRangeID, @"类"];
    }
    [secondLabel setText:name];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.width.mas_equalTo(160);
        make.right.mas_equalTo(cell.contentView.mas_right).with.offset(-15);
    }];
    
    // 类别信息
//    UILabel *firstLabel = [[UILabel alloc] init];
//    [cell.contentView addSubview:firstLabel];
//    [firstLabel setFont:[UIFont systemFontOfSize:14]];
//    [firstLabel setText:[NSString stringWithFormat:@"%@%@%@", @"第", data.firstRangeID, @"类"]];
//    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(cell.contentView);
//        make.width.mas_equalTo(60);
//        make.right.equalTo(secondLabel.mas_left);
//    }];
    
    // 商品名称
    UILabel *nameLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:nameLabel];
    [nameLabel setText:data.thirdRangeName];
    [nameLabel setFont:[UIFont systemFontOfSize:14]];
    [nameLabel setNumberOfLines:2];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(imageView.mas_right).with.offset(10);
        make.right.equalTo(secondLabel.mas_left).with.offset(-10);
    }];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GFRangeVo *data = [_datas objectAtIndex:indexPath.row];
    data.isCheck = !data.isCheck;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:NO];
    _mark = 0;
}

/**
 *  执行搜索
 */
- (void)actionSearch {
    [self hideInput];
    [_datas removeAllObjects];
    NSString *searchString = [_nameInput text];
    if (![searchString isEqualToString:@""]) {
        _datas = [GFRangeDao searchDataByName:searchString];
    }
    _mark = 0;
    [_tableView reloadData];
}

/**
 *  全选
 */
- (void)actionAllSearch {
    
    if (_datas.count == 0) {

        return;
    }
    
    if (_mark == 0) {
        
        for (GFRangeVo *data in _datas) {
            
            data.isCheck = YES;
        }
        _mark = 1;
    } else {
        
        for (GFRangeVo *data in _datas) {
            
            data.isCheck = NO;
        }
        _mark = 0;
    }

    [_tableView reloadData];
}


/**
 *  点击确认，返回
 */
- (void)actionConfirm {
    
    NSMutableArray *chooseDatas = [[NSMutableArray alloc] init];
    for (GFRangeVo *vo in _datas) {
        if (vo.isCheck) {
            
            if (_isFirstKind ) {
                [chooseDatas addObject:vo.firstRangeID];
            } else {
                [chooseDatas addObject:vo.secondRangeID];
            }
        }
    }
    
    
    NSMutableArray *dataArray = [NSMutableArray new];
    for (NSInteger i = 0; i <chooseDatas.count ; i++) {
        
        NSString *string1 = chooseDatas[i];
        
        if (dataArray.count == 0) {
            
            [dataArray addObject:string1];
        } else {
            
            for (NSInteger i = 0; i <dataArray.count ; i++) {
                
                NSString *string2 = dataArray[i];
                
                if ([string1 isEqualToString:string2]) {
                    
                    break;
                } else {
                    
                    if (i == dataArray.count-1) {
                        
                        [dataArray addObject:string1];
                    }
                }
                
            }
            
        }
    }

    
    if (_isFirstKind) {
        [self.dataResultDelegate chooseRangeResultType:RangeTypeFirst Data:dataArray];
    } else {
        [self.dataResultDelegate chooseRangeResultType:RangeTypeSecond Data:dataArray];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideInput];
    return YES;
}

// 隐藏键盘
- (void)hideInput {
    [_nameInput endEditing:YES];
}

@end
