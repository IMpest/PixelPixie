
@interface PPNodeUtil : NSObject

+ (CGPoint)getNodePositionByRow:(int)row COL:(int)column;

+ (int)getRowByPostion:(CGPoint)pos;

+ (int)getColByPostion:(CGPoint)pos;

+ (CGPoint)getPointByRow:(int)row Col:(int)col;

+ (SKAction *)getActionByPixie:(PPPixie *)pixie;

@end
