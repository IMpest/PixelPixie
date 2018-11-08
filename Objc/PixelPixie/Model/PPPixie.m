

#import "PPPixie.h"

@implementation PPPixie

+ (PPPixie *)getRandomPixie
{
    int level = 1 + (arc4random() % MAX_LEVEL_BEGIN);
    int element = 1 + (arc4random() % MAX_ELEMENT);
    
    PPPixie * t = [[PPPixie alloc] initWithLevel:level AndElement:element AndStatus:PPStatusStop];    
    return t;
}

+ (PPPixie *)clonePixie:(PPPixie *)pixie
{
    return [[PPPixie alloc] initWithLevel:pixie.levelCur AndElement:pixie.element AndStatus:pixie.status];
}

- (id)initWithLevel:(int)level AndElement:(Element)element AndStatus:(Status)status
{
    if (self = [super init])
    {
        self.levelCur = level;
        self.element = element;
        self.status = status;
        self.expCur = 0;
        self.expMax = [self getExpMax];
        self.skin = arc4random() % MAX_SKIN;
    }
    return self;
}


- (void)eatPixie:(PPPixie *)foodPixie
{
    _expCur += [foodPixie getBouns];
    while (_expCur >= _expMax && self.levelCur < MAX_LEVEL)
    {
        self.levelCur++;
        
        _expCur -= _expMax;
        _expMax = [self getExpMax];
    }
}

- (NSInteger)getBouns
{
    return self.levelCur * 2;
}

- (NSInteger)getExpMax
{
    return powf(2, self.levelCur);
}

@end
