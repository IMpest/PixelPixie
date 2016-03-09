
#import "PPStartScene.h"

@interface PPStartScene ()
{
    SKSpriteNode * node;
}

@end

@implementation PPStartScene

BOOL menuShown;

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
        
        node = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:self.frame.size];
        node.position = CGPointMake(0, 0);
        node.anchorPoint = CGPointMake(0, 0);
        [self addChild:node];
        [self playAction];
        
    }
    return self;
}

-(SKAction *)getBackActionFrom:(int)beginFrame To:(int)endFrame
{
    
    NSMutableArray * textureArray = [NSMutableArray array];
    for (int i = beginFrame; i <= endFrame; i++)
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
    [self showMenu];
}

-(void)playAction
{
    menuShown = NO;
    
    [node runAction:[self getBackActionFrom:0 To:35] completion:^
     {
         [self showMenu];
     }];
}

-(void)showMenu
{
    if (menuShown)
    {
        return;
    }
    
    menuShown = YES;
    
    int btnWidth = 200;
    int btnHeight = 50;
    UIColor * btnColorBack = [UIColor clearColor];
    UIColor * btnColorText = [UIColor grayColor];
    
    SKAction * back = [SKAction repeatAction:[self getBackActionFrom:36 To:52] count:3];
    [node runAction:back];
    
    PPSpriteButton * btStart = [PPSpriteButton buttonWithColor:btnColorBack andSize:CGSizeMake(btnWidth, btnHeight)];
    btStart.position = CGPointMake(GAME_AREA_WIDTH / 2, 75);
    btStart.alpha = 0;
    [btStart setLabelWithText:@"START GAME" withColor:btnColorText];
    [btStart addTarget:self selector:@selector(clickStart) withObject:nil forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:btStart];
    
    PPSpriteButton * btTutor = [PPSpriteButton buttonWithColor:btnColorBack andSize:CGSizeMake(btnWidth, btnHeight)];
    btTutor.position = CGPointMake(GAME_AREA_WIDTH / 2, 425);
    btTutor.alpha = 0;
    [btTutor setLabelWithText:@"TUTORIAL" withColor:btnColorText];
    [btTutor addTarget:self selector:@selector(clickTutor) withObject:nil forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:btTutor];
    
    PPSpriteButton * btAbout = [PPSpriteButton buttonWithColor:btnColorBack andSize:CGSizeMake(btnWidth, btnHeight)];
    btAbout.position = CGPointMake(GAME_AREA_WIDTH / 2, 500);
    btAbout.alpha = 0;
    [btAbout setLabelWithText:@"ABOUT US" withColor:btnColorText];
    [btAbout addTarget:self selector:@selector(clickAbout) withObject:nil forControlEvent:PPButtonControlEventTouchUpInside];
    [self addChild:btAbout];
    
    SKAction * action1 = [SKAction sequence:@[[SKAction waitForDuration:0.1f],[SKAction fadeInWithDuration:0.5f]]];
    [btStart runAction:action1];
    
    SKAction * action2 = [SKAction sequence:@[[SKAction waitForDuration:0.3f],[SKAction fadeInWithDuration:0.5f]]];
    [btTutor runAction:action2];
    
    SKAction * action3 = [SKAction sequence:@[[SKAction waitForDuration:0.5f],[SKAction fadeInWithDuration:0.5f]]];
    [btAbout runAction:action3];
}

-(void)clickStart
{
    [PPSceneManager jumpFrom:self To:[PPSceneManager getTutorScene]];
}

-(void)clickTutor
{
    [PPSceneManager jumpFrom:self To:[PPSceneManager getTutorScene]];
}

-(void)clickAbout
{
    [PPSceneManager jumpFrom:self To:[PPSceneManager getAboutScene]];
}

@end
