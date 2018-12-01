//
//  PPData.swift
//  PixelPixie
//
//  Created by Junchao Yu on 2018/12/1.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

@objcMembers
class Data: NSObject {
    
    private var scoreMax: Int = 0
    private var score: Int = 0
    
    private var comboMax: Int = 0
    private var land: [[Int8]] = []
    private var pixies: [[PPPixie]] = []
    
    override init() {
        super.init()
        scoreMax = Int(PPStorageUtil.getIntWithKey(CONST_KEY_MAX_SCORE))
        comboMax = 0
    }

    func clearAll() {
        score = 0
        for _ in 1...MAX_ROW {
            var temp: [PPPixie] = []
            for _ in 1...MAX_COLUMN {
                temp.append(PPPixie.getRandomPixie())
            }
            pixies.append(temp)
        }
    }
    
    func clearLand() {
        for i in 0...MAX_ROW-1 {
            for j in 0...MAX_COLUMN-1 {
                self.setLand(value: Int8(LAND_START), row: Int(i), col: Int(j))
            }
        }
    }
    
    func getScore() -> Int {
        return self.score
    }
    
    func addScore(pixie: PPPixie) {
        self.score += pixie.levelCur
    }
    
    func countCombo(combo: Int) {
        if (combo > comboMax) {
            self.comboMax = combo
        }
    }
    
    // land getter & setter
    
    func getLand(row: Int, col: Int) -> Int8 {
        if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN) {
            return -1
        }
        return self.land[row][col];
    }
    
    func setLand(value: Int8, row: Int, col: Int) {
        self.land[row][col] = value;
    }
    
    // pixie getter & setter
    
    func getPixie(row: Int, col: Int) -> PPPixie? {
        if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN) {
            return nil
        }
        return pixies[row][col]
    }
    
    func setPixie(value: PPPixie, row: Int, col: Int) {
        pixies[row][col] = value
    }
}
