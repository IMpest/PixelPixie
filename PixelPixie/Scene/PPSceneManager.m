//
//  SceneManager.m
//  PixelPixie
//
//  Created by silver6wings on 15/8/10.
//  Copyright (c) 2015年 silver6wings. All rights reserved.
//

#import "PPSceneManager.h"

static PPGameScene * gameScene;
static PPTutorScene * tutorScene;

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

@end
