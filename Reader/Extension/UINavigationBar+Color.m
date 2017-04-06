//
//  UINavigationBar+Color.m
//  Reader
//
//  Created by YK on 2017/4/6.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "UINavigationBar+Color.h"

@implementation UINavigationBar (Color)

- (void)setColor: (UIColor *)color {
//    let navView = UIView(frame: CGRect(x: 0, y: -20, width: self.bounds.size.width, height: 64))
//    navView.backgroundColor = color
//    self.setValue(navView, forKey: "backgroundView")
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 64)];
    navView.backgroundColor = color;
    [self setValue:navView forKey:@"backgroundView"];
}

@end
