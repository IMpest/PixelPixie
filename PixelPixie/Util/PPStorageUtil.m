//
//  PPStorageUtil.m
//  PixelPixie
//
//  Created by silver6wings on 16/2/20.
//  Copyright © 2016年 silver6wings. All rights reserved.
//

#import "PPStorageUtil.h"

static NSUserDefaults * userDefaults;

@implementation PPStorageUtil

-(NSUserDefaults *)getUserDefaults
{
    if (userDefaults == nil)
    {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return userDefaults;
}

-(void)setIntWithKey:(NSString *)key Value:(int)value
{
    [[self getUserDefaults] setInteger:value forKey:key];
}

-(int)getIntWithKey:(NSString *)key Default:(int)def
{
    NSInteger result = [[self getUserDefaults] integerForKey:key];
    return result;
}

@end
