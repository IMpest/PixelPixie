
#define TIMEZONE_WIDTH 312
#define TIMEZONE_HEIGHT 14

#define TIMELINE_WIDTH 308
#define TIMELINE_HEIGHT 14

#define TIMELINE_LEFT ((TIMEZONE_WIDTH-TIMELINE_WIDTH)/2)

#import <SpriteKit/SpriteKit.h>

@interface PPTimeNode : SKSpriteNode

@property (nonatomic, assign) NSDate * time;

-(id)initWithTimeMax:(NSTimeInterval)timeInit;

-(void)addTime:(NSTimeInterval)time;

-(NSTimeInterval)refreshCurrentTime;

@end
