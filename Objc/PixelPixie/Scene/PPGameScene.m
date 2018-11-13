
#import "PPGameScene.h"

typedef NS_ENUM(NSInteger, GameStatus) {
    STATUS_READY,
    STATUS_PLAY,
    STATUS_PAUSE,
    STATUS_END
};

@interface PPGameScene ()
@property (nonatomic, assign) GameStatus status;
@property (nonatomic, strong) PPData * data;
@end

@implementation PPGameScene

PPPixieNode * pixieNode[MAX_ROW][MAX_COLUMN];
PPPixieNode * pixieNodeTemp;

SKSpriteNode * landNode[MAX_ROW][MAX_COLUMN];
PPTimeNode * timeNode;
PPScoreNode * scoreNode;
PPStatNode * statNode;

int prevRow,  prevCol;
int startRow, startCol;
PPPixie * startPixie;

int step;
int routeRow[MAX_BLOCK], routeCol[MAX_BLOCK];

- (instancetype)init {
    if (self = [super init]) {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);

        _data = [[PPData alloc] init];        
        _status = STATUS_PLAY;
        
        // 地板
        for (int i = 0; i < MAX_ROW; i++) {
            for (int j = 0; j < MAX_COLUMN; j++) {
                landNode[i][j] = [SKSpriteNode spriteNodeWithImageNamed:[PPDataUtil getPicByMap:[_data getLandByRow:i Col:j]]];
                [landNode[i][j] setPosition:[PPNodeUtil getNodePositionByRow:i COL:j]];
                [landNode[i][j] setSize:CGSizeMake(BLOCK_WIDTH, BLOCK_HEIGHT)];
                [landNode[i][j] setAnchorPoint:CGPointMake(0.0f, 0.0f)];
                [self addChild:landNode[i][j]];
            }
        }
        
        // 上下边界
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < MAX_COLUMN; j++) {
                NSString * top = [NSString stringWithFormat:@"edge_top_0%d", i];
                
                SKSpriteNode * wall = [SKSpriteNode spriteNodeWithImageNamed:top];
                [wall setPosition:CGPointMake(j * BLOCK_WIDTH, (i + MAX_ROW) * BLOCK_HEIGHT + LAND_TOP_BOTTOM)];
                [wall setSize:CGSizeMake(BLOCK_WIDTH, BLOCK_HEIGHT)];
                [wall setAnchorPoint:CGPointMake(0.0f, 0.0f)];
                [self addChild:wall];
                
                NSString * bottom = [NSString stringWithFormat:@"edge_bottom_0%d", i];
                
                SKSpriteNode * wall2 = [SKSpriteNode spriteNodeWithImageNamed:bottom];
                [wall2 setPosition:CGPointMake(j * BLOCK_WIDTH, i * BLOCK_HEIGHT)];
                [wall2 setSize:CGSizeMake(BLOCK_WIDTH, BLOCK_HEIGHT)];
                [wall2 setAnchorPoint:CGPointMake(0.0f, 0.0f)];
                [self addChild:wall2];
            }
        }
        
        // 宠物Node
        for (int i = 0; i < MAX_ROW; i++) {
            for (int j = 0; j < MAX_COLUMN; j++) {
                pixieNode[i][j] = [[PPPixieNode alloc] initWithPixie:[_data getPixieByRow:i Col:j]];
                [pixieNode[i][j] setPosition:[PPNodeUtil getNodePositionByRow:i COL:j]];
                [self addChild:pixieNode[i][j]];
            }
        }
        
        // 时间条
        timeNode = [[PPTimeNode alloc] initWithTimeMax:TIME_MAX];
        timeNode.position = CGPointMake(4, 487);
        [self addChild:timeNode];
        [timeNode setTime:[NSDate date]];
        [timeNode startTimer];
        
        // 积分Node
        scoreNode = [[PPScoreNode alloc] init];
        scoreNode.position = CGPointMake(GAME_AREA_WIDTH / 2, GAME_AREA_HEIGHT - 40);
        [self addChild:scoreNode];
        [self refreshScore];
        
    }
    return self;
}

- (void)initLand {
    for (int i = 0; i < MAX_ROW; i++) {
        for (int j = 0; j < MAX_COLUMN; j++) {
            [_data getLandByRow:i Col:j];
            landNode[i][j] = [SKSpriteNode spriteNodeWithImageNamed:[PPDataUtil getPicByMap:[_data getLandByRow:i Col:j]]];
        }
    }
}

- (void)refreshAllLand {
    for (int i = 0; i < MAX_ROW; i++) {
        for (int j = 0; j < MAX_COLUMN; j++) {
            [self refreshLandByRow:i Col:j];
        }
    }
}

- (void)refreshLandByRow:(int)row Col:(int)col {
    if (landNode[row][col] != nil) {
        SKTexture * t = [SKTexture textureWithImageNamed:[PPDataUtil getPicByMap:[_data getLandByRow:row Col:col]]];
        [landNode[row][col] setTexture:t];
    }
}

- (void)refreshScore {
    if (scoreNode != nil) {
        scoreNode.text = [NSString stringWithFormat:@"%ld", (long)[_data getScore]];
    }
}

#pragma mark UIRepsond

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_status != STATUS_PLAY) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    int row = [PPNodeUtil getRowByPostion:point];
    int col = [PPNodeUtil getColByPostion:point];

    if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN) return;
    
    // 暂停时间
    [timeNode pauseTimer];
    
    
    // 存储路径起点
    startRow = row;
    startCol = col;
    startPixie = [_data getPixieByRow:startRow Col:startCol];
    
    if (startPixie.levelCur <= 1) return;
    
    prevRow = row;
    prevCol = col;
    
    step = 0;
    
    routeRow[step] = startRow;
    routeCol[step] = startCol;
    step ++;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_status != STATUS_PLAY) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    int curRow = [PPNodeUtil getRowByPostion:point];
    int curCol = [PPNodeUtil getColByPostion:point];
    
    if (curRow < 0 || curRow > MAX_ROW ||
        curCol < 0 || curCol > MAX_COLUMN ||
        abs(curRow - prevRow) + abs(curCol - prevCol) > 1) {
        return;
    }
    
    // 宠物可以被吃验证
    PPPixie * curPixie = [_data getPixieByRow:curRow Col:curCol];
    if (curPixie.levelCur >= startPixie.levelCur || curPixie.element == startPixie.element) return;
    
    // 空格没有被划过验证
    int curLand = [_data getLandByRow:curRow Col:curCol];
    if (curLand != 0) return;
    
    // 修改宠物状态
    curPixie.status = PPStatusFear;
    [self refreshPixieAtRow:curRow Col:curCol];
    
    // 修改地面
    int prevLand = [_data getLandByRow:prevRow Col:prevCol];
    if (prevLand >= 0) {
        if (curRow == prevRow) {
            // 同一行
            if (curCol < prevCol) {
                // 向左滑
                curLand += DRC_RT;
                prevLand += DRC_LT;
            } else if (curCol > prevCol) {
                // 向右滑
                curLand += DRC_LT;
                prevLand += DRC_RT;
            }
        } else if (curCol == prevCol) {
            // 同一列
            if (curRow < prevRow) {
                // 向上滑
                curLand += DRC_DW;
                prevLand += DRC_UP;
            } else if (curRow > prevRow){
                // 向下滑
                curLand += DRC_UP;
                prevLand += DRC_DW;
            }
        }
        
        [_data setLand:curLand Row:curRow Col:curCol];
        [_data setLand:prevLand Row:prevRow Col:prevCol];
        
        [self refreshLandByRow:curRow Col:curCol];
        [self refreshLandByRow:prevRow Col:prevCol];
        
        prevRow = curRow;
        prevCol = curCol;
        
        // 存储路径
        routeRow[step] = curRow;
        routeCol[step] = curCol;
        step ++;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    int row = [PPNodeUtil getRowByPostion:point];
    int col = [PPNodeUtil getColByPostion:point];
    
    if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN || step <= 0) {
        [self clearPath];
        return;
    }
    
    // 判断是否有
    if (step <= 1) {
        return;
    }
    
    // 准备吃的动作
    NSMutableArray * eatAction = [NSMutableArray array];
    [eatAction addObject:[SKAction moveTo:[PPNodeUtil getPointByRow:startRow Col:startCol] duration:0.0f]];
    
    for (int i = 1; i < step; i++) {
        int eatRow = routeRow[i];
        int eatCol = routeCol[i];
        
        // 被吃的宠物变成球
        PPPixie * tpixie = [_data getPixieByRow:eatRow Col:eatCol];
        tpixie.status = PPStatusBall;
        [self refreshPixieAtRow:eatRow Col:eatCol];
        
        // 添加吃的子动作
        SKAction * tAniKill = [SKAction runBlock:^{
            [pixieNode[eatRow][eatCol] clean];
            [_data addScore:tpixie];
            [self refreshScore];
        }];
        SKAction * tAniMove = [SKAction moveTo:[PPNodeUtil getPointByRow:eatRow Col:eatCol] duration:EAT_SPEED];
        
        [eatAction addObject:tAniKill];
        [eatAction addObject:tAniMove];
    }
    
    // 主身隐藏
    [pixieNode[startRow][startCol] clean];
    
    // 替身开吃
    startPixie.status = PPStatusEat;
    pixieNodeTemp = [[PPPixieNode alloc] initWithPixie:startPixie];
    [self addChild:pixieNodeTemp];
    
    [pixieNodeTemp runAction:[SKAction sequence:eatAction] completion:^{
        // 重新开启时间
        [timeNode resumeTimer];
        
        // 停止吃的动作
        startPixie.status = PPStatusStop;
        PPPixie * tempPixie;
        
        // 主身与目标位置替换
        int targetRow = routeRow[step - 1];
        int targetCol = routeCol[step - 1];
        
        tempPixie = [_data getPixieByRow:targetRow Col:targetCol];
        [_data setPixie:[_data getPixieByRow:startRow Col:startCol] Row:targetRow Col:targetCol];
        [_data setPixie:tempPixie Row:startRow Col:startCol];
        
        [self refreshPixieAtRow:targetRow Col:targetCol];
        [self refreshPixieAtRow:startRow Col:targetCol];
        
        // 替身消失
        [pixieNodeTemp removeFromParent];
        
        // 路径上的宠物重新生成
        for (int i = 0; i < step - 1; i++) {
            tempPixie = [PPPixie getRandomPixie];
            int tRow = routeRow[i];
            int tCol = routeCol[i];
            
            [_data setPixie:tempPixie Row:tRow Col:tCol];
            [self refreshPixieAtRow:tRow Col:tCol];
            
            // 落下动画
            int dropHeight = 50;
            PPPixieNode * tPixieNode = pixieNode[tRow][tCol];
            tPixieNode.alpha = 0;
            SKAction * high = [SKAction moveByX:0 y:dropHeight duration:0.0f];
            SKAction * drop = [SKAction group:
                               @[[SKAction moveByX:0 y:-dropHeight duration:0.2f],
                                 [SKAction fadeAlphaTo:1 duration:0.2f]
                                 ]];
            drop.timingMode = SKActionTimingEaseIn;
            [tPixieNode runAction:[SKAction sequence:@[high, drop]]];
        }
        
        // 主目标停吃 + 涨经验 + 升级
        PPPixie * targetPixie = [_data getPixieByRow:targetRow Col:targetCol];;
        targetPixie.status = PPStatusStop;
        
        for (int i = 0; i < step; i++) {
            PPPixie * foodPixie = [_data getPixieByRow:routeRow[i] Col:routeCol[i]];
            [targetPixie eatPixie:foodPixie];
        }
        [self refreshPixieAtRow:targetRow Col:targetCol];
        
        // 增加奖励时间
        NSTimeInterval bounsTime = 5;
        [timeNode addTime:bounsTime];
        
        // 清空路径数据
        [self clearPath];
    }];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_status != STATUS_PLAY) return;
}

#pragma mark Scene Lifecycle

- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    if (_status == STATUS_PLAY) {
        NSTimeInterval timeLeft = [timeNode refreshCurrentTime];
        if (timeLeft <= 0) {
            // TODO:结算
            _status = STATUS_END;
            [self showStat];
            [self showAds];
        }
    }
}

#pragma mark Custom

- (void)refreshPixieAtRow:(int)row Col:(int)col {
    PPPixie * tempPixie = [_data getPixieByRow:row Col:col];
    [pixieNode[row][col] refreshByPixie:tempPixie];
}

// 清零路径数据
- (void)clearPath {
    // 还原数据
    step = 0;
    
    // 清零开始坐标
    prevRow = -1;
    prevCol = -1;
    
    // 清理地面
    [_data clearLand];
    [self refreshAllLand];
}

- (void)showStat {
    statNode = [[PPStatNode alloc] initWithScene:self Data:_data];
    statNode.position = CGPointMake(GAME_AREA_WIDTH / 2, GAME_AREA_HEIGHT / 2);
    [self addChild:statNode];
}

- (void)showAds {
    UIView * ads = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.view addSubview:ads];
}

@end
