//
//  HomeCollCollectionCell.m
//  Reader
//
//  Created by YK on 2017/4/10.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "HomeCollectionCell.h"
#import "BookModel.h"


@interface HomeCollectionCell ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation HomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 30)];
        bgImage.contentMode = UIViewContentModeScaleAspectFill;
        bgImage.clipsToBounds = YES;
        [self.contentView addSubview:bgImage];
        self.bgImageView = bgImage;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bgImage.bottom + 5, self.width, 25)];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.numberOfLines = 2;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
    }
    return self;
}

- (void)showDataWithModel: (BookModel *)model {
    if ([model.imageUrl  isEqual: @""] || model.imageUrl == nil) {
        self.bgImageView.image = [UIImage imageNamed:@"book-bg1.jpg"];
    } else {
         [self.bgImageView sd_setImageWithURL: [NSURL URLWithString:model.imageUrl]];
    }
    self.nameLabel.text = model.name;
}


@end
