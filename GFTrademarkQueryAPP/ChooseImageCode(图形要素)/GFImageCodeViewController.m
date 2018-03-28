//
//  GFImageCodeViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/13.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFImageCodeViewController.h"
#import "GFImageCodeDao.h"
#import "RATreeView.h"
//#import "RATreeView_ClassExtension.h"
#import "GFButton.h"

@interface GFImageCodeViewController () <UITextFieldDelegate, RATreeViewDelegate, RATreeViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) RATreeView *mTreeView;
@property (nonatomic, strong) GFImageCodeVo *mDataVos;

@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UITextField *mSearchText;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *mSearchDatas;
@property (nonatomic, strong) NSMutableArray *mSecondDatas;

@end

@implementation GFImageCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"图形要素"];
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1]];
    
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  初始化数据
 */
- (void)initData {
    _mSecondDatas = [NSMutableArray new];
    for (NSInteger i = 0; i<1; i++) {

            [_mSecondDatas addObject:@"NO"];

        }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在载入数据";
    
    NSLog(@"执行数据库操作前");
    _mDataVos = [GFImageCodeDao getAllImageCodeVo];
    _mDataVos.isRoot = YES;
    _mDataVos.imageCode = @"全选";
    _mDataVos.imageDesc = @"";
    NSLog(@"执行数据库操作后");
    
    [hud hide:YES];
    [self initView];
}

/**
 *  初始化界面
 */
- (void)initView {
    
    // 搜索栏背景
    UIView *searchView = [[UIView alloc] init];
    [self.view addSubview:searchView];
    [searchView setBackgroundColor:[UIColor whiteColor]];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
//    // 删除按钮
//    UIButton *deleteBtn = [[UIButton alloc] init];
//    [searchView addSubview:deleteBtn];
//    [deleteBtn setTitle:NSNewLocalizedString(@"image_code_delete", nil) forState:UIControlStateNormal];
//    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"bg_blue"] forState:UIControlStateNormal];
//    [deleteBtn addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
//    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(35);
//        make.right.equalTo(searchView).with.offset(-10);
//        make.centerY.equalTo(searchView);
//    }];
    
    // 查找按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchView addSubview:searchBtn];
    [searchBtn setTitle:@"查找" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"bg_blue"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(35);
//        make.right.equalTo(deleteBtn.mas_left).with.offset(-5);
//        make.centerY.equalTo(searchView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
        make.right.equalTo(searchView).with.offset(-10);
        make.centerY.equalTo(searchView);
    }];
    
    // 输入框
    _mSearchText = [[UITextField alloc] init];
    [searchView addSubview:_mSearchText];
    [_mSearchText setFont:[UIFont systemFontOfSize:14]];
    [_mSearchText setDelegate:self];
    [_mSearchText.layer setBorderWidth:1];
    [_mSearchText.layer setBorderColor:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor];
    [_mSearchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.left.equalTo(searchView).with.offset(10);
        make.right.equalTo(searchBtn.mas_left).with.offset(-5);
        make.centerY.equalTo(searchBtn);
    }];
    
    // 底部提交按钮
    _confirmBtn = [[UIButton alloc] init];
    [self.view addSubview:_confirmBtn];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"bg_blue"] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn.layer setMasksToBounds:YES];
    [_confirmBtn.layer setCornerRadius:3];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-5);
    }];
    
    // 数据列表
    _mTreeView = [[RATreeView alloc] init];
    [self.view addSubview:_mTreeView];
    [_mTreeView setDelegate:self];
    [_mTreeView setDataSource:self];
    [_mTreeView reloadData];
    [_mTreeView setBackgroundColor:[UIColor whiteColor]];
    [_mTreeView setSeparatorStyle:RATreeViewCellSeparatorStyleNone];
    [_mTreeView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ImageCodeCell"];
    [_mTreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(searchView.mas_bottom).with.offset(5);
        make.bottom.equalTo(_confirmBtn.mas_top).with.offset(-5);
    }];
    
    // 搜索列表
    _mTableView = [[UITableView alloc] init];
    [self.view addSubview:_mTableView];
    [_mTableView setDelegate:self];
    [_mTableView setDataSource:self];
    [_mTableView setBackgroundColor:[UIColor whiteColor]];
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ImageCodeSearchCell"];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(searchView.mas_bottom).with.offset(5);
        make.bottom.equalTo(_confirmBtn.mas_top).with.offset(-5);
    }];
    [_mTableView setHidden:YES];
}

#pragma mark =====树形列表代理方法=====

// 树形列表代理，返回子节点数目
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
//        return [_mDataVos.childrenVos count] + 1;
        return [_mDataVos.childrenVos count];
    } else {
        GFImageCodeVo *itemData = item;
        if (!itemData.childrenVos || itemData.isRoot) {
            return 0;
        } else {
            return [itemData.childrenVos count];
        }
    }
}

// 树形列表代理，返回对应节点的数据
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item{
    if (item == nil) {
//        if (index == 0) {
//            return _mDataVos;
//        }
//        return [_mDataVos.childrenVos objectAtIndex:index - 1];
        return [_mDataVos.childrenVos objectAtIndex:index ];
    } else {
        GFImageCodeVo *itemData = item;
        return [itemData.childrenVos objectAtIndex:index];
    }
}

// 树形列表代理，返回item的高度
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item {
    return 50;
}

// 树形列表代理，返回是否允许编辑
- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item {
    return NO;
}

// 树形列表代理，返回每个Cell的样式
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item {
    
    // 数据源
    GFImageCodeVo *itemData = item;
    
    // cell重用
    UITableViewCell *cell =  [treeView dequeueReusableCellWithIdentifier:@"ImageCodeCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"ImageCodeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    // 背景设定，第一级，第二级背景为白色，第三级背景为淡蓝色
    UIView *background = [[UIView alloc] init];
    [cell.contentView addSubview:background];
    if (itemData.parentImageCodeVo && itemData.parentImageCodeVo.parentImageCodeVo) {
        [background setBackgroundColor:[UIColor colorWithRed:231.0/255 green:243.0/255 blue:255.0/255 alpha:1]];
    } else if (itemData.parentImageCodeVo) {
        [background setBackgroundColor:[UIColor colorWithRed:243.0/255 green:249.0/255 blue:255.0/255 alpha:1]];
    } else {
        [background setBackgroundColor:[UIColor whiteColor]];
    }
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).with.offset(0.5);
        make.bottom.equalTo(cell.contentView).with.offset(-0.5);
        make.left.equalTo(cell.contentView).with.offset(5);
        make.right.equalTo(cell.contentView).with.offset(-5);
    }];
    
    // 第一级，第二级底部显示分割线
    if (!itemData.parentImageCodeVo || !itemData.parentImageCodeVo.parentImageCodeVo) {
        UIView *line = [[UIView alloc] init];
        [cell.contentView addSubview:line];
        [line setBackgroundColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.equalTo(cell.contentView).with.offset(5);
            make.right.equalTo(cell.contentView).with.offset(-5);
            make.bottom.equalTo(cell.contentView);
        }];
    }
    
    // 选择框，计算偏移量
    CGFloat leftOffset;
    if (!itemData.parentImageCodeVo) {
        leftOffset = 10;
    } else if (!itemData.parentImageCodeVo.parentImageCodeVo) {
        leftOffset = 20;
    } else {
        leftOffset = 30;
    }
    NSString *imageName;
    if (itemData.isCheck) {
        imageName = @"ic_check_yes";
    } else {
        imageName = @"ic_check_no";
    }
   
    GFButton *checkBtn = [[GFButton alloc] init];
    [cell.contentView addSubview:checkBtn];
    [checkBtn setIsNormal:YES];
    [checkBtn setMObject:itemData];
    [checkBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(clickCheckButton:) forControlEvents:UIControlEventTouchUpInside];
//    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(25);
//        make.height.mas_equalTo(25);
//        make.centerY.equalTo(cell.contentView);
//        make.left.equalTo(cell.contentView).with.offset(leftOffset);
//    }];
    

    // 标号Label
    CGFloat widthSize;
    if (!itemData.parentImageCodeVo) {
        widthSize = 20;
    } else if (!itemData.parentImageCodeVo.parentImageCodeVo) {
        widthSize = 35;
    } else {
        widthSize = 50;
    }
    CGFloat rightOffset;
    if (itemData.childrenVos) {
        rightOffset = -35;
    } else {
        rightOffset = -10;
    }
    UILabel *idLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:idLabel];
    [idLabel setNumberOfLines:2];
    [idLabel setFont:[UIFont systemFontOfSize:14]];
    [idLabel setText:[NSString stringWithFormat:@"%@  %@", itemData.imageCode, itemData.imageDesc]];
    if (itemData.childrenVos.count != 0) {

        [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).with.offset(widthSize);
            make.right.equalTo(cell.contentView).with.offset(rightOffset);
            make.centerY.equalTo(cell.contentView);
        }];
        
    } else {
        
        [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(25);
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).with.offset(leftOffset);
        }];
        
        [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(checkBtn.mas_right).with.offset(10);
            make.right.equalTo(cell.contentView).with.offset(rightOffset);
            make.centerY.equalTo(cell.contentView);
        }];
    }
    
    
    // 第一级，第二级显示选择子节点打开状态
    if (itemData.childrenVos && itemData.childrenVos.count != 0 && !itemData.isRoot) {
        NSString *imageName;
        if (!itemData.isOpen) {
            imageName = @"ic_show_open";
        } else {
            imageName = @"ic_show_close";
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(15);
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).with.offset(-10);
        }];
    }
    
    return cell;
}

// 树形列表代理，点击事件
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    GFImageCodeVo *itemData = item;
    if (!itemData.childrenVos || itemData.childrenVos.count == 0) {
        itemData.isCheck = !itemData.isCheck;
        if (itemData.isCheck) {
            // 其子节点均需要选择
            for (GFImageCodeVo *firstVo in itemData.childrenVos) {
                firstVo.isCheck = YES;
                for (GFImageCodeVo *secondVo in firstVo.childrenVos) {
                    secondVo.isCheck = YES;
                    for (GFImageCodeVo *thirdVo in secondVo.childrenVos) {
                        thirdVo.isCheck = YES;
                    }
                }
            }
        } else {
            // 其父节点均需要取消选择
            _mDataVos.isCheck = NO;
            if (itemData.parentImageCodeVo) {
                itemData.parentImageCodeVo.isCheck = NO;
                if (itemData.parentImageCodeVo.parentImageCodeVo) {
                    itemData.parentImageCodeVo.parentImageCodeVo.isCheck = NO;
                }
            }
        }
        CGPoint offsetSize = _mTreeView.tableView.contentOffset;
        [_mTreeView reloadRows];
        [_mTreeView.tableView setContentOffset:offsetSize animated:YES];
    } else {
        itemData.isOpen = !itemData.isOpen;
        CGPoint offsetSize = _mTreeView.tableView.contentOffset;
        [_mTreeView reloadRowsForItems:@[item] withRowAnimation:RATreeViewRowAnimationNone];
        [_mTreeView.tableView setContentOffset:offsetSize animated:YES];
    }
}

// 点击checkBox
- (void)clickCheckButton:(GFButton *)fgBtn {
    GFImageCodeVo *itemData = fgBtn.mObject;
    itemData.isCheck = !itemData.isCheck;
    
    if (itemData.isCheck) {
        // 其子节点均需要选择
        for (GFImageCodeVo *firstVo in itemData.childrenVos) {
            firstVo.isCheck = YES;
            for (GFImageCodeVo *secondVo in firstVo.childrenVos) {
                secondVo.isCheck = YES;
                for (GFImageCodeVo *thirdVo in secondVo.childrenVos) {
                    thirdVo.isCheck = YES;
                }
            }
        }
    } else {
        // 其父节点均需要取消选择
        _mDataVos.isCheck = NO;
        if (itemData.parentImageCodeVo) {
            itemData.parentImageCodeVo.isCheck = NO;
            if (itemData.parentImageCodeVo.parentImageCodeVo) {
                itemData.parentImageCodeVo.parentImageCodeVo.isCheck = NO;
            }
        }
        
        // 其子节点均需要取消选择
        for (GFImageCodeVo *firstVo in itemData.childrenVos) {
            firstVo.isCheck = NO;
            for (GFImageCodeVo *secondVo in firstVo.childrenVos) {
                secondVo.isCheck = NO;
                for (GFImageCodeVo *thirdVo in secondVo.childrenVos) {
                    thirdVo.isCheck = NO;
                }
            }
        }
    }
    
    CGPoint offsetSize = _mTreeView.tableView.contentOffset;
    [_mTreeView reloadRows];
    [_mTreeView.tableView setContentOffset:offsetSize animated:YES];
}

// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideInput];
    return YES;
}

#pragma mark =====搜索列表代理方法=====

// 列表代理：返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _mSearchDatas.count + 1;
}

// 列表代理：返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

// 列表代理：返回Cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCodeSearchCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    NSString *imageName;
    if ([_mSecondDatas[indexPath.row] isEqualToString:@"YES"]) {
        imageName = @"ic_check_yes";
    } else {
        imageName = @"ic_check_no";
    }
    GFButton *checkBtn = [[GFButton alloc] init];
    [cell.contentView addSubview:checkBtn];
    [checkBtn setTag:indexPath.row];
    [checkBtn setIsNormal:YES];
    [checkBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(clickCheckSecondButton:) forControlEvents:UIControlEventTouchUpInside];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).with.offset(8);
    }];

    //没有数据显示的查询结果
    if (indexPath.row == 0) {
        
        checkBtn.hidden = YES;
        
    }
    
    UILabel *imageCode = [[UILabel alloc] init];
    [cell.contentView addSubview:imageCode];
    [imageCode setText:@"图形要素"];
    [imageCode setFont:[UIFont systemFontOfSize:14]];
    [imageCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.left.equalTo(checkBtn.mas_right).with.offset(8);
        make.centerY.equalTo(cell.contentView);
    }];
    
    UIView *line0 = [[UIView alloc] init];
    [cell.contentView addSubview:line0];
    [line0 setBackgroundColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.5);
        make.left.equalTo(imageCode.mas_right).with.offset(10);
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
    }];
    
    UILabel *imageDesc = [[UILabel alloc] init];
    [cell.contentView addSubview:imageDesc];
    [imageDesc setText:@"图形描述"];
    [imageDesc setFont:[UIFont systemFontOfSize:14]];
    [imageDesc setNumberOfLines:2];
    [imageDesc setTextAlignment:NSTextAlignmentCenter];
    [imageDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line0.mas_right).with.offset(10);
        make.right.equalTo(cell.contentView).with.offset(-10);
        make.centerY.equalTo(cell.contentView);
    }];
    
    UIView *line = [[UIView alloc] init];
    [cell.contentView addSubview:line];
    [line setBackgroundColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(cell.contentView).with.offset(5);
        make.right.equalTo(cell.contentView).with.offset(-5);
        make.bottom.equalTo(cell.contentView);
    }];
    
    if (indexPath.row != 0) {
        GFImageCodeVo *data = [_mSearchDatas objectAtIndex:indexPath.row - 1];
        [imageCode setText:data.imageCode];
        [imageDesc setText:data.imageDesc];
        [imageDesc setTextAlignment:NSTextAlignmentLeft];
    }
    
    return cell;
}

// 查找结果显示时的复选框响应方法
- (void)clickCheckSecondButton:(GFButton *)button {
    
    NSString *choose = _mSecondDatas[button.tag];
    
    if (button.tag == 0) {
        
        if ([choose isEqualToString:@"NO"]) {
            
            [_mSecondDatas removeAllObjects];
            
            for (NSInteger i = 0; i<_mSearchDatas.count + 1; i++) {
                
                
                [_mSecondDatas addObject:@"YES"];
                
            }
        } else {
            
            [_mSecondDatas removeAllObjects];
            
            for (NSInteger i = 0; i<_mSearchDatas.count + 1; i++) {
                
                
                [_mSecondDatas addObject:@"NO"];
                
            }
        }
        
        [_mTableView reloadData];
    } else {
        
        if ([choose isEqualToString:@"NO"]) {
            
            [_mSecondDatas replaceObjectAtIndex:button.tag withObject:@"YES"];
        } else {
            
            [_mSecondDatas replaceObjectAtIndex:button.tag withObject:@"NO"];
        }
        
        //局部cell刷新
        NSIndexPath *markIndex = [NSIndexPath indexPathForRow:button.tag inSection:0];
        [_mTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:markIndex,nil] withRowAnimation:NO];
        
    }
    
}

#pragma mark =====事件响应=====

/**
 *  点击查找按钮
 */
- (void)clickSearch {
    [self hideInput];
    
    if ([_mSearchText.text isEqualToString:@""]) {
        [self clickDelete];
    } else {
        _mSearchDatas = [GFImageCodeDao searchImageCodeLike:_mSearchText.text];
        [_mSecondDatas removeAllObjects];
        for (NSInteger i = 0; i<_mSearchDatas.count + 1; i++) {
            
            
            [_mSecondDatas addObject:@"NO"];
            
        }
        [_mTableView reloadData];
        [_mTableView setHidden:NO];
        [_mTreeView setHidden:YES];
//        [_confirmBtn setHidden:YES];
    }
}

/**
 *  点击删除按钮
 */
- (void)clickDelete {
    [self hideInput];
    
    [_mSearchText setText:@""];
    [_mTableView setHidden:YES];
    [_mTreeView setHidden:NO];
    [_confirmBtn setHidden:NO];
}

/**
 *  点击提交按钮
 */
- (void)clickConfirm {
    
    //个数限制
    NSInteger number = 0;
    
    //数据拼接
    NSString *resultString = @"";
    if (_mTableView.hidden == YES) {
        
        for (GFImageCodeVo *firstVo in _mDataVos.childrenVos) {
            for (GFImageCodeVo *secondVo in firstVo.childrenVos) {
                if (!secondVo.childrenVos || secondVo.childrenVos.count == 0) {
                    if (secondVo.isCheck) {
                        resultString = [NSString stringWithFormat:@"%@;%@", resultString, secondVo.imageCode];
                        number += 1;
                    }
                } else {
                    for (GFImageCodeVo *thirdVo in secondVo.childrenVos) {
                        if (thirdVo.isCheck) {
                            resultString = [NSString stringWithFormat:@"%@;%@", resultString, thirdVo.imageCode];
                            number += 1;
                        }
                    }
                }
            }
        }

    } else {
        
        if (_mSearchDatas.count != 0) {

                
            if ([_mSecondDatas[0] isEqualToString:@"YES"]) {
                
                for (NSInteger i = 0; i<_mSecondDatas.count - 1 ; i++) {
                    
                    GFImageCodeVo *data = [_mSearchDatas objectAtIndex:i];
                    resultString = [NSString stringWithFormat:@"%@;%@", resultString, data.imageCode];
                    number += 1;
                }
                
            } else {
                
                for (NSInteger i = 0; i<_mSearchDatas.count ; i++) {
                    
                    if ([_mSecondDatas[i+1] isEqualToString:@"YES"]) {
                        
                        GFImageCodeVo *data = [_mSearchDatas objectAtIndex:i];
                        
                        resultString = [NSString stringWithFormat:@"%@;%@", resultString, data.imageCode];
                        number += 1;
                    }
                }
            }
        }
        
    }
    
    if (number > 5) {
        [self showNoticeHudWithTitle:@"查询上限为5个" subtitle:@"查询上限为5个" onView:self.navigationController.view inDuration:2];
        return;
    }
    
    
    if (![resultString isEqualToString:@""]) {
        
        [_dataResultDelegate imageCodeResultData:[resultString substringFromIndex:1]];
    } else {
        
        [_dataResultDelegate imageCodeResultData:resultString];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark =====普通方法=====

/**
 *  隐藏键盘
 */
- (void)hideInput {
    [_mSearchText endEditing:YES];
}

@end
