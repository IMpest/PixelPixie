
#import "PPTutorScene.h"

#define FRAMES_TUTORIAL 25

@interface PPTutorScene ()
{
    SKSpriteNode * node;
}
@end

@implementation PPTutorScene

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
        self.backgroundColor = [UIColor yellowColor];
        
        // 教程内容
        node = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:self.frame.size];
        node.position = CGPointMake(0, 0);
        node.anchorPoint = CGPointMake(0, 0);
        [self addChild:node];
        
        // 获取动画
        NSMutableArray * textureArray = [NSMutableArray array];
        for (int i = 0; i < FRAMES_TUTORIAL; i++)
        {
            NSString * name = [NSString stringWithFormat:@"tutorial_%02d", i];
            SKTexture * texture = [SKTexture textureWithImageNamed:name];
            [textureArray addObject:texture];
        }
        SKAction * tAction = [SKAction animateWithTextures:textureArray timePerFrame:FRAME_SPEED resize:NO restore:NO];
        [node runAction:[SKAction repeatActionForever:tAction]];
        
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

#pragma mark UIRespond

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
