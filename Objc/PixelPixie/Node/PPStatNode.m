
#import "PPStatNode.h"

@implementation PPStatNode

SKScene * parentScene; // used for jump scene
PPSpriteButton * btAgain, * bt2Menu;

- (instancetype)initWithScene:(SKScene *)scene Data:(PPData *)data {
    if (self = [super init]) {
        parentScene = scene;
        
        self.size = CGSizeMake(240, 360);
        self.color = [UIColor whiteColor];
        
        btAgain = [PPSpriteButton buttonWithColor:[UIColor redColor] andSize:CGSizeMake(100, 50)];
        btAgain.position = CGPointMake(50, -70);
        [btAgain setLabelWithText:@"AGAIN" withColor:[UIColor whiteColor]];
        [btAgain addTarget:self selector:@selector(clickAgain) withObject:nil forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:btAgain];
        
        bt2Menu = [PPSpriteButton buttonWithColor:[UIColor blueColor] andSize:CGSizeMake(100, 50)];
        bt2Menu.position = CGPointMake(-50, -70);
        [bt2Menu setLabelWithText:@"MENU" withColor:[UIColor whiteColor]];
        [bt2Menu addTarget:self selector:@selector(click2Menu) withObject:nil forControlEvent:PPButtonControlEventTouchUpInside];
        [self addChild:bt2Menu];
    }
    return self;
}

- (void)click2Menu {
    [PPSceneManager jumpFrom:parentScene to:[PPSceneManager getStartScene]];
}

- (void)clickAgain {
    [PPSceneManager jumpFrom:parentScene to:[PPSceneManager getAnotherGameScene]];
    
}

@end
