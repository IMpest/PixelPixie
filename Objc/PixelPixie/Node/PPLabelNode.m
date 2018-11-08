
#import "PPLabelNode.h"

@implementation PPLabelNode

- (instancetype)init
{
    if (self = [super init])
    {
        self.fontName = TEXT_FONT;
        self.fontSize = TEXT_SIZE;
    }
    return self;
}

@end
