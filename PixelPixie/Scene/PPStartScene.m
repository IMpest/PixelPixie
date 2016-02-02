//
//  StartScene.m
//  PixelPixie
//
//  Created by silver6wings on 15/7/16.
//  Copyright (c) 2015年 silver6wings. All rights reserved.
//

#import "PPStartScene.h"

@interface PPStartScene ()
{
    SKSpriteNode * node;
}

@end

@implementation PPStartScene

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
        
        node = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:self.frame.size];
        node.position = CGPointMake(0, 0);
        node.anchorPoint = CGPointMake(0, 0);
        [self addChild:node];
        [self play];
        
    }
    return self;
}

-(void)play
{
    [node runAction:[self getBackActionFrom:0 To:52] completion:^
        {
            [self showMenu];
        }];
}

-(void)showMenu
{
    SKAction * back = [SKAction repeatAction:[self getBackActionFrom:36 To:52] count:3];
    [node runAction:back];
    
    
}

-(SKAction *)getBackActionFrom:(int)beginFrame To:(int)endFrame
{
    
    NSMutableArray * textureArray = [NSMutableArray array];
    for (int i = beginFrame; i < endFrame - 1; i++)
    {
        NSString * name = [NSString stringWithFormat:@"loading_%d",i];
        SKTexture * texture = [SKTexture textureWithImageNamed:name];
        [textureArray addObject:texture];
    }
    
    SKAction * tAction = [SKAction animateWithTextures:textureArray timePerFrame:FRAME_SPEED resize:NO restore:NO];
    return tAction;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKTransition * fade = [SKTransition fadeWithDuration:1];
    [self.view presentScene:[PPSceneManager getTutorScene] transition:fade];
}

@end
