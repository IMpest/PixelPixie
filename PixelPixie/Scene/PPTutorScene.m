
#import "PPTutorScene.h"

@implementation PPTutorScene

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
        self.backgroundColor = [UIColor yellowColor];
        
        SKSpriteNode * backNode = [[SKSpriteNode alloc] initWithColor:[UIColor grayColor] size:self.size];
        backNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:backNode];
        
        PPSpriteButton * btReady = [PPSpriteButton buttonWithColor:[UIColor blackColor] andSize:CGSizeMake(300, 100)];
        btReady.position = CGPointMake(100, 100);
        [btReady setLabelWithText:@"READY!" withColor:[UIColor whiteColor]];
        [btReady addTarget:self selector:@selector(btnDown) withObject:nil forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:btReady];
    }
    return self;
}

-(void)btnDown
{
    [PPSceneManager jumpFrom:self To:[PPSceneManager getAnotherGameScene]];
}
    
@end
