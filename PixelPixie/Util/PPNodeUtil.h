//
//  NodeUtil.h
//  PixelPixie
//
//  Created by silver6wings on 15/7/4.
//  Copyright (c) 2015年 silver6wings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPNodeUtil : NSObject

+(CGPoint)getNodePositionByRow:(int)row COL:(int)column;

+(int)getRowByPostion:(CGPoint)pos;
+(int)getColByPostion:(CGPoint)pos;
+(CGPoint)getPointByRow:(int)row Col:(int)col;

+(SKAction *)getActionByPixie:(PPPixie *)pixie;

@end
