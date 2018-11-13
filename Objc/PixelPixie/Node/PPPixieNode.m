
#import "PPPixieNode.h"

@implementation PPPixieNode

- (id)initWithPixie:(PPPixie *)pixie {
    if (self = [super init]) {
        self.size = CGSizeMake(BLOCK_WIDTH, BLOCK_HEIGHT);
        self.anchorPoint = CGPointMake(0.0f, 0.0f);
        self.color = [UIColor grayColor];
        
        [self refreshByPixie:pixie];
    }
    return self;
}

// 更新图像
- (void)refreshByPixie:(PPPixie *)pixie {
    self.alpha = 1.0f;
    NSString * imageName = [PPDataUtil getPicByPixie:pixie AndNumber:0];
    self.texture = [SKTexture textureWithImageNamed:imageName];
    
    [self runAction:[PPNodeUtil getActionByPixie:pixie]];
}

- (void)clean {
    self.alpha = 0.0f;
}

@end
