//
//  HomeViewController.m
//  Reader
//
//  Created by YK on 2017/4/6.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "HomeViewController.h"
#import <RESideMenu/RESideMenu.h>
#import "HomeCollectionLayout.h"
#import "BookModel.h"
#import "HomeCollectionCell.h"
#import "HomeTableCell.h"
#import "ShadeView.h"
//#import "LSYReadPageViewController.h"


@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, ShadeViewDelegate>

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) ShadeView *shadeView; //  下拉菜单
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isTable;

@end

static NSString *collectionCell = @"collectionCell";
static NSString *tableCell = @"tableCell";
static NSString *headerViewIdentifier = @"headerViewIdentifier";
@implementation HomeViewController

#pragma mark - 懒加载
- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[HomeCollectionLayout alloc] init];
        CGFloat width = (kScreenW - 20 * 4) / 3;
        flowLayout.itemSize = CGSizeMake(width, 150);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -64, kScreenW, self.view.height + 64) collectionViewLayout: flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:collectionCell];
        [collectionView registerClass:[HomeTableCell class] forCellWithReuseIdentifier:tableCell];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
        self.mainCollectionView = collectionView;
    }
    return _mainCollectionView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            BookModel *model = [[BookModel alloc] init];
            model.imageUrl = @"";
            model.name = @"斗破苍穹";
            model.updataText = @"第123章: 何人来战";
            model.progressText = [NSString stringWithFormat:@"进度: 第%d章", i];
            [array addObject:model];
        }
        self.dataSource = array;
    }
    return _dataSource;
}

- (BOOL)isTable {
    if (!_isTable) {
        self.isTable = NO;
    }
    return _isTable;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UI设置
- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:0.45 green:0.77 blue:0.98 alpha:1.00];
    
    [self setupNavigationItme];
    
    [self.view addSubview:self.mainCollectionView];
    
    ShadeView *shadeView = [[ShadeView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:shadeView];
    shadeView.delegate = self;
    self.shadeView = shadeView;
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
    [leftBtn addTarget:self action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
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
    [menuBtn addTarget:self action:@selector(openMenuList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[menuItem, searchItem];
}

- (RESideMenu *)sideMenuViewController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[RESideMenu class]]) {
            return (RESideMenu *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

#pragma mark - target action
- (void)openLeftMenu {
    [[self sideMenuViewController] presentLeftMenuViewController];
}

- (void)openMenuList {
    self.shadeView.isShow = YES;
}

- (void)changeLayout {
    __weak typeof(HomeViewController *) wekSelf = self;
    //  更改layout.itemSize
    HomeCollectionLayout *layout = [[HomeCollectionLayout alloc] init];
    if (self.isTable) {
        CGFloat width = (kScreenW - 20 * 4) / 3;
        layout.itemSize = CGSizeMake(width, 150);
        self.isTable = NO;
    } else {
        layout.itemSize = CGSizeMake(kScreenW - 40, 150);
        self.isTable = YES;
    }
    //  view的旋转动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView commitAnimations];
    //  重置界面
    [self.mainCollectionView setCollectionViewLayout:layout animated:YES completion:^(BOOL finished) {
        if (finished) {
            [wekSelf.mainCollectionView reloadData];
        }
    }];
    //  滚动到第一行
    //    NSIndexPath *firstIndex = [NSIndexPath indexPathForItem:0 inSection:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.mainCollectionView scrollToItemAtIndexPath:firstIndex atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        [self.mainCollectionView setContentOffset:CGPointMake(0, -64)];
    });
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
//    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"mdjyml"withExtension:@"txt"];
//    pageView.resourceURL = fileURL;    //文件位置
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        pageView.model = [LSYReadModel getLocalModelWithURL:fileURL];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self presentViewController:pageView animated:YES completion:nil];
//        });
//    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookModel *model = self.dataSource[indexPath.row];
    if (_isTable) {
        HomeTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tableCell forIndexPath:indexPath];
        [cell showDataWithModel:model];
        return cell;
    } else {
        HomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
        [cell showDataWithModel:model];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor colorWithRed:0.45 green:0.77 blue:0.98 alpha: 1];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenW, 200);
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        [self.navigationController.navigationBar setColor:[UIColor colorWithRed:0.32 green:0.65 blue:1.00 alpha: scrollView.contentOffset.y > 72 ? 1 : (scrollView.contentOffset.y / 72)]];
    }
}

#pragma mark - ShadeViewDelegate
- (void)didSelectCellInIndex:(NSInteger)index {
    switch (index) {
        case 0:     //  导入书籍
            break;
        case 1:     //  更改书架样式
            [self changeLayout];
            break;
        case 2:     //  书架分组
            break;
        case 3:     //  编辑书架
            break;
        default:
            break;
    }
}
@end
