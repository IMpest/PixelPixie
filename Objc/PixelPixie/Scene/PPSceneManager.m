
#import "PPSceneManager.h"

static SKScene *gameScene, *gameScenePrev, *tutorScene, *startScene, *aboutScene;

@implementation PPSceneManager

+ (SKScene *)getCurrentGameScene {
    if (gameScene == nil) {
        gameScene = [[PPGameScene alloc] init];
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return gameScene;
}

+ (SKScene *)getAnotherGameScene {
    gameScenePrev = nil;
    gameScenePrev = gameScene;
    
    gameScene = [[PPGameScene alloc] init];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    return gameScene;
}

+ (SKScene *)getTutorScene {
    if (tutorScene == nil) {
        tutorScene = [[PPTutorScene alloc] init];
        tutorScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return tutorScene;
}

+ (SKScene *)getTutorialScene {
    if (tutorScene == nil) {
        tutorScene = [[PPTutorialScene alloc] init];
        tutorScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return tutorScene;
}

+ (SKScene *)getStartScene {
    if (startScene == nil) {
        startScene = [[PPStartScene alloc] init];
        startScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return startScene;
}

+ (SKScene *)getAboutScene {
    if (aboutScene == nil) {
        aboutScene = [[PPAboutScene alloc] init];
        aboutScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return aboutScene;
}

+ (void)jumpFrom:(SKScene *)originScene To:(SKScene *)targetScene {
    SKTransition * fade = [SKTransition fadeWithDuration:1];
    [originScene.view presentScene:targetScene transition:fade];
}

@end
