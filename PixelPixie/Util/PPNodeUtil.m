//
//  NodeUtil.m
//  PixelPixie
//
//  Created by silver6wings on 15/7/4.
//  Copyright (c) 2015年 silver6wings. All rights reserved.
//

#import "PPNodeUtil.h"

@implementation PPNodeUtil

+ (CGPoint)getNodePositionByRow:(int)row COL:(int)column
{
    return CGPointMake(column * BLOCK_WIDTH, (MAX_ROW - row - 1) * BLOCK_HEIGHT + LAND_TOP_BOTTOM);
}

+ (int)getRowByPostion:(CGPoint)pos
{
    if (pos.y < LAND_TOP_BOTTOM || pos.y > LAND_TOP_BOTTOM + MAX_ROW * BLOCK_HEIGHT) return -1;
    
    return MAX_ROW - (int)((pos.y - LAND_TOP_BOTTOM)/BLOCK_HEIGHT) - 1;
}

+ (int)getColByPostion:(CGPoint)pos
{
    if (pos.x < 0 || pos.x > 320) return -1;
    
    return (int)(pos.x/BLOCK_WIDTH);
}

+(CGPoint)getPointByRow:(int)row Col:(int)col
{
    if (row < 0 || row > MAX_ROW ||
        col < 0 || row > MAX_COLUMN)
    {
        return CGPointZero;
    }
    return CGPointMake(col * BLOCK_WIDTH, (MAX_ROW - row - 1) * BLOCK_HEIGHT + LAND_TOP_BOTTOM);
}

+ (SKAction *)getActionByPixie:(PPPixie *)pixie
{
    if (pixie == nil) return nil;
    
    NSMutableArray * textureArray = [NSMutableArray array];
    
    for (int i = 0; i < FRAME_STATUS; i++)
    {
        NSString * name = [PPDataUtil getPicByPixie:pixie AndNumber:i];
        SKTexture * textureCombo = [SKTexture textureWithImageNamed:name];
        [textureArray addObject:textureCombo];
    }
    
    SKAction * tAction = [SKAction animateWithTextures:textureArray timePerFrame:FRAME_SPEED];
    return [SKAction repeatActionForever:tAction];
}

@end
