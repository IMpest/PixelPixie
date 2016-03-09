
#import "PPAboutScene.h"

@implementation PPAboutScene

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
        self.backgroundColor = [UIColor yellowColor];
        
        SKSpriteNode * backNode = [[SKSpriteNode alloc] initWithColor:[UIColor whiteColor] size:self.size];
        backNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:backNode];
        
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKTransition * fade = [SKTransition fadeWithDuration:1];
    [self.view presentScene:[PPSceneManager getStartScene] transition:fade];
}

@end
