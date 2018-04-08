
//
//  StyleResultViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/4/26.
//  Copyright © 2016年 gf. All rights reserved.
//
#import "StyleResultViewController.h"
//#import "NSLogVo.h"
#import "StyleResultViewControllerCell.h"
//#import "GFDatePickerView.h"
#import "GFTradeDao.h"
#import "GFTradeVo.h"
#import "GFDeviceVo.h"
#import "GFRangeStyleResultDao.h"
#import "GFRangeStyleResultVo.h"
#import "GFRangeRootViewController.h"


@interface StyleResultViewController () <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITextField *input_text;

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *mDatas;

@property(nonatomic,strong)UILabel *timeFormLabel;

@property(nonatomic,strong)UILabel *timeToLabel;

//@property (nonatomic, strong) GFDatePickerView *timePickerStart;

//@property (nonatomic, strong) GFDatePickerView *timePickerEnd;

@property (nonatomic, strong) NSString *mStartTime;

@property (nonatomic, strong) NSString *mEndTime;

@property (nonatomic ,strong) NSString *page;




@property NSMutableArray *datas;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation StyleResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  初始化数据
 */
- (void)setupData {
    _mDatas = [[NSMutableArray alloc] init];
    
    _page = @"1";
    
    //得到往后的时间 --- 对应开始时间
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//公历日历标识符
    NSDateComponents *comps = nil;//日期组件
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    //对应年月日 -号为往后，反之为前
    [adcomps setYear:0];
    [adcomps setMonth:-3];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    //开始时间
    _mStartTime  = beforDate;
    
    //获取当前时间，日期 ---- 对应结束时间
    NSDate *theDate = [NSDate date];
    NSString *theDateString = [dateFormatter stringFromDate:theDate];
    //结束时间
    _mEndTime = theDateString;
    
    //一进界面获取默认 今天往后3个月 数据
    [self requestData];
}

/**
 *  初始化界面
 */
- (void)setupView {
    
    
    // 设置标题背景
    [self setTitle:@"【商品分类】查询结果"];
    //[self setTitle:(@"my_log_title", nil)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    /**************updatedTimeView:输入查询内容*****************/
    
    UIView* updatedTimeView = [UIView new];
    [self.view addSubview:updatedTimeView];
    [updatedTimeView setBackgroundColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
    [updatedTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(0);
        make.height.mas_equalTo(30);
    }];
    UILabel *updatedTime = [[UILabel alloc]init];
    [updatedTimeView addSubview:updatedTime];
//    [updatedTime setFont:12];
    //[updatedTime setFont:@13];
   // updatedTime.font = 12;
    [updatedTime setFont:[UIFont systemFontOfSize:13]];
    //commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [updatedTime setText:@"网报同步日期:2018年3月19日"];
    [updatedTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(updatedTimeView);
        make.height.mas_equalTo(20);
    }];
    
    
/**************updatedTimeView:输入查询内容*****************/
   
    
/**************btnActionView:重置、提交  按钮操作*****************/
    /*
//    UIView* btnActionView = [UIView new];
//    [self.view addSubview:btnActionView];
//    [btnActionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
//        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
//        make.top.mas_equalTo(updatedTimeView.mas_bottom).with.offset(0);
//        //make.top.equalTo(topView.mas_bottom).with.offset(Device_Height/20);
//        make.height.mas_equalTo(75);
//    }];
//    [self setLayView:btnActionView];
//
    */
    // 搜索栏背景
    UIView *searchView = [[UIView alloc] init];
    [self.view addSubview:searchView];
    [searchView setBackgroundColor:[UIColor whiteColor]];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(38);
        make.left.equalTo(self.view);
        make.top.mas_equalTo(updatedTimeView.mas_bottom).with.offset(0);;
    }];
  
    
    
    
    //跳转分类表按钮
    UIButton *turnTostyleTableBtn = [[UIButton alloc]init];
    [searchView addSubview:turnTostyleTableBtn];
    [turnTostyleTableBtn setTitle:@"跳转至分类表" forState:UIControlStateNormal];
    [turnTostyleTableBtn setImage:[UIImage imageNamed:@"商品分类_bule"] forState:UIControlStateNormal];
    [turnTostyleTableBtn setTintColor:[UIColor redColor]];
    turnTostyleTableBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [turnTostyleTableBtn addTarget:self action:@selector(actionTurnTostyleTable) forControlEvents:UIControlEventTouchUpInside];
//    //设置边框
//    turnTostyleTableBtn.layer.cornerRadius = 4;
//    turnTostyleTableBtn.layer.borderWidth = 1;
//    turnTostyleTableBtn.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    [turnTostyleTableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.centerY.equalTo(searchView);
        make.height.mas_equalTo(35);
        make.right.equalTo(searchView).with.offset(-5);
    }];
    
    // 查找按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchView addSubview:searchBtn];
    [searchBtn setTitle:@"查找" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor blueColor]];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"bg_blue"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(actionCommodityStyleSearch) forControlEvents:UIControlEventTouchUpInside];
    //设置边框
//    searchBtn.layer.cornerRadius = 4;
//    searchBtn.layer.borderWidth = 1;
//    searchBtn.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.width.mas_equalTo(60);
        //        make.height.mas_equalTo(35);
        //        make.right.equalTo(deleteBtn.mas_left).with.offset(-5);
        //        make.centerY.equalTo(searchView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
        make.right.equalTo(turnTostyleTableBtn.mas_left).with.offset(-5);
        make.centerY.equalTo(searchView);
    }];
    _input_text = [[UITextField alloc]init];
    //    titleLabel.backgroundColor = [UIColor blackColor];
    [searchView addSubview:_input_text];
    _input_text.delegate = self;
    //[nameLabel sizeWithfont:14.5 color:[UIColor blackColor] TextAlignment:NSTextAlignmentLeft text:@"my_log_message" mark:1];
    [_input_text setBackgroundColor:[UIColor whiteColor]];
    [_input_text setTextAlignment:NSTextAlignmentCenter];
    [_input_text setReturnKeyType:UIReturnKeyGo];
    [_input_text setPlaceholder:@"请输入类似群、商品中/英文"];
    [_input_text setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    // 清除按钮的状态=只有在文本字段中编辑文本时，才会显示覆盖视图。
    _input_text.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input_text.layer.masksToBounds = YES;
    _input_text.layer.cornerRadius = 4;
    _input_text.layer.borderWidth = 1;
    //边界颜色
    _input_text.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    [_input_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.left.equalTo(searchView).with.offset(5);
        make.right.equalTo(searchBtn.mas_left).with.offset(-5);
        make.centerY.equalTo(searchView);
    }];
    
    
    
    
    
    
    // 列表
    _mTableView = [[UITableView alloc] init];
    [self.view addSubview:_mTableView];
    [_mTableView setDelegate:self];
    [_mTableView setDataSource:self];
    //[_mTableView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestListFooterRefresh)]];
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(searchView.mas_bottom).with.offset(5);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
    }];
}

#pragma mark - 布局
-(void)setLayView:(UIView*)view {
    _input_text = [[UITextField alloc]init];
    //    titleLabel.backgroundColor = [UIColor blackColor];
    [view addSubview:_input_text];
    _input_text.delegate = self;
    //[nameLabel sizeWithfont:14.5 color:[UIColor blackColor] TextAlignment:NSTextAlignmentLeft text:@"my_log_message" mark:1];
    [_input_text setBackgroundColor:[UIColor whiteColor]];
    [_input_text setTextAlignment:NSTextAlignmentCenter];
    [_input_text setReturnKeyType:UIReturnKeyGo];
    [_input_text setPlaceholder:@"请输入类似群、商品中/英文"];
    [_input_text setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    // 清除按钮的状态=只有在文本字段中编辑文本时，才会显示覆盖视图。
    _input_text.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input_text.layer.masksToBounds = YES;
    _input_text.layer.cornerRadius = 4;
    _input_text.layer.borderWidth = 1;
    //边界颜色
    _input_text.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    [_input_text mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(view.mas_top).with.offset(5);
        make.left.mas_equalTo(view.mas_left).with.offset(10);
        make.right.mas_equalTo(view.mas_right).with.offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *resetBtn = [[UIButton alloc]init];
    [view addSubview:resetBtn];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTintColor:[UIColor redColor]];
    [resetBtn setBackgroundColor:[UIColor greenColor]];
    
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    resetBtn.backgroundColor = [UIColor orangeColor];
    [resetBtn addTarget:self action:@selector(emptyContent) forControlEvents:UIControlEventTouchUpInside];
    //设置边框
    resetBtn.layer.cornerRadius = 4;
    resetBtn.layer.borderWidth = 1;
    resetBtn.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_input_text.mas_bottom).with.offset(5);
        make.left.mas_equalTo(view.mas_left).with.offset(10);
        make.right.mas_equalTo(view.mas_left).with.offset(Device_Width/2+5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(Device_Width/2-15);
    }];
    
    
    UIButton *commitBtn = [[UIButton alloc]init];
    [view addSubview:commitBtn];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTintColor:[UIColor redColor]];
    [commitBtn setBackgroundColor:[UIColor blueColor]];
    [commitBtn addTarget:self action:@selector(actionCommodityStyleSearch) forControlEvents:UIControlEventTouchUpInside];
    
    
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    commitBtn.backgroundColor = [UIColor orangeColor];
    //[commitBtn addTarget:self action:@selector(inquire) forControlEvents:UIControlEventTouchUpInside];
    //设置边框
    commitBtn.layer.cornerRadius = 4;
    commitBtn.layer.borderWidth = 1;
    commitBtn.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_input_text.mas_bottom).with.offset(5);
        make.left.mas_equalTo(resetBtn.mas_right).with.offset(5);
        //make.right.mas_equalTo(view.mas_right).with.offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(Device_Width/2-15);
    }];
    // 分割线
    UIView *line1 = [[UIView alloc] init];
    [view addSubview:line1];
    [line1 setBackgroundColor:[UIColor colorWithWhite:240.0/255 alpha:1]];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(view.mas_left).with.offset(0);
        make.right.mas_equalTo(view.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
    }];
    
}
#pragma mark ===== 列表代理方法 =====

// 返回Cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return _mDatas.count + 1;
    return _datas.count;
}

// 返回Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    } else {
        return 50;
    }
}

// 返回Cell的样式                                        在索引路径上的行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CardViewCellId = @"StyleResultViewControllerCellID";
    StyleResultViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:CardViewCellId];
    if (cell == nil)
    {
        cell = [[StyleResultViewControllerCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CardViewCellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    NSString* firstRangeID;
    NSString* secondRangeID;
    NSString* thirdRangeName;
    NSString* thirdRangeNameInEnglish;
    if (_datas == NULL) {
        
    }
    
    if (indexPath.row == 0) {
        firstRangeID = @"类似群";
        secondRangeID = @"群组名";
        thirdRangeName = @"商品中文";
        thirdRangeNameInEnglish = @"商品英文";
    } else {
        /*原始方案
//        GFTradeVo *tradeVo = _mDatas[indexPath.row-1];
//        cardNumber = [NSString stringWithFormat:@"%ld",indexPath.row];
//        cardNumber = tradeVo.range_first_id;
//        cardState = tradeVo.range_second_id;
//        cardStartToStop = tradeVo.range_third_name;
//        cardTime = tradeVo.range_third_name_en;
        */
        
        GFRangeStyleResultVo *rangeVo = [_datas objectAtIndex:indexPath.row-1];
        //GFRangeStyleResultVo *rangeVo = _datas[indexPath.row];
        firstRangeID = rangeVo.firstRangeID;
        //firstRangeID = [NSString stringWithFormat:@"%ld",indexPath.row];
        secondRangeID = rangeVo.secondRangeID;
        thirdRangeName = rangeVo.thirdRangeName;
        thirdRangeNameInEnglish = rangeVo.thirdRangeNameInEnglish;
        //判断字符串暂时不存在
        firstRangeID = [self judgeStringIsNull:firstRangeID];
        secondRangeID = [self judgeStringIsNull:secondRangeID];
        thirdRangeName = [self judgeStringIsNull:thirdRangeName];
        thirdRangeNameInEnglish = [self judgeStringIsNull:thirdRangeNameInEnglish];
        
    }

    [cell.equipmentNumber sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:firstRangeID mark:1];
    cell.equipmentNumber.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentNumber.layer.borderWidth = 0.5;
    cell.equipmentNumber.numberOfLines = 0;
//    [cell.equipmentNumber size]
    [cell.equipmentTime sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:secondRangeID mark:1];
    cell.equipmentTime.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentTime.layer.borderWidth = 0.5;
    cell.equipmentTime.numberOfLines = 0;
    
    [cell.equipment sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:thirdRangeName mark:1];
    cell.equipment.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipment.layer.borderWidth = 0.5;
    cell.equipment.numberOfLines = 0;
    
    [cell.equipmentDescribe sizeWithfont:15 color:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter text:thirdRangeNameInEnglish mark:1];
    cell.equipmentDescribe.layer.borderColor = [UIColor grayColor].CGColor;
    cell.equipmentDescribe.layer.borderWidth = 0.5;
    cell.equipmentDescribe.numberOfLines = 0;
    
    return cell;
}
/*
//#pragma mark - 选择时间
//-(void)clickChooseTime:(UIButton*)button{
//    
//    if (button.tag == 1000) {
//        
//        if (!_timePickerStart) {
//            _timePickerStart = [[GFDatePickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//            [_timePickerStart setDelegate:self];
//        }
//        [self.view addSubview:_timePickerStart];
//        [_timePickerStart show];
//    } else {
//        
//        if (!_timePickerEnd) {
//            _timePickerEnd = [[GFDatePickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//            [_timePickerEnd setDelegate:self];
//        }
//        [self.view addSubview:_timePickerEnd];
//        [_timePickerEnd show];
//    }
//    
//}

//
//// 选择时间的代理
//- (void)datePicker:(GFDatePickerView *)datePicker didFinishPickingDate:(NSDate *)date {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString = [dateFormatter stringFromDate:date];
//    if (datePicker == _timePickerStart) {
//        
//        _timeFormLabel.text = dateString;
//        //开始时间
//        _mStartTime = dateString;
//
//    } else {
//        
//        _timeToLabel.text = dateString;
//        //结束时间
//        _mEndTime = dateString;
//    }
//}
//
//#pragma mark - 查询时间
//-(void)clickChooseUnit{
//
//    //时间大小对比
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *dateStart = [dateFormatter dateFromString:_mStartTime];
//    NSDate *dateEnd = [dateFormatter dateFromString:_mEndTime];
//    NSComparisonResult result = [dateStart compare:dateEnd];
//    if (result == NSOrderedDescending) {
//
//        [self showNoticeHudWithTitle:(@"my_log_prompt2", nil) subtitle:(@"my_log_prompt2", nil) onView:self.navigationController.view inDuration:2];
//        return;
//    }
//
//    _page = @"1";
//
//    [self requestData];
//}
*/
#pragma mark - 数据请求
-(void)requestData{
    [GFTradeDao ID:@"12" block:^(NSMutableArray *numberVo, NSError *error) {
        switch (1) {
            case 1:
            {

                if ([_page isEqualToString:@"1"]) {

                    if (numberVo.count == 0) {
                        //没有使用记录
                        //[self showNoticeHudWithTitle:(@"my_log_prompt1", nil) subtitle:(@"my_log_prompt1", nil) onView:self.view inDuration:1.5];

                        [_mTableView.mj_footer endRefreshingWithNoMoreData];
                    } else {

                        [_mTableView.mj_footer endRefreshing];
                    }

                    _mDatas = numberVo;

                } else {

                    if (numberVo.count == 0) {

                        [_mTableView.mj_footer endRefreshingWithNoMoreData];
                    } else {

                        for (GFTradeVo* vo in numberVo) {

                            [_mDatas addObject:vo];
                        }
                        [_mTableView.mj_footer endRefreshing];
                    }

                }

                [_mTableView reloadData];
            }
                break;

        }
 }];

}
//请求列表页脚刷新
-(void)requestListFooterRefresh {
    
    NSInteger num = [_page integerValue];
    num += 1;
    _page = [NSString stringWithFormat:@"%ld",(long)num];
    [self requestData];
}
#pragma mark -按钮操作emptyContent、inquire
-(void)emptyContent{
    [_input_text setText:nil];
}



#pragma mark -执行不同的搜索事件
/**
 *  执行【商品类别】搜索
 */
- (void)actionCommodityStyleSearch {
    [self hideInput];
    [_datas removeAllObjects];
    NSString *searchString = [_input_text text];
    if (![searchString isEqualToString:@""]) {
        _datas = [GFRangeStyleResultDao searchDataByName:searchString];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"请先输入您所要查找的内容！"];
    }
    //_mark = 0;
    [_mTableView reloadData];
}
/**
 *  跳转到商品分类表
 */
-(void)actionTurnTostyleTable{
    GFRangeRootViewController *range = [[GFRangeRootViewController alloc] init];
    //range.dataResultDelegate = self;
    [range setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:range animated:YES];
}

/**
 *  执行【图形要素】搜索
 */
//- (void)actionCommodityStyleSearch {
//    [self hideInput];
//    [_datas removeAllObjects];
//    NSString *searchString = [_nameInput text];
//    if (![searchString isEqualToString:@""]) {
//        _datas = [GFRangeDao searchDataByName:searchString];
//    }
//    _mark = 0;
//    [_tableView reloadData];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //隐藏背景色
    //[self.navigationController.navigationBar setValue:@100 forKeyPath:@"backgroundView.alpha"];
}
// 输入的回车键键
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self actionCommodityStyleSearch];
    [textField endEditing:YES];
    return YES;
}
 //判断字符串暂时不存在
-(NSString *)judgeStringIsNull:(NSString *)str{
    //if ([str isEqualToString:@""]) {
    if (str == NULL) {
            
        str = @"等待更新...";
    }
    return str;
}
/**
 *  隐藏键盘
 */
- (void)hideInput {
    [_input_text endEditing:YES];
}

@end
