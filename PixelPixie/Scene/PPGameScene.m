
#import "PPGameScene.h"

@interface PPGameScene ()
@property (nonatomic, assign) BOOL canPlay;
@property (nonatomic, strong) PPData * data;
@end

@implementation PPGameScene

PPPixieNode * pixieNode[MAX_ROW][MAX_COLUMN];
PPPixieNode * pixieNodeTemp;

SKSpriteNode * landNode[MAX_ROW][MAX_COLUMN];
SKSpriteNode * timeNode;
SKLabelNode * scoreNode;

int prevRow,  prevCol;
int startRow, startCol;
PPPixie * startPixie;

int combo;
int routeRow[MAX_BLOCK], routeCol[MAX_BLOCK];

-(id)init
{
    if (self = [super init])
    {
        self.size = CGSizeMake(GAME_AREA_WIDTH, GAME_AREA_HEIGHT);

        _data = [[PPData alloc] init];        
        _canPlay = true;
        
        // 地板
        for (int i = 0; i < MAX_ROW; i++)
        {
            for (int j = 0; j < MAX_COLUMN; j++)
            {
                landNode[i][j] = [SKSpriteNode spriteNodeWithImageNamed:[PPDataUtil getPicByMap:[_data getLandByRow:i Col:j]]];
                [landNode[i][j] setPosition:[PPNodeUtil getNodePositionByRow:i COL:j]];
                [landNode[i][j] setSize:CGSizeMake(BLOCK_WIDTH, BLOCK_HEIGHT)];
                [landNode[i][j] setAnchorPoint:CGPointMake(0.0f, 0.0f)];
                [self addChild:landNode[i][j]];
            }
        }
        
        // 上下边界
        for (int i = 0; i < 2; i++)
        {
            for (int j = 0; j < MAX_COLUMN; j++)
            {
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
        for (int i = 0; i < MAX_ROW; i++)
        {
            for (int j = 0; j < MAX_COLUMN; j++)
            {
                pixieNode[i][j] = [[PPPixieNode alloc] initWithPixie:[_data getPixieByRow:i Col:j]];
                [pixieNode[i][j] setPosition:[PPNodeUtil getNodePositionByRow:i COL:j]];
                [self addChild:pixieNode[i][j]];
            }
        }
        
        // 时间条
        timeNode = [[PPTimeNode alloc] initWithTimeMax:300];
        timeNode.position = CGPointMake(4, 487);
        [self addChild:timeNode];
        
        // 积分Node
        scoreNode = [[SKLabelNode alloc] init];
        scoreNode.fontName = @"Mouse";
        scoreNode.fontColor = [UIColor blackColor];
        scoreNode.fontSize = 20.0f;
        scoreNode.position = CGPointMake(GAME_AREA_WIDTH / 2, GAME_AREA_HEIGHT - 40);
        [self addChild:scoreNode];
        [self refreshScore];
        
    }
    return self;
}

-(void)initLand
{
    for (int i = 0; i < MAX_ROW; i++)
    {
        for (int j = 0; j < MAX_COLUMN; j++)
        {
            [_data getLandByRow:i Col:j];
            landNode[i][j] = [SKSpriteNode spriteNodeWithImageNamed:[PPDataUtil getPicByMap:[_data getLandByRow:i Col:j]]];
        }
    }
}

-(void)refreshAllLand
{
    for (int i = 0; i < MAX_ROW; i++)
    {
        for (int j = 0; j < MAX_COLUMN; j++)
        {
            [self refreshLandByRow:i Col:j];
        }
    }
}

-(void)refreshLandByRow:(int)row Col:(int)col
{
    if (landNode != nil)
    {
        SKTexture * t = [SKTexture textureWithImageNamed:[PPDataUtil getPicByMap:[_data getLandByRow:row Col:col]]];
        [landNode[row][col] setTexture:t];
    }
}

-(void)refreshScore
{
    if (scoreNode != nil)
    {
        scoreNode.text = [NSString stringWithFormat:@"%d", [_data getScore]];
    }
}

#pragma mark UIRepsond

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_canPlay) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    int row = [PPNodeUtil getRowByPostion:point];
    int col = [PPNodeUtil getColByPostion:point];

    if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN) return;
    
    startRow = row;
    startCol = col;
    startPixie = [_data getPixieByRow:startRow Col:startCol];
    
    if (startPixie.levelCur <= 1) return;
    
    prevRow = row;
    prevCol = col;
    
    combo = 0;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_canPlay) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    int curRow = [PPNodeUtil getRowByPostion:point];
    int curCol = [PPNodeUtil getColByPostion:point];
    
    if (curRow < 0 || curRow > MAX_ROW ||
        curCol < 0 || curCol > MAX_COLUMN ||
        abs(curRow - prevRow) + abs(curCol - prevCol) > 1)
    {
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
    [pixieNode[curRow][curCol] refresh];
    
    // 修改地面
    int prevLand = [_data getLandByRow:prevRow Col:prevCol];
    if (prevLand >= 0)
    {
        if (curRow == prevRow) // 同一行
        {
            if (curCol < prevCol) // 向左滑
            {
                curLand += DRC_RT;
                prevLand += DRC_LT;
            }
            else if (curCol > prevCol) // 向右滑
            {
                curLand += DRC_LT;
                prevLand += DRC_RT;
            }
        }
        else if (curCol == prevCol)  // 同一列
        {
            if (curRow < prevRow) // 向上滑
            {
                curLand += DRC_DW;
                prevLand += DRC_UP;
            }
            else if (curRow > prevRow) // 向下滑
            {
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
        routeRow[combo] = curRow;
        routeCol[combo] = curCol;
        combo ++;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    int row = [PPNodeUtil getRowByPostion:point];
    int col = [PPNodeUtil getColByPostion:point];
    
    if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN || combo <= 0)
    {
        [self recoveyTouch];
        return;
    }
    
    // 准备吃的动作
    NSMutableArray * eatAction = [NSMutableArray array];
    [eatAction addObject:[SKAction moveTo:[PPNodeUtil getPointByRow:startRow Col:startCol] duration:0.0f]];
    
    for (int i = 0; i < combo; i++)
    {
        int eatRow = routeRow[i];
        int eatCol = routeCol[i];
        
        // 被吃的宠物变成球
        PPPixie * tpixie = [_data getPixieByRow:eatRow Col:eatCol];
        tpixie.status = PPStatusBall;
        [pixieNode[eatRow][eatCol] refresh];
        
        // 添加动作
        SKAction * tAniKill = [SKAction runBlock:^
                               {
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
    pixieNodeTemp = [[PPPixieNode alloc] initWithPixie:startPixie];
    pixieNodeTemp.pixie.status = PPStatusEat;
    [pixieNodeTemp refresh];
    [self addChild:pixieNodeTemp];
    
    [pixieNodeTemp runAction:[SKAction sequence:eatAction] completion:^
    {
        // 替身消失
        [pixieNodeTemp removeFromParent];
        
        // 路径上的宠物重新生成
        PPPixie * tempPixie;
        for (int i = 0; i < combo; i++)
        {
            tempPixie = [PPPixie getRandomPixie];
            int tRow = routeRow[i];
            int tCol = routeCol[i];
            
            [_data setPixie:tempPixie Row:tRow Col:tCol];
            pixieNode[tRow][tCol].pixie = tempPixie;
            [pixieNode[tRow][tCol] refresh];
        }
        
        // 主身与目标位置替换
        int targetRow = routeRow[combo - 1];
        int targetCol = routeCol[combo - 1];
        
        tempPixie = [_data getPixieByRow:targetRow Col:targetCol];
        [_data setPixie:[_data getPixieByRow:startRow Col:startCol] Row:targetRow Col:targetCol];
        [_data setPixie:tempPixie Row:startRow Col:startCol];
        
        tempPixie = pixieNode[targetRow][targetCol].pixie;
        pixieNode[targetRow][targetCol].pixie = pixieNode[startRow][startCol].pixie;
        pixieNode[startRow][startCol].pixie = tempPixie;
        
        [pixieNode[startRow][startCol] refresh];
        
        // 主目标停吃+涨经验+升级
        PPPixie * targetPixie = pixieNode[targetRow][targetCol].pixie;
        targetPixie.status = PPStatusStop;
        
        for (int i = 0; i < combo; i++)
        {
            PPPixie * foodPixie = [_data getPixieByRow:routeRow[i] Col:routeCol[i]];
            [targetPixie eatPixie:foodPixie];
        }
        [pixieNode[targetRow][targetCol] refresh];
        
        [self recoveyTouch];
    }];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_canPlay) return;
}

-(void)recoveyTouch
{
    // 还原数据
    combo = 0;
    
    // 清零开始坐标
    prevRow = -1;
    prevCol = -1;
    
    // 清理地面
    [_data clearLand];
    [self refreshAllLand];
}

@end
