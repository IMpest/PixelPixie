
typedef NS_ENUM(int, PPElement) {
    PPElementNone = 0,
    PPElementFire = 1,        // 火
    PPElementWater = 2,       // 水
    PPElementPlant = 3,       // 木
};

typedef NS_ENUM(int, PPStatus) {
    PPStatusNone = 0,
    PPStatusStop = 1,
    PPStatusEat = 2,
    PPStatusFear = 3,
    PPStatusBall = 4,
};

@interface PPPixie : NSObject

@property (nonatomic, assign) NSInteger levelCur;

@property (nonatomic, assign) NSInteger expCur;

@property (nonatomic, assign) NSInteger expMax;

@property (nonatomic, assign) PPElement element;

@property (nonatomic, assign) PPStatus status;

@property (nonatomic, assign) NSInteger skin;

+ (PPPixie *)getRandomPixie;

+ (PPPixie *)clonePixie:(PPPixie *)pixie;

- (instancetype)initWithLevel:(int)level AndElement:(PPElement)element AndStatus:(PPStatus)status;

- (void)eatPixie:(PPPixie *)foodPixie;

- (NSInteger)getBouns;

@end
