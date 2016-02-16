
#import <Foundation/Foundation.h>

@class SKScene;

@interface PPSceneManager : NSObject

+(SKScene *)getGameScene;

+(SKScene *)getTutorScene;

+(SKScene *)getStartScene;

+(SKScene *)getAboutScene;

@end
