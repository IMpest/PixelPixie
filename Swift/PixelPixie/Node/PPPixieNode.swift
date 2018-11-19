//
//  File.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/17.
//  Copyright © 2018年 ！. All rights reserved.
//

@objc
class PPPixieNode: SKSpriteNode {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(pixie: PPPixie) {
        super.init(texture: nil,
                   color: UIColor.clear,
                   size: CGSize(width: CGFloat(BLOCK_WIDTH), height: CGFloat(BLOCK_HEIGHT)))
        
        self.anchorPoint = CGPoint(x:0, y:0)
        self.refresh(byPixie: pixie)
    }
    
    func refresh(byPixie pixie: PPPixie) -> Void{
        self.alpha = 1.0
        let imageName = PPDataUtil.getPicBy(pixie, andNumber: 0)
        
        self.texture = SKTexture.init(imageNamed: imageName!)
        self.run(PPNodeUtil.getActionBy(pixie))
    }
    
    func clean() -> Void {
        self.alpha = 0.0
    }
}
