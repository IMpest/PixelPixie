//
//  PPScoreNode.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/19.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

@objc
class PPScoreNode: PPLabelNode {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init() {
        super.init()
        self.fontColor = UIColor.black
    }
}

