
@interface PPTimeNode : SKSpriteNode

@property (nonatomic, assign) NSDate * time;

- (instancetype)initWithTimeMax:(NSTimeInterval)timeMax;

- (void)startTimer;

- (void)resumeTimer;

- (void)pauseTimer;

- (void)stopTimer;

- (void)addTime:(NSTimeInterval)time;

- (NSTimeInterval)refreshCurrentTime;

@end
