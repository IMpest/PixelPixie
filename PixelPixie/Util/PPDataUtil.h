//
//  DataUtil.h
//  PixelPixie
//
//  Created by silver6wings on 15/7/2.
//  Copyright (c) 2015年 silver6wings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPDataUtil : NSObject

+ (NSString *)getPicByMap:(int)map;

+ (NSString *)getPicByPixie:(PPPixie *)pixie AndNumber:(int)num;

@end
