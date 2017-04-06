//
//  HomeViewController.m
//  Reader
//
//  Created by YK on 2017/4/6.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseTabbarController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.45 green:0.77 blue:0.98 alpha:1.00];
    
    [self setupNavigationItme];
    
    [self.navigationController.navigationBar setColor:[UIColor colorWithRed:0.45 green:0.77 blue:0.98 alpha:0]];
    
}

- (void)setupNavigationItme {
    CGRect rect = CGRectMake(0, 0, 35, 35);
    //  抽屉按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = rect;
    [leftBtn setImage:[[UIImage imageNamed:@"home-usr"] scaleToSize:CGSizeMake(25, 25)] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor whiteColor];
    leftBtn.layer.cornerRadius = 17.5;
    leftBtn.clipsToBounds = YES;
    [leftBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: leftBtn];
    
    //  搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = rect;
    [searchBtn setImage:[[UIImage imageNamed:@"home-search"] scaleToSize:CGSizeMake(25, 25)] forState:UIControlStateNormal];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    //  菜单
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = rect;
    [menuBtn setImage:[[UIImage imageNamed:@"home-menu"] scaleToSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItems = @[menuItem, searchItem];
}

- (void)openMenu {
//    BaseTabbarController *tabbar = (BaseTabbarController *)(self.tabBarController);
    [(BaseTabbarController *)self.tabBarController.sideMenu presentLeftMenuViewController];
}

@end
