//
//  GFRangeSecondeViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/21.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFRangeSecondViewController.h"
#import "GFRangeDao.h"
#import "GFRangeVo.h"
#import "GFButton.h"
#import "GFTypePickerView.h"
#import "RATreeView.h"

@interface GFRangeSecondViewController () <RATreeViewDelegate, RATreeViewDataSource, UITextFieldDelegate,TypePickerViewDelegate> {
    BOOL isOnShow[45];
}

@property (nonatomic, strong) NSMutableArray *secondRangeData;
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UITextField *firstRangeInput;
@property (nonatomic, strong) UIImageView *firstRangeInputImageView;
@property (nonatomic, strong) UITextField *secondRangeInput;
@property (nonatomic, strong) UIImageView *secondRangeInputImageView;
@property (nonatomic, strong) RATreeView *treeView;

@property (nonatomic, strong) GFTypePickerView *categoryPicker;
@property (nonatomic, strong) GFTypePickerView *categoryGroupPicker;
@property (nonatomic,strong)NSMutableDictionary *buttonDic;
@property (nonatomic,strong)NSMutableDictionary *markDic;


@end

@implementation GFRangeSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initSearchView];
    [self initTreeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  初始化显示数据
 */
- (void)initData {
    _secondRangeData = [GFRangeDao searchDataByFirstID:@"" SecondID:@""];
    
    _buttonDic = [NSMutableDictionary new];
    for (NSInteger i = 0; i<45; i++) {
        
        NSString* name = [NSString stringWithFormat:@"%@%@%@", @"第", [NSString stringWithFormat:@"%02ld", (long)i+1], @"类"];
        
        [_buttonDic setObject:@"NO" forKey:name];
        
    }
    
    _markDic = [NSMutableDictionary new];
    for (NSInteger i = 0; i<45; i++) {
        
        NSString* name = [NSString stringWithFormat:@"%@%@%@", @"第", [NSString stringWithFormat:@"%02ld", (long)i+1], @"类"];
        
        [_markDic setObject:@"0" forKey:name];
        
    }
    
}

/**
 *  初始化搜索栏
 */
- (void)initSearchView {
    // 搜索栏样式
    _searchView = [[UIView alloc] init];
    [self.view addSubview:_searchView];
    [_searchView setBackgroundColor:[UIColor whiteColor]];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    // 类别Label
    UILabel *firstRangeLabel = [[UILabel alloc] init];
    [_searchView addSubview:firstRangeLabel];
    [firstRangeLabel setFont:[UIFont systemFontOfSize:14]];
    [firstRangeLabel setText:@"类别："];
    [firstRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchView).with.offset(5);
        make.centerY.equalTo(_searchView);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(55);
    }];
    
    // 类别搜索输入框
    UIButton* firstRangeInputButton = [UIButton new];
    firstRangeInputButton.tag = 0;
    [firstRangeInputButton addTarget:self action:@selector(actionSearchFirst:) forControlEvents:UIControlEventTouchUpInside];
    firstRangeInputButton.backgroundColor = [UIColor whiteColor];
    [_searchView addSubview:firstRangeInputButton];
    [firstRangeInputButton setBorderR:230 G:230 B:230 alpha:1 width:1];
    
    
    _firstRangeInput = [[UITextField alloc] init];
    _firstRangeInput.text = @"所有";
    _firstRangeInput.userInteractionEnabled = NO;
    _firstRangeInput.textAlignment = NSTextAlignmentCenter;
    [firstRangeInputButton addSubview:_firstRangeInput];
    [_firstRangeInput setKeyboardType:UIKeyboardTypeNumberPad];
    [_firstRangeInput setBackgroundColor:[UIColor whiteColor]];
    [_firstRangeInput.layer setBorderWidth:1];
    [_firstRangeInput.layer setBorderColor:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor];
    [_firstRangeInput setFont:[UIFont systemFontOfSize:14]];
    [_firstRangeInput setDelegate:self];
    
    _firstRangeInputImageView = [UIImageView new];
    [_firstRangeInputImageView assignmentWithImageView:@"ic_show_open" model:UIViewContentModeScaleAspectFit];
    [firstRangeInputButton addSubview:_firstRangeInputImageView];
    
    
    // 类似群Label
    UILabel *secondRangeLable = [[UILabel alloc] init];
    [_searchView addSubview:secondRangeLable];
    [secondRangeLable setFont:[UIFont systemFontOfSize:14]];
    [secondRangeLable setText:@"类似群："];
    [secondRangeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstRangeInputButton.mas_right).with.offset(5);
        make.centerY.equalTo(_searchView);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(60);
    }];
    
    
    
    // 类别搜索输入框
    UIButton* secondRangeInputButton = [UIButton new];
    secondRangeInputButton.tag = 2;
    [secondRangeInputButton addTarget:self action:@selector(actionSearchSecond:) forControlEvents:UIControlEventTouchUpInside];
    secondRangeInputButton.backgroundColor = [UIColor whiteColor];
    [_searchView addSubview:secondRangeInputButton];
    [secondRangeInputButton setBorderR:230 G:230 B:230 alpha:1 width:1];
    
    _secondRangeInput = [[UITextField alloc] init];
    _secondRangeInput.userInteractionEnabled = NO;
    _secondRangeInput.text = @"所有";
    _secondRangeInput.textAlignment = NSTextAlignmentCenter;
    [secondRangeInputButton addSubview:_secondRangeInput];
    [_secondRangeInput setKeyboardType:UIKeyboardTypeNumberPad];
    [_secondRangeInput setBackgroundColor:[UIColor whiteColor]];
    [_secondRangeInput.layer setBorderWidth:1];
    [_secondRangeInput.layer setBorderColor:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor];
    [_secondRangeInput setFont:[UIFont systemFontOfSize:14]];
    [_secondRangeInput setDelegate:self];
    
    _secondRangeInputImageView = [UIImageView new];
    [_secondRangeInputImageView assignmentWithImageView:@"ic_show_open" model:UIViewContentModeScaleAspectFit];
    [secondRangeInputButton addSubview:_secondRangeInputImageView];

    
    // 搜索按钮
    UIButton *searchButton = [[UIButton alloc] init];
    [_searchView addSubview:searchButton];
    [searchButton addTarget:self action:@selector(actionSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
    [searchButton setTitle:@"查找" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor colorWithRed:106.0/255 green:175.0/255 blue:240.0/255 alpha:1] forState:UIControlStateHighlighted];
    [searchButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondRangeInputButton.mas_right).with.offset(5);
        make.right.equalTo(_searchView).with.offset(-3.5);
        make.centerY.equalTo(_searchView);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(46.5);
    }];
    
/*     确认按钮
    UIButton *confirmButton = [[UIButton alloc] init];
    [_searchView addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(chooseEvent) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor colorWithRed:106.0/255 green:175.0/255 blue:240.0/255 alpha:1] forState:UIControlStateHighlighted];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchButton.mas_right).with.offset(5);
        make.right.equalTo(_searchView).with.offset(-5);
        make.centerY.equalTo(_searchView);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(50);
 
    }];
 */
    
    // 搜索输入框约束
    [firstRangeInputButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstRangeLabel.mas_right).with.offset(5);
        make.centerY.equalTo(_searchView);
        make.height.mas_equalTo(33);
        make.width.equalTo(secondRangeInputButton);
    }];
    
    [_firstRangeInputImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(firstRangeInputButton.mas_right).with.offset(-2.5);
        make.top.mas_equalTo(firstRangeInputButton.mas_top).with.offset(0);
        make.width.mas_equalTo(18);
        make.bottom.mas_equalTo(firstRangeInputButton.mas_bottom).with.offset(0);
    }];
    
    [_firstRangeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstRangeInputButton.mas_left).with.offset(0);
        make.top.mas_equalTo(firstRangeInputButton.mas_top).with.offset(0);
        make.bottom.mas_equalTo(firstRangeInputButton.mas_bottom).with.offset(0);
        make.right.mas_equalTo(_firstRangeInputImageView.mas_left).with.offset(-2.5);
    }];
    
    
    // 搜索输入框约束
    [secondRangeInputButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondRangeLable.mas_right).with.offset(5);
        make.centerY.equalTo(_searchView);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo(((CGFloat)Device_Width)/4);
    }];
    
    [_secondRangeInputImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(secondRangeInputButton.mas_right).with.offset(-2.5);
        make.top.mas_equalTo(secondRangeInputButton.mas_top).with.offset(0);
        make.width.mas_equalTo(18);
        make.bottom.mas_equalTo(secondRangeInputButton.mas_bottom).with.offset(0);
    }];
    
    [_secondRangeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondRangeInputButton.mas_left).with.offset(0);
        make.top.mas_equalTo(secondRangeInputButton.mas_top).with.offset(0);
        make.bottom.mas_equalTo(secondRangeInputButton.mas_bottom).with.offset(0);
        make.right.mas_equalTo(_secondRangeInputImageView.mas_left).with.offset(-2.5);
    }];
    
    UILabel* label = [UILabel new];
    [_searchView addSubview:label];
    [label setBackgroundColor:KRGBA(235, 235, 235, 1)];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_searchView.mas_left).with.offset(5);
        make.bottom.mas_equalTo(_searchView.mas_bottom).with.offset(0);
        make.right.mas_equalTo(_searchView.mas_right).with.offset(-5);
        make.height.mas_equalTo(0.5);
    }];
}

/**
 *  初始化列表数据
 */
- (void)initTreeView {
    _treeView = [[RATreeView alloc] init];
    [self.view addSubview:_treeView];
    [_treeView setDelegate:self];
    [_treeView setDataSource:self];
    [_treeView reloadData];
    [_treeView setSeparatorStyle:RATreeViewCellSeparatorStyleSingleLine];//设置分隔符风格
    [_treeView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RangCell"];
    [_treeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.searchView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    
    //[self setButton:_treeView];
}
/*确定按钮的样式设计
-(void)setButton:(RATreeView*)collectionView {
    
    //     配置样式
    GFButton *confirmButton = [[GFButton alloc] init];
    [confirmButton addTarget:self action:@selector(chooseEvent) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"bg_btn_login_pressed"] forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).with.offset(0);
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(43);
    }];
    
}
*/


#pragma mark -树形列表代理
// 树形列表代理，返回对应节点的数据
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item{
    if (item == nil) {
        return [_secondRangeData objectAtIndex:index];
    } else {
        
        NSMutableArray *itemData = item;
        for (GFRangeVo *vo in itemData) {

            NSString *str1 = [NSString stringWithFormat:@"%@%@%@", @"第", vo.firstRangeID, @"类"];
            NSString* boolString = _buttonDic[str1];
            NSString* mark = _markDic[str1];
            if ([mark isEqualToString:@"1"]) {
                
                if ([boolString boolValue]) {
                    
                    vo.isCheck = YES;
                } else {
                    
                    vo.isCheck = NO;
                }
            }
        }
        return [itemData objectAtIndex:index];
    }
}

// 树形列表代理，返回子节点数目
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return [_secondRangeData count];
    } else if ([item isKindOfClass:[GFRangeVo class]]) {
        return 0;
    } else {
        return [item count];
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
    
    // cell重用
    UITableViewCell *cell =  [treeView dequeueReusableCellWithIdentifier:@"RangCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"RangCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    // 配置cell样式
    if ([item isKindOfClass:[GFRangeVo class]]) {
        return [self configureChildrenCell:cell inItemData:item];
    } else {
        return [self configureSectionCell:cell inItemData:[item objectAtIndex:0]];
    }
}
/*全选事件处理
#pragma mark - 全选
-(void)imageNameButton:(UIButton*)button {

    NSLog(@"%@",button.titleLabel.text);
    NSString *imageNameBool = _buttonDic[button.titleLabel.text];
//    NSString *str1 = [button.titleLabel.text stringByReplacingOccurrencesOfString:@"第" withString:@""];
//    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"类" withString:@""];
//    //获取对应父类的所有子类
//    _secondRangeData = [GFRangeDao searchDataByFirstID:str2 SecondID:@""];
//
//
//    NSMutableArray* arrayData = [GFRangeDao searchDataByFirstID:str2 SecondID:@""];
//    NSMutableArray* arrayData2 = _secondRangeData[0];
//

    if ([imageNameBool isEqualToString:@"YES"]) {

        //父类打钩
        [_buttonDic setValue:@"NO" forKey:button.titleLabel.text];
    } else {
        //父类打钩
        [_buttonDic setValue:@"YES" forKey:button.titleLabel.text];
//        if (isOnShow[[str2 integerValue]] == NO) {
//
//            [self treeView:_treeView didSelectRowForItem:arrayData[0]];
//            [self treeView:_treeView numberOfChildrenOfItem:arrayData[0]];
//            [self treeView:_treeView child:[str2 integerValue]-1 ofItem:arrayData[0]];
//        }
    }
    [_markDic setValue:@"1" forKey:button.titleLabel.text];

    [_treeView reloadRows];
}
*/
/**
 *  配置Section样式
 *  @param cell 配置的Cell
 *  @param itemData 对应的Section的数据
 *  @return 配置完成的Cell
 */
- (UITableViewCell *)configureSectionCell:(UITableViewCell *)cell inItemData:(GFRangeVo *)itemData {
    
    UIButton *button = [UIButton new];
    //[button addTarget:self action:@selector(imageNameButton:) forControlEvents:UIControlEventTouchUpInside];
    NSString *buttonName = [NSString stringWithFormat:@"%@%@%@", @"第", itemData.firstRangeID, @"类"];
    [button setTitle:buttonName forState:UIControlStateNormal];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [cell.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).with.offset(5);
    }];
    button.hidden = true;//隐藏选择按钮
    
    // 选择的提示框
    NSString *imageNameBool = _buttonDic[buttonName];
    if ([imageNameBool boolValue]) {
        imageNameBool = @"ic_check_yes";
    } else {
        imageNameBool = @"ic_check_no";
    }
    UIImageView *imageViewButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNameBool]];
    imageViewButton.hidden = true;//隐藏选择按钮
    [button addSubview:imageViewButton];
    [imageViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(button.mas_top).with.offset(0);
        make.left.mas_equalTo(button.mas_left).with.offset(0);
        make.right.mas_equalTo(button.mas_right).with.offset(0);
        make.bottom.mas_equalTo(button.mas_bottom).with.offset(0);
    }];
    
    // Section标题
    UILabel *label = [[UILabel alloc] init];
    [cell.contentView addSubview:label];
    [label setFont:[UIFont systemFontOfSize:14]];
    //[label setText:[NSString stringWithFormat:@"%@%@%@   %@", @"第", itemData.firstRangeID, @"类",itemData.firstRangeName]];
    [label setText:[NSString stringWithFormat:@"%@%@%@", @"第", itemData.firstRangeID, @"类"]];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(button.mas_right).with.offset(10);
    }];
    
    // Section的展开与关闭状态
    NSString *imageName;
    if (isOnShow[[itemData.firstRangeID integerValue]]) {
        imageName = @"ic_show_close";/********************************/
    } else {                         /***********ic_show_close和ic_show_open互换位置！！！*********************/
        imageName = @"ic_show_open";/********************************/
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.centerY.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).with.offset(-10);
    }];
    
    // 分割线
    UIView *line = [[UIView alloc] init];
    [cell.contentView addSubview:line];
    [line setBackgroundColor:[UIColor colorWithRed:233.0/255 green:233.0/255 blue:233.0/255 alpha:1]];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(cell.contentView).with.offset(10);
        make.right.equalTo(cell.contentView).with.offset(-10);
        make.bottom.equalTo(cell.contentView);
    }];
    
    return cell;
}

/**
 *  配置Children样式
 *  @param cell 配置的Cell
 *  @param itemData 对应的Children的数据
 *  @return 配置完成的Cell
 */
- (UITableViewCell *)configureChildrenCell:(UITableViewCell *)cell inItemData:(GFRangeVo *)itemData {
    // 背景设定
    UIView *background = [[UIView alloc] init];
    [cell.contentView addSubview:background];
    [background setBackgroundColor:[UIColor colorWithRed:231.0/255 green:243.0/255 blue:255.0/255 alpha:1]];
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).with.offset(0.5);
        make.bottom.equalTo(cell.contentView).with.offset(-0.5);
        make.left.equalTo(cell.contentView).with.offset(10);
        make.right.equalTo(cell.contentView).with.offset(-10);
    }];
    
    //子类 与 父类 关系
    // 选择的提示框
    NSString *imageName;
    NSString *str1 = [NSString stringWithFormat:@"%@%@%@", @"第", itemData.firstRangeID, @"类"];
    NSString* boolString = _buttonDic[str1];
    NSString* mark = _markDic[str1];
    if ([mark isEqualToString:@"1"]) {
        
        if ([boolString boolValue]) {
            
            imageName = @"ic_check_yes";
            itemData.isCheck = YES;
        } else {
            
            imageName = @"ic_check_no";
            itemData.isCheck = NO;
        }
    } else {
        
        if (itemData.isCheck) {
            imageName = @"ic_check_yes";
        } else {
            imageName = @"ic_check_no";
        }
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [cell.contentView addSubview:imageView];
    imageView.hidden = true;//隐藏选择按钮
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(background).with.offset(10);
    }];
    
    // id Label
    UILabel *idLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:idLabel];
    [idLabel setFont:[UIFont systemFontOfSize:14]];
    [idLabel setText:itemData.secondRangeID];
    [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.left.equalTo(imageView.mas_right).with.offset(10);
        make.centerY.equalTo(background);
    }];
    
    // name Label
    UILabel *nameLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:nameLabel];
    [nameLabel setFont:[UIFont systemFontOfSize:14]];
    [nameLabel setText:itemData.secondRangeName];
    [nameLabel setNumberOfLines:2];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(idLabel.mas_right);
        make.right.equalTo(background).with.offset(-10);
        make.centerY.equalTo(background);
    }];
    
    return cell;
}

// 树形列表代理，点击事件
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item {
    if ([item isKindOfClass:[GFRangeVo class]]) {
        GFRangeVo *itemData = item;
        itemData.isCheck = !itemData.isCheck;
        NSString *str1 = [NSString stringWithFormat:@"%@%@%@", @"第", itemData.firstRangeID, @"类"];
        [_buttonDic setValue:@"NO" forKey:str1];
        [_markDic setValue:@"0" forKey:str1];
    } else {
        GFRangeVo *itemData = [item objectAtIndex:0];
        isOnShow[[itemData.firstRangeID integerValue]] = !isOnShow[[itemData.firstRangeID integerValue]];
    }
    [_treeView reloadRows];
}

/**
 *  执行类别下拉框
 */
- (void)actionSearchFirst:(UIButton*)button {
    
    [self chooseSearchCategory];
}

/**
 *  执行类似群下拉框
 */
- (void)actionSearchSecond:(UIButton*)button {
    
    if ([_firstRangeInput.text isEqualToString:@"所有"]) {
        
        [self showNoticeHudWithTitle:@"请先切换类别状态" subtitle:@"请先切换类别状态" onView:self.navigationController.view inDuration:1];
        return;
    }
    
    [self chooseSearchGroupCategory];
}

/**
 *  选择查询类别
 */
- (void)chooseSearchCategory {
    if (!_categoryPicker) {
        NSMutableArray *datas = [[NSMutableArray alloc] init];
        for (int i = 0; i < 46; i++) {
            if (i == 0) {
                
               NSString *name = @"所有";
                NSDictionary *data = @{@"key" : name};
                [datas addObject:data];
            } else{
                
                NSString *name = [NSString stringWithFormat:@"%02d", i];
                NSDictionary *data = @{@"key" : name};
                [datas addObject:data];
            }

        }
        CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _categoryPicker = [[GFTypePickerView alloc] initWithFrame:rect withData:datas withKeyForTitle:@"key"];
        _categoryPicker.tag = 1;
        [_categoryPicker setDelegate:self];
    }
    [self.view addSubview:_categoryPicker];
    [_categoryPicker show];

}

/**
 *  选择查询类似群
 */
- (void)chooseSearchGroupCategory {
    
    //数据整理
    NSMutableArray* arrayData = [GFRangeDao searchDataByFirstID:_firstRangeInput.text SecondID:@""];
    
    NSMutableArray *chooseDatas = [[NSMutableArray alloc] init];
    for (NSMutableArray *ground in arrayData) {
        for (GFRangeVo *vo in ground) {
            NSDictionary *data = @{@"key" : vo.secondRangeID};
            [chooseDatas addObject:data];
        }
    }
    [chooseDatas insertObject:@{@"key" : @"所有"} atIndex:0];
    
    //调出控制器
    if (!_categoryGroupPicker) {
        CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _categoryGroupPicker = [[GFTypePickerView alloc] initWithFrame:rect withData:chooseDatas withKeyForTitle:@"key"];
        _categoryGroupPicker.tag = 2;
        [_categoryGroupPicker setDelegate:self];
    } else {
        
        _categoryGroupPicker.dataList = chooseDatas;
        [_categoryGroupPicker.picker reloadAllComponents];
    }
    
    [self.view addSubview:_categoryGroupPicker];
    [_categoryGroupPicker show];
    
}

/**
 *  接收选择查询类型结果
 */

- (void)typePicker:(GFTypePickerView *)pickerView didSeleteTitle:(NSDictionary *)titleInfo {
    
    NSString*string = [titleInfo objectForKey:@"key"];
    
    if (pickerView.tag ==1) {
        
        _firstRangeInput.text = string;
        if ([_firstRangeInput.text isEqualToString:@"所有"]) {
            _secondRangeInput.text = @"所有";
        }
       NSLog(@"1---%@",string);
    } else {
        
        _secondRangeInput.text = string;
       NSLog(@"2---%@",string);
    }
    
}

/**
 *  执行查找
 */
- (void)actionSearch {
    [self hideInput];
    
    for (NSMutableArray *ground in _secondRangeData) {
        for (GFRangeVo *vo in ground) {
            
            isOnShow[[vo.firstRangeID integerValue]] = 0;
        }
    }
    
    if ([_firstRangeInput.text isEqualToString:@"所有"]) {
        
        _secondRangeData = [GFRangeDao searchDataByFirstID:@"" SecondID:@""];
    } else {
        
        if ([_secondRangeInput.text isEqualToString:@"所有"]) {
            
            _secondRangeData = [GFRangeDao searchDataByFirstID:[_firstRangeInput text] SecondID:@""];
        } else {
            
            _secondRangeData = [GFRangeDao searchDataByFirstID:[_firstRangeInput text] SecondID:[_secondRangeInput text]];
        }
    }
    
    [_treeView reloadData];
}

/**
 *  点击确认按钮事件
 */
- (void)chooseEvent {

    NSMutableArray *chooseDatas = [[NSMutableArray alloc] init];
    
    for (NSMutableArray *ground in _secondRangeData) {
        
        for (GFRangeVo *vo in ground) {
            
            NSString *str1 = [NSString stringWithFormat:@"%@%@%@", @"第", vo.firstRangeID, @"类"];
            NSString* boolString = _buttonDic[str1];
            if ([boolString boolValue]) {
                
                if (isOnShow[[vo.firstRangeID integerValue]] == NO) {
                    
                    [chooseDatas addObject:vo.secondRangeID];
                    
                }
                
            }
        }
    }
    
    for (NSMutableArray *ground in _secondRangeData) {
        for (GFRangeVo *vo in ground) {
            if (vo.isCheck) {
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
    
    [self.dataResultDelegate chooseRangeResultType:RangeTypeSecond Data:dataArray];
    [self.navigationController popViewControllerAnimated:YES];
}

// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideInput];
    return YES;
}

// 隐藏键盘
- (void)hideInput {
    [_firstRangeInput endEditing:YES];
    [_secondRangeInput endEditing:YES];
}

@end
