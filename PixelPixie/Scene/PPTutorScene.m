//
//  TutorScene.m
//  PixelPixie
//
//  Created by silver6wings on 15/7/16.
//  Copyright (c) 2015年 silver6wings. All rights reserved.
//

#import "PPTutorScene.h"

@implementation PPTutorScene

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
        
        SKSpriteNode * node = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:self.frame.size];
        node.position = CGPointMake(0, 0);
        node.anchorPoint = CGPointMake(0, 0);
        [self addChild:node];
        
        NSMutableArray * textureArray = [NSMutableArray array];
        for (int i = 0; i < 53; i++)
        {
            NSString * name = [NSString stringWithFormat:@"loading_%d",i];
            SKTexture * texture = [SKTexture textureWithImageNamed:name];
            [textureArray addObject:texture];
        }
        SKAction * tAction = [SKAction animateWithTextures:textureArray timePerFrame:FRAME_SPEED resize:NO restore:NO];
        [node runAction:tAction];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view presentScene:[PPSceneManager getGameScene]];
}

@end
