
#import "PPSceneManager.h"

static SKScene *gameScene, *tutorScene, *startScene, *aboutScene;

@implementation PPSceneManager

+(SKScene *)getGameScene
{
    if (gameScene == nil)
    {
        gameScene = [[PPGameScene alloc] init];
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return gameScene;
}

+(SKScene *)getTutorScene
{
    if (tutorScene == nil)
    {
        tutorScene = [[PPTutorScene alloc] init];
        tutorScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return tutorScene;
}

+(SKScene *)getStartScene
{
    if (startScene == nil)
    {
        startScene = [[PPStartScene alloc] init];
        startScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return startScene;
}

+(SKScene *)getAboutScene
{
    if (aboutScene == nil)
    {
        aboutScene = [[PPAboutScene alloc] init];
        aboutScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return aboutScene;
}

@end
