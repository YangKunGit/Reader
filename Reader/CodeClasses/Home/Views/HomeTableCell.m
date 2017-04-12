//
//  HomeTableCell.m
//  Reader
//
//  Created by YK on 2017/4/10.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "HomeTableCell.h"
#import "BookModel.h"

@interface HomeTableCell ()

@property (nonatomic, strong) UIImageView *bgImageIView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *updataLabel;
@property (nonatomic, strong) UILabel *progressLabel;

@end

@implementation HomeTableCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, self.height - 20)];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgImageView.clipsToBounds = YES;
        [self.contentView addSubview:bgImageView];
        self.bgImageIView = bgImageView;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(bgImageView.right + 10, 0, self.width - 60, 20)];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *updataLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + 10, nameLabel.width, 20)];
        updataLabel.font = [UIFont systemFontOfSize:13];
        updataLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:updataLabel];
        self.updataLabel = updataLabel;
        
        UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, updataLabel.bottom + 10, nameLabel.width, 20)];
        progressLabel.font = [UIFont systemFontOfSize:13];
        progressLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:progressLabel];
        self.progressLabel = progressLabel;
        
        
//        self.backgroundColor = [UIColor redColor];
//        self.bgImageIView.backgroundColor = [UIColor blueColor];
//        self.nameLabel.backgroundColor = [UIColor yellowColor];
//        self.updataLabel.backgroundColor = [UIColor cyanColor];
//        self.progressLabel.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)showDataWithModel:(BookModel *)model {
    if ([model.imageUrl  isEqual: @""] || model.imageUrl == nil) {
        self.bgImageIView.image = [UIImage imageNamed:@"book-bg1.jpg"];
    } else {
        [self.bgImageIView sd_setImageWithURL: [NSURL URLWithString:model.imageUrl]];
    }
    self.nameLabel.text = model.name;
    self.updataLabel.text = model.updataText;
    self.progressLabel.text = model.progressText;
}
@end
