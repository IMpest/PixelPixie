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
    
    func btnDown() {
        PPSceneManager.jump(from: self, to: PPSceneManager.getAnotherGameScene());
    }
}

//- (void)btnDown {
//    [PPSceneManager jumpFrom:self To:[PPSceneManager getAnotherGameScene]];
//}

//- (instancetype)init {
//    if (self = [super init]) {
//        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);
//        self.backgroundColor = [UIColor yellowColor];
//
//        SKSpriteNode * backNode = [[SKSpriteNode alloc] initWithColor:[UIColor grayColor] size:self.size];
//        backNode.anchorPoint = CGPointMake(0, 0);
//        [self addChild:backNode];
//
//        PPSpriteButton * btReady = [PPSpriteButton buttonWithColor:[UIColor blackColor] andSize:CGSizeMake(300, 100)];
//        btReady.position = CGPointMake(100, 100);
//        [btReady setLabelWithText:@"READY!" withColor:[UIColor whiteColor]];
//        [btReady addTarget:self selector:@selector(btnDown) withObject:nil forControlEvent:PPButtonControlEventTouchUpInside];
//        [self addChild:btReady];
//    }
//    return self;
//}
