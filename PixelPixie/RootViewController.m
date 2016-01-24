//
//  GameViewController.m
//  PixelPixie
//
//  Created by silver6wings on 15/6/25.
//  Copyright (c) 2015年 silver6wings. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKView * skView = [[SKView alloc] initWithFrame:CGRectMake(0, 0, GAME_AREA_WIDTH, GAME_AREA_HEIGHT)];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
    
    [skView presentScene:[PPSceneManager getGameScene]];
    
    [self.view addSubview:skView];
}

@end
