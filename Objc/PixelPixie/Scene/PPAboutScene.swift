//
//  PPTutorialScene.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/17.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

@objc
class PPAboutScene: SKScene {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init() {
        super.init(size: CGSize(width: CGFloat(GAME_AREA_WIDTH), height: CGFloat(GAME_AREA_HEIGHT)))
        self.backgroundColor = UIColor.yellow
        self.scaleMode = SKSceneScaleMode.aspectFill
        
        let backNode = SKSpriteNode(color: UIColor.white, size: self.size)
        backNode.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(backNode)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        PPSceneManager.jump(from: self, to: PPSceneManager.getStartScene())
    }
}

