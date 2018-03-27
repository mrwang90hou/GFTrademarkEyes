//
//  GFControlRootController.m
//  GFSlide
//
//  Created by 王宁 on 2018/3/23.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "GFControlRootController.h"
#import "UIBarButtonItem+SXCreate.h"
#import "CCCycleScrollView.h"
#import "StyleTableController.h"
#import "StyleResultViewController.h"
@interface GFControlRootController ()<CCCycleScrollViewClickActionDeleage,UIPickerViewDataSource,UIPickerViewDelegate>//UITableViewDelegate,UITableViewDataSource,
@property (nonatomic, strong)CCCycleScrollView *cyclePlayView;
@property (nonatomic, strong) UIButton *inquireButton;
@property (nonatomic,strong)UITextField *text_input;
@property GFBasicController *nextVC;

@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)UIButton * style_btn;
@property (nonatomic,strong)NSArray * selection;//选项
@property (nonatomic,strong)NSArray * number;//保存数字

@end
@implementation GFControlRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.navigationItem.title = @"商标查询";
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage GF_imageWithOriginalName:@"head"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
    
    [self cycleScrollView];
    [self setupView];
    //获取需要展示的数据
    [self loadData];
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(Device_Width/4, Device_Height/4, self.view.bounds.size.width/2, 80)];
//    [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
//
////        make.top.equalTo(@[[NSNumber numberWithFloat:(Device_Height / 3*1)]]);
////        make.height.equalTo(@200);
//        make.centerX.equalTo(self.view);
//
//    }];
    //    self.pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_pickerView];
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    //商品分类表按钮
    _style_btn = [[UIButton alloc]initWithFrame:CGRectMake(Device_Width/4*3+30, Device_Height/4+27, 30 , 30)];
    [_style_btn setImage:[UIImage imageNamed:@"商品分类表"] forState:UIControlStateNormal];
    [self.view addSubview:_style_btn];
    [_style_btn addTarget:self action:@selector(openTable) forControlEvents:UIControlEventTouchUpInside];
    [_style_btn setHidden:true];
}
#pragma mark 加载数据
-(void)loadData {
    //需要展示的数据以数组的形式保存
    self.selection = @[@"商标查询",@"商标驳回查询",@"商品分类查询"];
    self.number = @[@"111",@"222",@"333",@"444"];
}

#pragma mark UIPickerView DataSource Method
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.selection.count;
            break;
        case 1:
            result = self.number.count;
            break;
        default:
            break;
    }
    return result;
}
#pragma mark UIPickerView Delegate Method
//指定每行如何展示数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.selection[row];
            break;
        case 1:
            title = self.number[row];
            break;
        default:
            break;
    }
    return title;
}
//选择事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (row) {
        case 0:
            _text_input.placeholder = @"请输入您要查询的商标名称或者申请号";
            _style_btn.hidden = true;
            break;
        case 1:
            _text_input.placeholder  = @"请输入注册人/国家/城市/代理机构";
            _style_btn.hidden = true;
            break;
        case 2:
            _text_input.placeholder  = @"请输入类似群、商品中/英文";
            _style_btn.hidden = false;
            break;
        default:
            break;
    }
    //return title;
}


-(void)setupView{
    //设计查询操作
    UIView *adView = [UIView new];
    [self.view addSubview:adView];
    
    [adView setHidden:true];
    //[adView setBackgroundColor:[UIColor greenColor]];
    [adView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo([NSNumber numberWithFloat:(Device_Height / 3*1)]);
    }];
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
    [titleView setHidden:true];
    //[titleView setBackgroundColor:[UIColor blueColor]];
    [titleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(8);
        make.top.equalTo(adView.mas_bottom).with.offset(16);
        //make.right.equalTo(self.view).with.offset(4);
        make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-10);//右侧
        
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"商标查询";
    [self.view addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).with.offset(-20);
        //make.centerY.equalTo(titleView);
        make.centerX.equalTo(titleView);
        
    }];
    titleLabel.hidden = true;
    //************设置选择器*************//
    
    //************设置选择器*************//

    //查询输入框
    _text_input = [[UITextField alloc]init];
    [self.view addSubview:_text_input];
    [_text_input mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-90);//右侧
        make.top.equalTo(titleView.mas_bottom).with.offset(10);
        //make.left.equalTo(titleView.mas_bottom).with.offset(20);
        //make.left.equalTo(titleView.mas_bottom).with.offset(20);
        make.height.equalTo(@40);
        //make.leading.equalTo(@200);
    }];
    //搜索🔍logo
    UIImageView *search_btn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_search_normal"]];
    _text_input.clearButtonMode = UITextFieldViewModeWhileEditing;     // 清除按钮的状态=只有在文本字段中编辑文本时，才会显示覆盖视图。
    //_text_input.keyboardType = UIKeyboardTypeASCIICapable;        //限制英文输入
    _text_input.placeholder = @"请输入您要查询的商标名称或者申请号";
    //[_text_input setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_text_input setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    //text_input.delegate = self;
    _text_input.backgroundColor = [UIColor whiteColor];
    _text_input.leftView = search_btn;
    _text_input.leftViewMode = UITextFieldViewModeAlways;
    _text_input.layer.masksToBounds = YES;
    _text_input.layer.cornerRadius = 4;
    _text_input.layer.borderWidth = 1;
    _text_input.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    _inquireButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_inquireButton];
    [_inquireButton mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-10);//右侧
        make.top.equalTo(titleView.mas_bottom).with.offset(10);//在titleView下面位置：10
        make.leading.equalTo(_text_input.mas_trailing).with.offset(8);//距离左侧的text_input：8位置
        make.height.equalTo(@40);
    }];
    [_text_input setTextColor:[UIColor  blackColor]];
    //[_text_input setClearsOnBeginEditing:true];
    [_inquireButton setTitle:@"查询🕵🏻‍♀️" forState:UIControlStateNormal];
    //[inquireButton setTitle:@"recognition_get_trademark_album"];
    [_inquireButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[inquireButton setBackgroundImage:normalBackground forState:UIControlStateNormal];
    //[inquireButton setBackgroundImage:pressedBackground forState:UIControlStateHighlighted];
    _inquireButton.tag = 2200;
    _inquireButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _inquireButton.backgroundColor = [UIColor orangeColor];
    [_inquireButton addTarget:self action:@selector(inquire) forControlEvents:UIControlEventTouchUpInside];
    //设置边框
    _inquireButton.layer.cornerRadius = 4;
    _inquireButton.layer.borderWidth = 1;
    _inquireButton.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    //***************设置热门搜索词汇*****************8//
    
}
-(void)openDrawer{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.gfSlideVc openDrawer];
}
- (void)cycleScrollView
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 7; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"company_image%ld",(long)i]];
        [images addObject:image];
    }
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, self.view.frame.size.width, Device_Height/4)];
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images];
    //self.cyclePlayView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    self.cyclePlayView.delegate = self;
    self.cyclePlayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.cyclePlayView];
}

- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cyclePlayView.pageDescrips[clickIndex]);
    //[SVProgressHUD showSuccessWithStatus:@"点击了第个图片:%@",self.cyclePlayView.pageDescrips[clickIndex]];
    [SVProgressHUD showSuccessWithStatus:@"点击了图片"];
    //跳转事件！
}
//查询事件
-(void)inquire{
    [SVProgressHUD showSuccessWithStatus:@"点击了查询按钮！"];
    if (_text_input!=nil) {
        
        
//        //方式一
//        _nextVC = [[StyleResultViewController alloc]init];
//        UINavigationController *nView = [[UINavigationController alloc]initWithRootViewController:_nextVC];
//        //设置翻转动画
//        _nextVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;       //【水平翻转】
//        //nextVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;        //【闪现】
//        //nextVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;          //【翻页效果】
//        //nextVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;        //【底部推进】
//        [self presentViewController:nView animated:YES completion:nil];
//
//
        //方式二

        StyleResultViewController *advanceSearch = [[StyleResultViewController alloc] init];
        //[advanceSearch setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:advanceSearch animated:YES];
        //[self.navigationController.navigationBar setValue:@100 forKeyPath:@"backgroundView.alpha"];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏背景色
    //[self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    
//[navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//打开商品分类表事件
-(void)openTable{
    [_style_btn setImage:[UIImage imageNamed:@"商品分类表-点击"] forState:UIControlStateNormal];
    [SVProgressHUD showSuccessWithStatus:@"打开商品分类表！"];
    
//
//    _nextVC = [[StyleTableController alloc]init];
////
//    UINavigationController *nView = [[UINavigationController alloc]initWithRootViewController:_nextVC];
//    //设置翻转动画
//    _nextVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;       //【水平翻转】
//    //nextVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;        //【闪现】
//    //nextVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;          //【翻页效果】
//    //nextVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;        //【底部推进】
//    [self presentViewController:nView animated:YES completion:nil];
//

  // 跳转方式二
    StyleTableController *advanceSearch = [[StyleTableController alloc] init];
    //[advanceSearch setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:advanceSearch animated:YES];
    
}
@end
