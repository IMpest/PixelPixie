
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

// Model
#import "PPPixie.h"
#import "PPData.h"

// Util
#import "PPNodeUtil.h"
#import "PPDataUtil.h"
#import "PPStorageUtil.h"

// Node
#import "PPSpriteButton.h"
#import "PPTimeNode.h"

// Scene
#import "PPGameScene.h"
#import "PPStartScene.h"

// Game Scene
#define MAX_LEVEL 4
#define MAX_LEVEL_BEGIN 2
#define MAX_ELEMENT 3
#define MAX_SKIN 1

#define MAX_ROW 5
#define MAX_COLUMN 5
#define MAX_BLOCK (MAX_ROW*MAX_COLUMN)

#define GAME_AREA_WIDTH 320
#define GAME_AREA_HEIGHT 568

#define BLOCK_HEIGHT (320/MAX_ROW)
#define BLOCK_WIDTH (320/MAX_COLUMN)

#define LAND_TOP_BOTTOM 124
#define LAND_START 0

#define DRC_UP 1
#define DRC_RT 2
#define DRC_DW 4
#define DRC_LT 8

#define TIME_MAX 30

#define TEXT_SIZE 20
#define TEXT_FONT @"Mouse"

#define FRAME_STATUS 5
#define FRAME_SPEED 0.1f
#define EAT_SPEED 0.5f

// Time Node
#define TIMEZONE_WIDTH 312
#define TIMEZONE_HEIGHT 14

#define TIMELINE_WIDTH 308
#define TIMELINE_HEIGHT 14

#define TIMELINE_LEFT ((TIMEZONE_WIDTH-TIMELINE_WIDTH)/2)
