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
@interface GFControlRootController ()<CCCycleScrollViewClickActionDeleage>//UITableViewDelegate,UITableViewDataSource,
@property (nonatomic, strong)CCCycleScrollView *cyclePlayView;
@property (nonatomic, strong) UIButton *inquireButton;
@end
@implementation GFControlRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.navigationItem.title = @"商标查询";
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage GF_imageWithOriginalName:@"head"] style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer)];
    
    [self cycleScrollView];
    
    
    [self setupView];
    
    //[self.view addSubview:self.tableview];
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
        make.height.equalTo(@24);
        make.width.equalTo(@4);
    }];
    
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(titleView.mas_trailing).with.offset(8);
        make.centerY.equalTo(titleView);
    }];
    //查询输入框
    UITextField *text_input = [[UITextField alloc]init];
    [self.view addSubview:text_input];
    [text_input mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-90);//右侧
        make.top.equalTo(titleView.mas_bottom).with.offset(10);
        //make.left.equalTo(titleView.mas_bottom).with.offset(20);
        //make.left.equalTo(titleView.mas_bottom).with.offset(20);
        make.height.equalTo(@40);
        //make.leading.equalTo(@200);
    }];
    //锁头🔐图标logo
    //UIImageView *passwordLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头像"]];
    //UIPickerView *seletBtn = [UIPickerView alloc]inputAssistantItem();
    //text_input.secureTextEntry = YES;                       //安全的文本输入（
    text_input.clearButtonMode = UITextFieldViewModeWhileEditing;     // 清除按钮的状态=只有在文本字段中编辑文本时，才会显示覆盖视图。
    text_input.keyboardType = UIKeyboardTypeASCIICapable;        //
    text_input.placeholder = @"请输入所要查询的商品";
    //text_input.delegate = self;
    text_input.backgroundColor = [UIColor whiteColor];
    //text_input.leftView = seletBtn;
    text_input.leftViewMode = UITextFieldViewModeAlways;
    text_input.layer.masksToBounds = YES;
    text_input.layer.cornerRadius = 4;
    text_input.layer.borderWidth = 1;
    text_input.layer.borderColor = [UIColor colorWithRed:178.0/255 green:228.0/255 blue:253.0/255 alpha:1].CGColor;
    _inquireButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_inquireButton];
    [_inquireButton mas_updateConstraints:^(MASConstraintMaker *make) {
        //make.leading.equalTo(self.view).with.offset(10);//左侧
        make.trailing.equalTo(self.view).with.offset(-10);//右侧
        make.top.equalTo(titleView.mas_bottom).with.offset(10);//在titleView下面位置：10
        make.leading.equalTo(text_input.mas_trailing).with.offset(8);//距离左侧的text_input：8位置
        make.height.equalTo(@40);
    }];
    [text_input setTextColor:[UIColor  lightGrayColor]];
    [text_input setClearsOnBeginEditing:true];
    [_inquireButton setTitle:@"查询🍵" forState:UIControlStateNormal];
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
-(void)inquire{
    [SVProgressHUD showSuccessWithStatus:@"点击了查询按钮！"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏背景色
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    
//[navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
