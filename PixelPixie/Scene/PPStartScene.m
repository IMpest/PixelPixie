//
//  PPStartScene.m
//  PixelPixie
//
//  Created by silver6wings on 16/1/31.
//  Copyright © 2016年 silver6wings. All rights reserved.
//

#import "PPStartScene.h"

@implementation PPStartScene

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
        self.backgroundColor = [UIColor yellowColor];
        
        SKSpriteNode * backNode = [[SKSpriteNode alloc] initWithColor:[UIColor grayColor] size:self.size];
        backNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:backNode];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKTransition * reveal = [SKTransition fadeWithDuration:1];
    [self.view presentScene:[PPSceneManager getGameScene] transition:reveal];
}
    
@end
