//
//  GameViewController.m
//  PixelPixie
//
//  Created by silver6wings on 16/1/30.
//  Copyright (c) 2016年 silver6wings. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    SKView * skView = [[SKView alloc] initWithFrame:self.view.bounds];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
    
    [skView presentScene:[PPSceneManager getGameScene]];
    
    [self.view addSubview:skView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
