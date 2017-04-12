//
//  ShadeView.h
//  Reader
//
//  Created by YK on 2017/4/12.
//  Copyright © 2017年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShadeViewDelegate <NSObject>

- (void)didSelectCellInIndex: (NSInteger)index;

@end

@interface ShadeView : UIView

@property (nonatomic, assign)BOOL isShow;

@property (nonatomic, assign) id<ShadeViewDelegate> delegate;

@end
