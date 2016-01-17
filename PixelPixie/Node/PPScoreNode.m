#import "PPScoreNode.h"

@implementation PPScoreNode

-(instancetype)init
{
    if (self = [super init])
    {
        self.fontName = @"Mouse";
        self.fontColor = [UIColor blackColor];
        self.fontSize = 20.0f;
    }
    return self;
}

@end
