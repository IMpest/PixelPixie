//
//  PPLabelNode.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/17.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

@objcMembers
class PPLabelNode: SKLabelNode {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init() {
        super.init()
        self.fontName = TEXT_FONT;
        self.fontSize = CGFloat(TEXT_SIZE);
    }
}
