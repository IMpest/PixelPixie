//
//  PPStorageUtil.h
//  PixelPixie
//
//  Created by silver6wings on 16/2/20.
//  Copyright © 2016年 silver6wings. All rights reserved.
//

#define CONST_KEY_MAX_SCORE @"max_score"
#define CONST_KEY_MAX_COMBO @"max_combo"

#import <Foundation/Foundation.h>

@interface PPStorageUtil : NSObject

+(void)setIntWithKey:(NSString *)key Value:(int)value;

+(int)getIntWithKey:(NSString *)key;

@end
