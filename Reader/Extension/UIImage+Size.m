//
//  UIImage+Size.m
//  Reader
//
//  Created by YK on 2017/4/6.
//  Copyright © 2017年 YK. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

- (UIImage *)scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
