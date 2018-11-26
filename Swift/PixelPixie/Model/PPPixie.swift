//
//  PPPixie.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/11/20.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

import Foundation

@objc
public enum PPElement: Int {
    case None = 0, Fire, Water, Plant
}

@objc
public enum PPStatus: Int {
    case None = 0, Stop, Eat, Fear, Ball
}

@objcMembers
class PPPixie: NSObject {
    var levelCur: Int
    var expCur: Int
    var expMax: Int
    var element: PPElement
    var status: PPStatus
    var skin: Int
    
    static func getRandomPixie() -> PPPixie {
        let level:Int = Int.random(in: 1 ... Int(MAX_LEVEL_BEGIN))
        let elementValue:Int = Int.random(in: 1 ... Int(MAX_ELEMENT))
        let element = PPElement(rawValue: elementValue)
        
        return PPPixie(level: level,
                       element: element!,
                       status: PPStatus.Stop)
    }
    
    static func clonePixie(pixie: PPPixie) -> PPPixie {
        return PPPixie(level: pixie.levelCur,
                       element: pixie.element,
                       status: pixie.status)
    }
    
    static func getExpMax(level: Int) -> Int {
        let result = (pow(2, level) as NSDecimalNumber).intValue
        return result
    }
    
    init(level: Int, element: PPElement, status: PPStatus) {
        self.levelCur = level;
        self.element = element;
        self.status = status;
        self.expCur = 0;
        self.expMax = PPPixie.getExpMax(level: level);
        self.skin = Int.random(in: 1 ... Int(MAX_SKIN)) - 1
        
        super.init()
    }
    
    func eatPixie(_ foodPixie: PPPixie) -> Void{
        self.expCur += foodPixie.getBouns()
        
        // Level up
        while self.expCur >= self.expMax && self.levelCur < MAX_LEVEL {
            self.levelCur += 1
            expCur -= expMax;
            expMax = PPPixie.getExpMax(level: self.levelCur);
        }
    }
    
    func getBouns() -> Int {
        return 2 * self.levelCur
    }
}

