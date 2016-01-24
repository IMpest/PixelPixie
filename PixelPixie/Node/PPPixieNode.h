
#import <SpriteKit/SpriteKit.h>

@class PPPixie;

@interface PPPixieNode : SKSpriteNode

-(id)initWithPixie:(PPPixie *)pixie;

-(void)refreshByPixie:(PPPixie *)pixie;

-(void)clean;

@end
