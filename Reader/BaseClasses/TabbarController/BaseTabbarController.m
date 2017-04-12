//
//  BaseTabbarController.m
//  Reader
//
//  Created by YK on 2017/4/6.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "BookMallViewController.h"
#import "FindViewController.h"
#import "ZoneViewController.h"
#import "MineViewController.h"

#import <RESideMenu/RESideMenu.h>

@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildVC:homeVC title:@"书架" image:@"tabbar-home" highlightImage:@"tabbar-home"];
    BookMallViewController *bookMallVC = [[BookMallViewController alloc] init];
    [self addChildVC:bookMallVC title:@"精选" image:@"tabbar-bookmall" highlightImage:@"tabbar-bookmall"];
    ZoneViewController *zoneVC = [[ZoneViewController alloc] init];
    [self addChildVC:zoneVC title:@"书库" image:@"tabbar-zone" highlightImage:@"tabbar-zone"];
    FindViewController *findVC = [[FindViewController alloc] init];
    [self addChildVC:findVC title:@"发现" image:@"tabbar-find" highlightImage:@"tabbar-find"];
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image highlightImage:(NSString *)highlightImage {
    BaseNavigationController *navigationVC = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    MineViewController *mineVC = [[MineViewController alloc] init];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:navigationVC leftMenuViewController:mineVC rightMenuViewController:nil];
    sideMenu.tabBarItem.image = [[UIImage imageNamed:image] scaleToSize:CGSizeMake(25, 25)];
    sideMenu.tabBarItem.selectedImage = [[UIImage imageNamed: highlightImage] scaleToSize:CGSizeMake(25, 25)];
    sideMenu.title = title;
    sideMenu.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenu.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//    sideMenu.delegate = self;
    sideMenu.contentViewShadowColor = [UIColor blackColor];
    sideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenu.contentViewShadowOpacity = 0.6;
    sideMenu.contentViewShadowRadius = 12;
    sideMenu.contentViewShadowEnabled = YES;
    [self addChildViewController:sideMenu];
}

@end
