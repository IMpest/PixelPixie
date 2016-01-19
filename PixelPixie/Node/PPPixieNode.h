
#import <SpriteKit/SpriteKit.h>

@class PPPixie;

@interface PPPixieNode : SKSpriteNode
@property (nonatomic, strong) PPPixie * pixie;

-(id)initWithPixie:(PPPixie *)pixie;

-(void)refresh;

-(void)clean;

@end
