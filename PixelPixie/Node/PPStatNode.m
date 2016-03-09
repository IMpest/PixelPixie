
#import "PPStatNode.h"

@implementation PPStatNode

-(id)initWithData:(PPData *)data
{
    if (self = [super init])
    {
        self.size = CGSizeMake(240, 360);
        self.color = [UIColor whiteColor];
        
    }
    return self;
}

@end
