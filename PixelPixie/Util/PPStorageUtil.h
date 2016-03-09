
#define CONST_KEY_MAX_SCORE @"max_score"
#define CONST_KEY_MAX_COMBO @"max_combo"

#import <Foundation/Foundation.h>

@interface PPStorageUtil : NSObject

+(void)setIntWithKey:(NSString *)key Value:(int)value;

+(int)getIntWithKey:(NSString *)key;

@end
