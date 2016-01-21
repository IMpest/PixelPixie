
#import "PPTimeNode.h"

@interface PPTimeNode()
{
    NSTimeInterval timeMax;
    
    NSDate * startTime;
    NSDate * endTime;
    
    SKSpriteNode * maskNode;
    SKSpriteNode * backNode;
    SKCropNode * cropNode;
}

@end

@implementation PPTimeNode

-(id)initWithTimeMax:(NSTimeInterval)timeInit
{
    if (self = [super init])
    {
        self.size = CGSizeMake(TIMEZONE_WIDTH, TIMEZONE_HEIGHT);
        self.anchorPoint = CGPointMake(0, 0);
        
        // zone
        SKSpriteNode * zoneNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_holder.png"];
        zoneNode.size = CGSizeMake(TIMEZONE_WIDTH, TIMEZONE_HEIGHT);
        zoneNode.position = CGPointMake(0, 0);
        zoneNode.anchorPoint = CGPointMake(0, 0);
        [self addChild:zoneNode];
        
        // line
        maskNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_line.png"];
        maskNode.size = CGSizeMake(TIMELINE_WIDTH, TIMEZONE_HEIGHT);
        maskNode.anchorPoint = CGPointZero;
        
        backNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_line.png"];
        backNode.size = CGSizeMake(TIMELINE_WIDTH, TIMEZONE_HEIGHT);
        backNode.anchorPoint = CGPointZero;
        
        cropNode = [[SKCropNode alloc] init];
        cropNode.position = CGPointMake(TIMELINE_LEFT, 0);
        cropNode.maskNode = maskNode;
        [cropNode addChild:backNode];
        [self addChild:cropNode];
        
        // icon
        SKSpriteNode * iconNode = [SKSpriteNode spriteNodeWithImageNamed:@"time_icon.png"];
        iconNode.size = CGSizeMake(26, 26);
        iconNode.position = CGPointMake(20, 7);
        [self addChild:iconNode];
        
        timeMax = timeInit;
    }
    return self;
}

-(void)fireTimer
{
    startTime = [NSDate date];
    endTime = [NSDate dateWithTimeInterval:timeMax sinceDate:startTime];
    [self refreshCurrentTime];
}

-(void)addTime:(NSTimeInterval)addtionalTime
{
    endTime = [NSDate dateWithTimeInterval:addtionalTime sinceDate:endTime];
}

-(NSTimeInterval)refreshCurrentTime
{
    NSTimeInterval timeLeft = [self getLeftTime];
    [self refreshUI:timeLeft / timeMax];
    return timeLeft;
}

-(NSTimeInterval)getLeftTime
{
    return [endTime timeIntervalSinceDate:[NSDate date]];
}

-(void)refreshUI:(double)percentage
{
    if (percentage > 0)
    {
        [maskNode setSize:CGSizeMake(TIMELINE_WIDTH * percentage, TIMELINE_HEIGHT)];
    }
    else
    {
        [maskNode setSize:CGSizeZero];
    }
}

@end
