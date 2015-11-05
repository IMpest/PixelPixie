
#import "PPTimeNode.h"

@implementation PPTimeNode

-(id)initWithTimeMax:(CGFloat)timeMax
{
    if (self = [super init])
    {
        self.size = CGSizeMake(TIMEZONE_WIDTH, TIMEZONE_HEIGHT);
        self.anchorPoint = CGPointMake(0, 0);
        
        // zone
        SKSpriteNode * zoneNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_01.png"];
        zoneNode.size = CGSizeMake(TIMEZONE_WIDTH, TIMEZONE_HEIGHT);
        zoneNode.position = CGPointMake(0, 0);
        zoneNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:zoneNode];
        
        // line
        SKSpriteNode * maskNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_00.png"];
        maskNode.size = CGSizeMake(TIMELINE_WIDTH, TIMEZONE_HEIGHT);
        maskNode.anchorPoint = CGPointZero;
        
        SKSpriteNode * backNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_00.png"];
        backNode.size = CGSizeMake(TIMELINE_WIDTH, TIMEZONE_HEIGHT);
        backNode.anchorPoint = CGPointZero;
        
        SKCropNode * cropNode = [[SKCropNode alloc] init];
        cropNode.position = CGPointMake(TIMELINE_LEFT, 0);
        cropNode.maskNode = maskNode;
        [cropNode addChild:backNode];
        [self addChild:cropNode];
        
        // icon
        SKSpriteNode * iconNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_02.png"];
        iconNode.size = CGSizeMake(26, 26);
        iconNode.position = CGPointMake(20, 7);
        [self addChild:iconNode];
        
        self.timeMax = timeMax;
        [self setTime:timeMax];
    }
    return self;
}

-(void)setTime:(CGFloat)time
{
    
}

@end
