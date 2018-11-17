//
//  PPStatNode.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/17.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

@objc
class PPStatNode: SKSpriteNode {
    weak var parentScene: SKScene? = nil
    var btAgain: PPSpriteButton = PPSpriteButton(color: UIColor.red, size: CGSize(width: 100, height: 50))
    var bt2Menu: PPSpriteButton = PPSpriteButton(color: UIColor.blue, size: CGSize(width: 100, height: 50))
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(scene: SKScene, data: PPData) {
        super.init(texture: nil, color: UIColor.white, size: CGSize(width: 240, height: 360))
        
        self.parentScene = scene
        
        self.btAgain.position = CGPoint(x: 50, y: -70)
        self.btAgain.setLabelWithText("AGAIN", with: UIColor.white)
        self.btAgain.addTarget(self, selector: #selector(clickAgain), with: nil, for: PPButtonControlEvent.touchUpInside)
        self.addChild(self.btAgain)
        
        self.bt2Menu.position = CGPoint(x: -50, y: -70)
        self.bt2Menu.setLabelWithText("MENU", with: UIColor.white)
        self.bt2Menu.addTarget(self, selector: #selector(click2Menu), with: nil, for: PPButtonControlEvent.touchUpInside)
        self.addChild(self.bt2Menu)
    }
    
    func click2Menu() -> Void {
        PPSceneManager.jump(from: self.parentScene!, to: PPSceneManager.getStartScene())
    }
    
    func clickAgain() -> Void {
        PPSceneManager.jump(from: self.parentScene!, to: PPSceneManager.getAnotherGameScene())
    }
    
}
