
#import "PPPixieNode.h"

@implementation PPPixieNode

-(id)initWithPixie:(PPPixie *)pixie
{
    if (self = [super init])
    {
        self.size = CGSizeMake(BLOCK_WIDTH, BLOCK_HEIGHT);
        self.anchorPoint = CGPointMake(0.0f, 0.0f);
        self.color = [UIColor grayColor];
        self.pixie = pixie;
        
        [self refresh];
    }
    return self;
}

// 更新图像
-(void)refresh
{
    self.alpha = 1.0f;
    NSString * imageName = [PPDataUtil getPicByPixie:_pixie AndNumber:0];
    self.texture = [SKTexture textureWithImageNamed:imageName];
    
    [self runAction:[PPNodeUtil getActionByPixie:_pixie]];
}

-(void)clean
{
    self.alpha = 0.0f;
}

@end
