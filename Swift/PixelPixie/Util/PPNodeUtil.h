
@class PPPixie;

@interface PPNodeUtil : NSObject

+ (CGPoint)getNodePositionByRow:(int)row col:(int)column;

+ (int)getRowByPostion:(CGPoint)pos;

+ (int)getColByPostion:(CGPoint)pos;

+ (CGPoint)getPointByRow:(int)row col:(int)col;

+ (SKAction *)getActionByPixie:(PPPixie *)pixie;

@end
