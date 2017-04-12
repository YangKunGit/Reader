//
//  HomeCollectionLayout.m
//  Reader
//
//  Created by YK on 2017/4/9.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "HomeCollectionLayout.h"

@implementation HomeCollectionLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
//     水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置内边距
    self.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
