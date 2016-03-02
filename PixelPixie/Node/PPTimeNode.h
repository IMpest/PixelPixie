

#import <SpriteKit/SpriteKit.h>

@interface PPTimeNode : SKSpriteNode

@property (nonatomic, assign) NSDate * time;

-(id)initWithTimeMax:(NSTimeInterval)timeInit;

-(void)fireTimer;

-(void)pauseTimer;

-(void)addTime:(NSTimeInterval)time;

-(NSTimeInterval)refreshCurrentTime;

@end
