//
//  HomeTableCell.h
//  Reader
//
//  Created by YK on 2017/4/10.
//  Copyright © 2017年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookModel;

@interface HomeTableCell : UICollectionViewCell

- (void)showDataWithModel: (BookModel *)model;

@end
