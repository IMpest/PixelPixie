
#import "PPData.h"

@implementation PPData

-(id)init
{
    if (self = [super init])
    {
        [self clearAll];
        scoreMax = [PPStorageUtil getIntWithKey:CONST_KEY_MAX_SCORE];
        comboMax = 0;
        
    }
    return self;
}

-(void)clearAll
{
    score = 0;
    
    for (int i = 0; i < MAX_ROW; i++)
    {
        for (int j = 0; j < MAX_COLUMN; j++)
        {
            [self clearLand];
            pixies[i][j] = [PPPixie getRandomPixie];
        }
    }
}

-(NSInteger)getScore
{
    return score;
}

-(void)addScore:(PPPixie *)pixie
{
    score = score + pixie.levelCur;
}

-(void)countCombo:(int)combo
{
    if (combo > comboMax)
    {
        comboMax = combo;
    }
}

-(NSInteger)getLandByRow:(int)row Col:(int)col
{
    if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN) return -1;
    return land[row][col];
}

-(void)setLand:(NSInteger)value Row:(int)row Col:(int)colunm
{
    land[row][colunm] = value;
}

-(void)clearLand
{
    for (int i = 0; i < MAX_ROW; i++)
    {
        for (int j = 0; j < MAX_COLUMN; j++)
        {
            [self setLand:LAND_START Row:i Col:j];
        }
    }
}

-(PPPixie *)getPixieByRow:(int)row Col:(int)col
{
    if (row < 0 || row > MAX_ROW || col < 0 || col > MAX_COLUMN) return nil;
    return pixies[row][col];
}

-(void)setPixie:(PPPixie *)value Row:(int)row Col:(int)col
{
    pixies[row][col] = value;
}

@end
