
@class PPPixie;

@interface PPData : NSObject {
    NSInteger score;
    NSInteger scoreMax;
    NSInteger comboMax;
    NSInteger land[5][5];
    PPPixie * pixies[5][5];
}

- (void)clearAll;

- (NSInteger)getScore;

- (void)addScore:(PPPixie *)pixie;

- (void)countCombo:(int)combo;

- (NSInteger)getLandByRow:(int)row Col:(int)col;

- (void)setLand:(NSInteger)value Row:(int)row Col:(int)col;

- (void)clearLand;

- (PPPixie *)getPixieByRow:(int)row Col:(int)col;

- (void)setPixie:(PPPixie *)value Row:(int)row Col:(int)col;

@end
