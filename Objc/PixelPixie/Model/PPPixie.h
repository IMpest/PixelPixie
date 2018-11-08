
#import <Foundation/Foundation.h>

typedef NS_ENUM(int, Element)
{
    ElementNone = 0,
    ElementFire = 1,        // 火
    ElementWater = 2,       // 水
    ElementPlant = 3,       // 木
};

typedef NS_ENUM(int, Status)
{
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

@property (nonatomic, assign) Element element;

@property (nonatomic, assign) Status status;

@property (nonatomic, assign) NSInteger skin;

+ (PPPixie *)getRandomPixie;

+ (PPPixie *)clonePixie:(PPPixie *)pixie;

- (id)initWithLevel:(int)level AndElement:(Element)element AndStatus:(Status)status;

- (void)eatPixie:(PPPixie *)foodPixie;

- (NSInteger)getBouns;

@end
