
#import <SpriteKit/SpriteKit.h>

@interface PPTimeNode : SKSpriteNode

@property (nonatomic, assign) NSDate * time;

-(id)initWithTimeMax:(NSTimeInterval)timeMax;

-(void)startTimer;

-(void)resumeTimer;

-(void)pauseTimer;

-(void)stopTimer;

-(void)addTime:(NSTimeInterval)time;

-(NSTimeInterval)refreshCurrentTime;

@end
