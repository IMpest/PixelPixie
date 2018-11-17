//
//  PPTutorialScene.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/17.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

import Foundation

@objc
class PPTutorialScene: SKScene {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init() {
        super.init()
        self.size = CGSize(width: CGFloat(GAME_AREA_WIDTH), height: CGFloat(GAME_AREA_HEIGHT))
        self.backgroundColor = UIColor.yellow
        
        let backNode = SKSpriteNode(color: UIColor.gray, size: self.size)
        backNode.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(backNode)
        
        let btReady = PPSpriteButton(color: UIColor.black, size: CGSize(width: 300, height: 100))
        btReady.position = CGPoint(x: 100, y: 100)
        btReady.setLabelWithText("READY!", with: UIColor.white)
        btReady.addTarget(self, selector: #selector(btnDown), with: nil, for: PPButtonControlEvent.touchUpInside)
        self.addChild(btReady)
    }
    
    func btnDown() {
        PPSceneManager.jump(from: self, to: PPSceneManager.getAnotherGameScene());
    }
}
