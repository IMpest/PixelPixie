//
//  PPSceneManager.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/17.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

@objc
class PPSceneManager: NSObject {
    
    static let tutorScene: SKScene = PPTutorialScene()
    static let startScene: SKScene = PPStartScene()
    static let aboutScene: SKScene = PPAboutScene()
    
    static var gameScene: SKScene = PPGameScene()
    static var gameScenePrev: SKScene? = nil
    
    static func getCurrentGameScene() -> SKScene {
        gameScene.scaleMode = SKSceneScaleMode.aspectFill
        return gameScene
    }
    
    static func getAnotherGameScene() -> SKScene {
        gameScenePrev = nil;
        gameScenePrev = PPSceneManager.gameScene;

        gameScene = PPGameScene();
        return gameScene
    }
    
    static func getTutorScene() -> SKScene {
        tutorScene.scaleMode = SKSceneScaleMode.aspectFill
        return tutorScene
    }
    
    static func getStartScene() -> SKScene {
        startScene.scaleMode = SKSceneScaleMode.aspectFill
        return startScene
    }
    
    static func getAboutScene() -> SKScene {
        aboutScene.scaleMode = SKSceneScaleMode.aspectFill
        return aboutScene
    }
    
    static func jump(from originScene: SKScene, to targetScene: SKScene) -> Void {
        let fade = SKTransition.fade(withDuration: 1)
        originScene.view?.presentScene(targetScene, transition: fade)
    }
}

