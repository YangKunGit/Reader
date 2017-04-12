//
//  MineViewController.m
//  Reader
//
//  Created by YK on 2017/4/6.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

static NSString *cellIdentifier = @"cell";
@implementation MineViewController

#pragma mark - 懒加载
- (UITableView *)myTableView {
    if (_myTableView == nil) {
        UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, self.view.width, _footerView.top - _headerView.bottom) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.opaque = NO;
        myTableView.backgroundColor = [UIColor clearColor];
        myTableView.backgroundView = nil;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableView.bounces = NO;
        [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        self.myTableView = myTableView;
    }
    return _myTableView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray arrayWithObjects:
                           @{@"title": @"我的账户", @"image": @"side-account"},
                           @{@"title": @"我的包月", @"image": @"side-book"},
                           @{@"title": @"我的基因", @"image": @"side-dna"},
                           @{@"title": @"我的消息", @"image": @"side-message"},
                           @{@"title": @"浏览历史", @"image": @"side-history"}, nil];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

//  初始化界面
- (void)setupUI {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, 100)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    //  头像
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 36, 36)];
    iconImageView.image = [[UIImage imageNamed:@"home-usr"] scaleToSize:CGSizeMake(25, 25)];
    iconImageView.contentMode = UIViewContentModeCenter;
    iconImageView.backgroundColor = [UIColor whiteColor];
    iconImageView.layer.cornerRadius = 18;
    iconImageView.clipsToBounds = YES;
    [headerView addSubview:iconImageView];
    //  用户名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.right + 15, iconImageView.top, 150, 20)];
    nameLabel.text = @"游客A33JE";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    [headerView addSubview:nameLabel];
    //  提示
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + 5, 150, 20)];
    tipLabel.text = @"QQ登录, 记录阅读点滴";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:tipLabel];

    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    //  底部区域
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 120, self.view.width, 100)];
    //  设置按钮
    UIButton *setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setupBtn.frame = CGRectMake(20, 20, 80, 25);
    [setupBtn setImage:[UIImage imageNamed: @"side-setup"] forState:UIControlStateNormal];
    [setupBtn setTitle:@"设置" forState:UIControlStateNormal];
    [footerView addSubview:setupBtn];
    
    //  夜晚模式切换
    UIButton *darkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    darkBtn.frame = CGRectMake(setupBtn.right + 30, setupBtn.top, 80, 25);
    [darkBtn setImage:[UIImage imageNamed:@"side-night"] forState:UIControlStateNormal];
    [darkBtn setTitle:@"夜间" forState:UIControlStateNormal];
    [footerView addSubview:darkBtn];
    
    [self.view addSubview:footerView];
    self.footerView = footerView;
    
    //  tableview
    [self.view addSubview: self.myTableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.textLabel.text = self.dataSource[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"image"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
