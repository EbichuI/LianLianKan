//
//  FKGameService.h
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKPiece.h"
#import "FKLinkInfo.h"

@interface FKGameService : NSObject
@property (nonatomic , strong) NSArray* pieces;
@property(nonatomic,assign)int a;
/**
 * 控制游戏开始的方法
 */
- (void) start:(int)k;
/**
 * 判断参数FKPiece二维数组中是否还存在非空的FKPiece对象
 * @return 如果还剩FKPiece对象返回YES, 没有返回NO
 */
- (BOOL) hasPieces;
/**
 * 根据触碰点的X座标和Y坐标, 查找出一个FKPiece对象
 * @param touchX 触碰点的X坐标
 * @param touchY 触碰点的Y坐标
 * @return 返回对应的FKPiece对象, 没有返回nil
 */
- (FKPiece*) findPieceAtTouchX:(CGFloat) touchX touchY:(CGFloat) touchY;
/**
 * 判断两个FKPiece是否可以相连, 可以连接, 返回FKLinkInfo对象
 * @param p1 第一个FKPiece对象
 * @param p2 第二个FKPiece对象
 * @return 如果可以相连，返回FKLinkInfo对象, 如果两个FKPiece不可以连接, 返回nil
 */
- (FKLinkInfo*) linkWithBeginPiece:(FKPiece*)p1 endPiece: (FKPiece*) p2;
//自动消除 💣
//
- (FKLinkInfo*) linkWithBeginPieceboom:(FKPiece*)p1 endPiece:(FKPiece*)p2;
@end
