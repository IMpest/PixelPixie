
#import "PPTimeNode.h"

@interface PPTimeNode()
{
    NSDate * startTime;
    NSDate * endTime;
    
    SKSpriteNode * maskNode;
    SKSpriteNode * backNode;
    SKCropNode * cropNode;
}

@property (nonatomic, assign) BOOL isFired;
@property (nonatomic, assign) NSTimeInterval timeMax;
@property (nonatomic, assign) NSTimeInterval timeLeft;
@end

@implementation PPTimeNode

-(id)initWithTimeMax:(NSTimeInterval)timeMax
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
        
        _isFired = NO;
        _timeMax = timeMax;
        _timeLeft = timeMax;
    }
    return self;
}

-(void)startTimer
{
    _isFired = YES;
    [self resumeTimer];
}

-(void)resumeTimer
{
    _isFired = YES;
    startTime = [NSDate date];
    endTime = [NSDate dateWithTimeInterval:_timeLeft sinceDate:startTime];
    [self refreshCurrentTime];
}

-(void)pauseTimer
{
    _isFired = NO;
}

-(void)stopTimer
{
    _isFired = NO;
}

-(void)addTime:(NSTimeInterval)addSeconds
{
    NSDate * targetTime = [NSDate dateWithTimeInterval:addSeconds sinceDate:endTime];
    endTime = [targetTime earlierDate:[NSDate dateWithTimeInterval:_timeMax sinceDate:startTime]];
}

-(NSTimeInterval)refreshCurrentTime
{
    if (_isFired)
    {
        _timeLeft = [endTime timeIntervalSinceDate:[NSDate date]];
    }
    [self refreshUI:_timeLeft / _timeMax];
    return _timeLeft;
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
