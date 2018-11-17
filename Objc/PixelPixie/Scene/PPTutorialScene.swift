//
//  PPTutorialScene.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/17.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

@objc
class PPTutorialScene: SKScene {
    
    override init() {
        super.init(size: CGSize(width: CGFloat(GAME_AREA_WIDTH), height: CGFloat(GAME_AREA_HEIGHT)))
        self.backgroundColor = UIColor.yellow
        
        let btReady = PPSpriteButton(color: UIColor.black, size: CGSize(width: 300, height: 100))
        btReady.position = CGPoint(x: 100, y: 100)
        btReady.setLabelWithText("READY!", with: UIColor.white)
        btReady.addTarget(self, selector: #selector(btnDown), with: nil, for: PPButtonControlEvent.touchUpInside)
        self.addChild(btReady)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func btnDown() {
        PPSceneManager.jump(from: self, to: PPSceneManager.getAnotherGameScene());
    }
}
