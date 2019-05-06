//
//  XFViewController.m
//  XFLoadingHUD
//
//  Created by 953894805@qq.com on 12/26/2018.
//  Copyright (c) 2018 953894805@qq.com. All rights reserved.
//

#import "XFViewController.h"
#import "XFLoadingHeader.h"
@interface XFViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _animates;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;
@property (nonatomic, strong) UIView * bgView;
@end

@implementation XFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];

    [XFLoadingHUD shareInstance].customDuration = 2.0;

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, XFLoadingScreenHeight - 200, XFLoadingScreenWidth, 200)];
    [self.view addSubview:_bgView];
        
//    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, XFLoadingScreenWidth - 60, 40)];
//    btn.layer.cornerRadius = 5;
//    [btn setBackgroundColor:[UIColor redColor]];
//    [btn setTitle:@"请求中" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    [btn drawCircleAnimateWithWidth:20 isLeft:YES];
//    [_bgView addSubview:btn];
    
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XFLoadingScreenWidth, XFLoadingScreenHeight - 200) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _animates = @[@"XFLoadingBackgroundStyleDark",@"XFLoadingBackgroundStyleLight",@"XFLoadingBackgroundStyleNone",@"XFLoadingGraphAnimateStyleCircle",@"XFLoadingGraphAnimateStyleIndicator",@"XFLoadingGraphAnimateStyleWordPath",@"XFLoadingGraphDirectionEndToEnd",@"XFLoadingGraphDirectionBegainHeader",@"头部文字",@"头部转圈",@"头部菊花"];
        _dataSources = [NSMutableArray arrayWithArray:_animates];
        _tableView.mj_header = [XFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(addData) animateStyle:XFLoadingGraphAnimateStyleWordPath];
    }
    return _tableView;
    
}

- (void)addData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_dataSources addObjectsFromArray:@[@"加数据"]];
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
    });
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"row = %ldcell",indexPath.row]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"row = %ldcell",indexPath.row]];
        NSString * str = [_dataSources objectAtIndex:indexPath.row];
        cell.textLabel.text = str;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"选择");
    
    //主题样式
    if (indexPath.row == 0) {
        [XFLoadingHUD shareInstance].themeStyle = XFLoadingBackgroundStyleDark;
    }
    if (indexPath.row == 1) {
        [XFLoadingHUD shareInstance].themeStyle = XFLoadingBackgroundStyleLight;
    }
    if (indexPath.row == 2) {
        [XFLoadingHUD shareInstance].themeStyle = XFLoadingBackgroundStyleNone;
    }
    //动画样式
    if (indexPath.row == 3) {
        [XFLoadingHUD shareInstance].animateStyle = XFLoadingGraphAnimateStyleCircle;
    }
    if (indexPath.row == 4) {
        [XFLoadingHUD shareInstance].animateStyle = XFLoadingGraphAnimateStyleIndicator;
    }
    if (indexPath.row == 5) {
        [XFLoadingHUD shareInstance].animateStyle = XFLoadingGraphAnimateStyleWordPath;
    }
    //渲染文字动画方向
    if (indexPath.row == 6) {
        [XFLoadingHUD shareInstance].animateStyle = XFLoadingGraphAnimateStyleWordPath;
        [XFLoadingHUD shareInstance].animateDirection = XFLoadingGraphDirectionEndToEnd;
    }
    if (indexPath.row == 7) {
        [XFLoadingHUD shareInstance].animateStyle = XFLoadingGraphAnimateStyleWordPath;
        [XFLoadingHUD shareInstance].animateDirection = XFLoadingGraphDirectionBegainHeader;
    }
    
    
    //更新头部刷新动画
    if (indexPath.row == 8) {
        ((XFRefreshHeader *)_tableView.mj_header).animateStyle = XFLoadingGraphAnimateStyleWordPath;
    }
    if (indexPath.row == 9) {
        ((XFRefreshHeader *)_tableView.mj_header).animateStyle = XFLoadingGraphAnimateStyleCircle;
    }
    if (indexPath.row == 10) {
        ((XFRefreshHeader *)_tableView.mj_header).animateStyle = XFLoadingGraphAnimateStyleIndicator;
    }
    
    if (indexPath.row < 8) {
        [XFLoadingHUD showInView:_bgView];
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"将要取消选择");
    
    if (indexPath.row < 8) {
        [XFLoadingHUD hide];
    }
    
    return indexPath;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"将要选择");
    if (indexPath.row < 8) {
        [XFLoadingHUD hide];
    }
    return indexPath;
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"已经取消选择");
    
}

@end
