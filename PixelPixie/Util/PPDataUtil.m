
#import "PPDataUtil.h"

@implementation PPDataUtil

+ (NSString *)getPicByMap:(int)map
{
    NSString * result = @"";
    
    for (int i = 0; i < 4; i++)
    {
        int t = map % 2;
        map = map / 2;
        result = [NSString stringWithFormat:@"%@%d", result, t];
    }
    
    result = [NSString stringWithFormat:@"land_%@.png", result];
    
    //NSLog(@"%@", result);
    
    return result;
}

+ (NSString *)getPicByPixie:(PPPixie *)pixie AndNumber:(int)num
{
    NSString * result;
    
    if (pixie.status == PPStatusBall)
    {
        result = [NSString stringWithFormat:@"%@_%@_00%d.png",
                  [PPDataUtil strElement:pixie.element],
                  [PPDataUtil strStatus:pixie.status],
                  num];
    }
    else
    {
        result = [NSString stringWithFormat:@"%@_%@_%ld_%ld_00%d.png",
                  [PPDataUtil strElement:pixie.element],
                  [PPDataUtil strStatus:pixie.status],
                  MIN(pixie.levelCur, MAX_LEVEL),
                  (long)pixie.skin,
                  num];
    }
    return result;
}

+(NSString *)strElement:(Element)element
{
    switch (element)
    {
        case ElementNone:
            return @"";
        case ElementPlant:
            return @"plant";
        case ElementFire:
            return @"fire";
        case ElementWater:
            return @"water";
    }
}

+(NSString *)strStatus:(Status)status
{
    switch (status)
    {
        case PPStatusNone:
            return @"";
            
        case PPStatusStop:
            return @"stop";
            
        case PPStatusEat:
            return @"eat";
            
        case PPStatusFear:
            return @"fear";
            
        case PPStatusBall:
            return @"ball";
    }
}

@end
