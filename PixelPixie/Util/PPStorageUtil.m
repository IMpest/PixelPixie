
#import "PPStorageUtil.h"

static NSUserDefaults * userDefaults;

@implementation PPStorageUtil

+(NSUserDefaults *)getUserDefaults
{
    if (userDefaults == nil)
    {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return userDefaults;
}

+(void)setIntWithKey:(NSString *)key Value:(int)value
{
    [[self getUserDefaults] setInteger:value forKey:key];
}

+(int)getIntWithKey:(NSString *)key
{
    NSInteger result = [[self getUserDefaults] integerForKey:key];
    return result;
}

@end
