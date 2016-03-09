
#import "PPScoreNode.h"

@implementation PPScoreNode

-(instancetype)init
{
    if (self = [super init])
    {
        self.fontName = @"Mouse";
        self.fontColor = [UIColor blackColor];
        self.fontSize = TEXT_SIZE;
    }
    return self;
}

-(void)testFontFamily
{
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
}

@end
