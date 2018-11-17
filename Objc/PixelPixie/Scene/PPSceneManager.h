
@interface PPSceneManager : NSObject

+ (SKScene *)getCurrentGameScene;

+ (SKScene *)getAnotherGameScene;

+ (SKScene *)getTutorScene;

+ (SKScene *)getStartScene;

+ (SKScene *)getAboutScene;

+ (void)jumpFrom:(SKScene *)originScene To:(SKScene *)targetScene;

@end
