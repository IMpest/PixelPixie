//
//  PPStatNode.m
//  PixelPixie
//
//  Created by silver6wings on 16/2/18.
//  Copyright © 2016年 silver6wings. All rights reserved.
//

#import "PPStatNode.h"

@implementation PPStatNode

-(id)initWithData:(PPData *)data
{
    if (self = [super init])
    {
        self.size = CGSizeMake(240, 360);
        self.color = [UIColor whiteColor];
        
    }
    return self;
}

@end
