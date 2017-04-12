//
//  BookModel.h
//  Reader
//
//  Created by YK on 2017/4/10.
//  Copyright © 2017年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

@property (nonatomic, copy)NSString *imageUrl;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy) NSString *updataText;
@property (nonatomic, copy) NSString *progressText;

@end
