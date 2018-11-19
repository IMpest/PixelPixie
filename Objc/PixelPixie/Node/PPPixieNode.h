
#import <SpriteKit/SpriteKit.h>

@class PPPixie;

@interface PPPixieNode : SKSpriteNode

- (instancetype)initWithPixie:(PPPixie *)pixie;

- (void)refreshByPixie:(PPPixie *)pixie;

- (void)clean;

@end
