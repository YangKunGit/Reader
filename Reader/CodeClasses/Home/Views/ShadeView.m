//
//  ShadeView.m
//  Reader
//
//  Created by YK on 2017/4/12.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "ShadeView.h"

@interface ShadeView ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuView;
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@end

static NSString *menuCell = @"menuCell";
@implementation ShadeView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initShadeView");
        //  遮罩层
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuBtnAction)];
        [self addGestureRecognizer:tap];
        tap.delegate = self;
        //  下拉菜单
        UITableView *menuView = [[UITableView alloc] initWithFrame:CGRectMake(self.width - 120, 64, 120, 0)];
        menuView.backgroundColor = [UIColor whiteColor];
        menuView.delegate = self;
        menuView.dataSource = self;
        menuView.bounces = NO;
        
        [menuView registerClass:[UITableViewCell class] forCellReuseIdentifier:menuCell];
        [self addSubview: menuView];
        self.menuView = menuView;
        self.hidden = YES;
        self.isShow = NO;
    }
    return self;
}

- (NSMutableArray *)tableDataSource {
    if (!_tableDataSource) {
        NSMutableArray *mutableArr = [NSMutableArray array];
        mutableArr = [NSMutableArray arrayWithObjects:@"导入书籍", @"列表模式", @"书架分组", @"编辑书架", nil];
        self.tableDataSource = mutableArr;
    }
    return _tableDataSource;
}

- (void)setIsShow:(BOOL)isShow {
    if (isShow && self.isHidden) {
        self.hidden = NO;
        [UIView animateWithDuration:.5 animations:^{
            self.menuView.height = 160;
            self.menuView.alpha = 1;
        }];
    } else {
    }
    _isShow = isShow;
}

#pragma mark - target action
- (void)menuBtnAction {
    if (self.isShow) {
        self.menuView.layer.position = CGPointMake(self.menuView.right, self.menuView.y);
        self.menuView.layer.anchorPoint = CGPointMake(1, 0);
        [UIView animateWithDuration:.5 animations:^{
            self.menuView.height = 0;
            self.menuView.alpha = 0;
            self.menuView.transform = CGAffineTransformScale(CGAffineTransformIdentity, .1, .1);
        } completion:^(BOOL finished) {
            self.hidden = YES;
            self.isShow = NO;
            self.menuView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:     //  导入书籍
            break;
        case 1:     //  更改书架样式
            self.tableDataSource[1] = [self.tableDataSource[1] isEqualToString:@"列表模式"] ? @"书封模式" : @"列表模式";
            [self.menuView reloadData];
            [self menuBtnAction];
//            [self changeLayout];
            break;
        case 2:     //  书架分组
            break;
        case 3:     //  编辑书架
            break;
        default:
            break;
    }
    if ([_delegate respondsToSelector:@selector(didSelectCellInIndex:)]) {
        [_delegate didSelectCellInIndex: indexPath.row];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCell forIndexPath:indexPath];
    cell.textLabel.text = self.tableDataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    } else {
        return YES;
    }
}


@end
