//
//  FKGameService.m
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "FKGameService.h"

#import "FKBaseBoard.h"
#import "FKFullBoard.h"
#import "FKHorizontalBoard.h"
#import "FKVerticalBoard.h"
#import "Constants.h"

@implementation FKGameService
@synthesize a;
- (void) start:(int)k
{
    a=k;
//    if (a%2==1) {
//        a+=1;
//    }
    // 定义一个FKBaseBoard对象
	FKBaseBoard* board = nil;
	// 获取一个随机数, 可取值0、1、2、3四值。
//	int index = arc4random() % 4;
	// 随机生成FKBaseBoard的子类实例
//	switch (index)
//	{
//		case 0:
//			// 0返回FKVerticalBoard(竖向)
//			board = [[FKVerticalBoard alloc] init];
//			break;
//		case 1:
//			// 1返回FKHorizontalBoard(横向)
//			board = [[FKHorizontalBoard alloc] init];
//			break;
//		default:
//			// 默认返回FKFullBoard
//			board = [[FKFullBoard alloc] init];
//			break;
//	}
	// 初始化FKPiece二维数组数组
    board = [[FKFullBoard alloc] init];

    self.pieces = [board create:k];
}
- (BOOL) hasPieces
{
	// 遍历FKPiece二维数组的每个元素
	for (int i = 0; i < self.pieces.count; i++)
	{
		for (int j = 0; j < [[self.pieces objectAtIndex:i] count]; j++)
		{
			// 只要某个数组元素是FKPiece对象，也就是还剩有非空的FKPiece对象
			if([[[self.pieces objectAtIndex:i] objectAtIndex:j] class]
				== FKPiece.class)
			{
				return YES;
			}
		}
	}
	return NO;
}
// 根据触碰点的位置查找相应的方块
- (FKPiece*) findPieceAtTouchX:(CGFloat) touchX touchY:(CGFloat) touchY
{
	// 由于在创建FKPiece对象的时候, 将每个FKPiece的开始坐标加了
	// beginImageX/beginImageY常量值, 因此这里要减去这个值
	CGFloat relativeX = touchX - beginImageX;
	CGFloat relativeY = touchY - beginImageY;
	// 如果鼠标点击的地方比board中第一张图片的开始x坐标和开始y坐标要小,
	// 即没有找到相应的方块
	if (relativeX < 0 || relativeY < 0)
	{
		return nil;
	}
	// 获取relativeX坐标在FKPiece二维数组中的第一维的索引值
	// 第二个参数为每张图片的宽
	int indexX = [self getIndexWithRelateive:relativeX size: Width/(xSize+a)];
	// 获取relativeY坐标在FKPiece二维数组中的第二维的索引值
	// 第二个参数为每张图片的高
	int indexY = [self getIndexWithRelateive:relativeY size: Width/(xSize+a)];
	// 这两个索引比数组的最小索引还小, 返回nil
	if (indexX < 0 || indexY < 0)
	{
		return nil;
	}
   
        
    
	// 这两个索引比数组的最大索引还大(或者等于), 返回nil
	if (indexX >= xSize+a || indexY >= ySize+a)
	{
		return nil;
	}
    

	// 返回FKPiece二维数组的指定元素
	return [[self.pieces objectAtIndex:indexX] objectAtIndex:indexY];
}
// 工具方法, 根据relative坐标计算相对于FKPiece二维数组的第一维
// 或第二维的索引值 ，size为每张图片边的长或者宽
- (int) getIndexWithRelateive: (NSInteger)relative size:(NSInteger) size
{
	// 表示坐标relative不在该数组中
	int index = -1;
	// 让坐标除以边长, 没有余数, 索引减1
	// 例如点了x坐标为20, 边宽为10, 20 % 10 没有余数,
	// index为1, 即在数组中的索引为1(第二个元素)
	if (relative % size == 0)
	{
		index = relative / size - 1;
	}
	else
	{
		// 有余数, 例如点了x坐标为21, 边宽为10, 21 % 10有余数, index为2
		// 即在数组中的索引为2(第三个元素)
		index = relative / size;
	}
	return index;
}

// 实现接口部分的linkWithBeginPiece:endPiece:方法
- (FKLinkInfo*) linkWithBeginPiece:(FKPiece*)p1 endPiece:(FKPiece*)p2
{
	// 两个FKPiece是同一个, 即选中了同一个方块, 返回nil
	if (p1 == p2)
		return nil;
	// 如果p1的图片与p2的图片不相同, 则返回nil
	if (![p1 isEqual:p2])
		return nil;
	// 如果p2在p1的左边, 则需要重新执行本方法, 两个参数互换
	if (p2.indexX < p1.indexX)
		return [self linkWithBeginPiece:p2 endPiece:p1];
	// 获取p1的中心点
	FKPoint* p1Point = [p1 getCenter];
	// 获取p2的中心点
	FKPoint* p2Point = [p2 getCenter];
	// 如果两个FKPiece在同一行
	if (p1.indexY == p2.indexY) //①
	{
       
		// 它们在同一行并可以相连, 没有转折点
		if (![self isXBlockFromP1:p1Point toP2:p2Point pieceWidth:Width/(xSize+a)])
		{
			return [[FKLinkInfo alloc] initWithP1:p1Point p2:p2Point];
		
        }
        	}
	// 如果两个FKPiece在同一列
	if (p1.indexX == p2.indexX) //②
	{
       		// 它们在同一列并可以相连, 没有转折点
		if (![self isYBlockFromP1:p1Point toP2:p2Point pieceHeight:Width/(xSize+a)])
		{
			return [[FKLinkInfo alloc] initWithP1:p1Point p2:p2Point];
		}
        	}
	// 有一个转折点的情况
	// 获取两个点的直角相连的点, 即只有一个转折点
    
	FKPoint* cornerPoint = [self getCornerPointFromStartPoint:p1Point
		toPoint:p2Point width:Width/(xSize+a) height: Width/(xSize+a)];
    //③
	if (cornerPoint != nil)
	{
		return [[FKLinkInfo alloc] initWithP1:p1Point
			p2:cornerPoint p3:p2Point];
	}
	// 该NSDictionaryp的key存放第一个转折点, value存放第二个转折点,
	// NSDictionary的count说明有多少种可以连的方式
	NSDictionary* turns = [self getLinkPointsFromPoint:p1Point
		toPoint:p2Point width:Width/(xSize+a) height:Width/(xSize+a)];
    //④
	if (turns.count != 0)
	{
		return [self getShortcutFromPoint:p1Point toPoint:p2Point
			turns:turns distance:
			[self getDistanceFromPoint:p1Point toPoint:p2Point]];
	}
    	return nil;
}
//自动消除 💣
//
- (FKLinkInfo*) linkWithBeginPieceboom:(FKPiece*)p1 endPiece:(FKPiece*)p2;
{
    // 两个FKPiece是同一个, 即选中了同一个方块, 返回nil
    if (p1 == p2)
        return @"uit";
    // 如果p1的图片与p2的图片相同, 则返回nil
    if ([p1 isEqual:p2])
        return nil;
    //如果图片不同 则返回空
    if (![p1 isEqual:p2]) {
        return @"uit";
    }
    return nil;
}
/**
 * 判断两个y坐标相同的点对象之间是否有障碍, 以p1为中心向右遍历
 * @return 两个FKPiece之间有障碍返回YES，否则返回NO
 */
- (BOOL) isXBlockFromP1:(FKPoint*)p1 toP2:(FKPoint*)p2
	pieceWidth:(CGFloat) pieceWidth
{
	if (p2.x < p1.x)
	{
		// 如果p2在p1左边, 调换参数位置调用本方法
		return [self isXBlockFromP1:p2 toP2:p1 pieceWidth:pieceWidth];
	}
	for (int i = p1.x + pieceWidth; i < p2.x; i = i + pieceWidth)
	{
		// 有障碍
		if([self hasPieceAtX:i y:p1.y])
		{
			return YES;
		}
	}
	return NO;
}

/**
 * 判断两个x坐标相同的点对象之间是否有障碍, 以p1为中心向下遍历
 * @return 两个FKPiece之间有障碍返回YES，否则返回NO
 */
- (BOOL) isYBlockFromP1:(FKPoint*) p1 toP2:(FKPoint*) p2
							pieceHeight:(CGFloat) pieceHeight
{
	if (p2.y < p1.y)
	{
		// 如果p2在p1的上面, 调换参数位置重新调用本方法
		return [self isYBlockFromP1:p2 toP2:p1
				pieceHeight:pieceHeight];
	}
	for (int i = p1.y + pieceHeight; i < p2.y; i = i + pieceHeight)
	{
		// 有障碍
		if([self hasPieceAtX:p1.x y:i])
		{
			return YES;
		}
	}
	return NO;
}

/**
 * 判断界面上的x, y坐标中是否有Piece对象
 *
 * @param x
 * @param y
 * @return YES 表示有该坐标有piece对象 FALSE 表示没有
 */
- (BOOL) hasPieceAtX:(NSInteger) x y:(NSInteger) y
{
	return [[self findPieceAtTouchX:x touchY:y] class] == FKPiece.class;
}

/**
 * 获取两个转折点的情况
 * @return NSDictionary对象的每个key-value对代表一种连接方式，
 * 其中key、value分别代表第1个、第2个连接点
 */
- (NSDictionary*) getLinkPointsFromPoint:(FKPoint*) point1
	toPoint:(FKPoint*) point2 width:(NSInteger)pieceWidth
	height:(NSInteger)pieceHeight
{
//    if(a>0 && a<5){
	NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
	// 获取以point1为中心的向上, 向右, 向下的通道
	NSArray* p1UpChanel = [self getUpChanelFromPoint:point1
		min:point2.y height:pieceHeight];
	NSArray* p1RightChanel = [self getRightChanelFromPoint:point1
		max:point2.x width:pieceWidth];
	NSArray* p1DownChanel = [self getDownChanelFromPoint:point1
		max:point2.y height:pieceHeight];
	// 获取以point2为中心的向下, 向左, 向上的通道
	NSArray* p2DownChanel = [self getDownChanelFromPoint:point2
		max:point1.y height:pieceHeight];
	NSArray* p2LeftChanel = [self getLeftChanelFromPoint:point2
		min:point1.x width:pieceWidth];
	NSArray* p2UpChanel = [self getUpChanelFromPoint:point2
		min:point1.y height:pieceHeight];
   //---------------------------
	// 获取FKBaseBoard的最大高度
  
	NSInteger heightMax = (ySize+a+1 ) * pieceHeight + beginImageY;
	// 获取FKBaseBoard的最大宽度
	NSInteger widthMax = (xSize+a+1 ) * pieceWidth + beginImageX;
    
	// 先确定两个点的关系, point2在point1的左上角或者左下角
	if ([self isLeftUpP1:point1 p2:point2]
		|| [self isLeftDownP1:point1 p2:point2])
	{
		// 参数换位, 调用本方法
		return [self getLinkPointsFromPoint:point2 toPoint:point1
			width:pieceWidth height:pieceWidth];
	}
	// p1、p2位于同一行不能直接相连
	if (point1.y == point2.y)
	{
		// 在同一行,向上遍历
		// 以point1的中心点向上遍历获取点集合
		p1UpChanel = [self getUpChanelFromPoint:point1
			min:0 height:pieceHeight];
		// 以point2的中心点向上遍历获取点集合
		p2UpChanel = [self getUpChanelFromPoint:point2
			min:0 height:pieceHeight];
		NSDictionary* upLinkPoints = [self getXLinkPoints:p1UpChanel
			p2Chanel:p2UpChanel pieceWidth:pieceHeight];
		// 向下遍历,不超过Board(有方块的地方)的边框
		// 以p1中心点向下遍历获取点集合
		p1DownChanel = [self getDownChanelFromPoint:point1
			max:heightMax height:pieceHeight];
		// 以p2中心点向下遍历获取点集合
		p2DownChanel = [self getDownChanelFromPoint:point2
			max:heightMax height:pieceHeight];
		NSDictionary* downLinkPoints = [self getXLinkPoints:p1DownChanel
			p2Chanel:p2DownChanel pieceWidth:pieceHeight];
		[result addEntriesFromDictionary:upLinkPoints];
		[result addEntriesFromDictionary:downLinkPoints];
	}
	// p1、p2位于同一列不能直接相连
	if (point1.x == point2.x)
	{
		// 在同一列, 向左遍历
		// 以p1的中心点向左遍历获取点集合
		NSArray* p1LeftChanel = [self getLeftChanelFromPoint:point1
			min:0 width:pieceWidth];
		// 以p2的中心点向左遍历获取点集合
		p2LeftChanel = [self getLeftChanelFromPoint:point2
			min:0 width:pieceWidth];
		NSDictionary* leftLinkPoints = [self getYLinkPoints:p1LeftChanel
			p2Chanel:p2LeftChanel pieceHeight:pieceWidth];
		// 向右遍历, 不得超过Board的边框（有方块的地方）
		// 以p1的中心点向右遍历获取点集合
		p1RightChanel = [self getRightChanelFromPoint:point1
			max:widthMax width:pieceWidth];
		// 以p2的中心点向右遍历获取点集合
		NSArray* p2RightChanel = [self getRightChanelFromPoint:point2
			max:widthMax width:pieceWidth];
		NSDictionary* rightLinkPoints = [self getYLinkPoints:p1RightChanel
			p2Chanel:p2RightChanel pieceHeight:pieceWidth];
		[result addEntriesFromDictionary:leftLinkPoints];
		[result addEntriesFromDictionary:rightLinkPoints];
	}
	// point2位于point1的右上角
	if ([self isRightUpP1:point1 p2:point2])
	{
		// 获取point1向上遍历, point2向下遍历时横向可以连接的点
		NSDictionary* upDownLinkPoints = [self getXLinkPoints:p1UpChanel
			p2Chanel:p2DownChanel pieceWidth:pieceWidth];
		// 获取point1向右遍历, point2向左遍历时纵向可以连接的点
		NSDictionary* rightLeftLinkPoints = [self getYLinkPoints:p1RightChanel
			p2Chanel:p2LeftChanel pieceHeight:pieceHeight];
		// 获取以p1为中心的向上通道
		p1UpChanel = [self getUpChanelFromPoint:point1
			min:0 height:pieceHeight];
		// 获取以p2为中心的向上通道
		p2UpChanel = [self getUpChanelFromPoint:point2
			min:0 height:pieceHeight];
		// 获取point1向上遍历, point2向上遍历时横向可以连接的点
		NSDictionary* upUpLinkPoints = [self getXLinkPoints:p1UpChanel
			p2Chanel:p2UpChanel pieceWidth:pieceWidth];
		// 获取以p1为中心的向下通道
		p1DownChanel = [self getDownChanelFromPoint:point1
			max:heightMax height:pieceHeight];
		// 获取以p2为中心的向下通道
		p2DownChanel = [self getDownChanelFromPoint:point2
			max:heightMax height:pieceHeight];
		// 获取point1向下遍历, point2向下遍历时横向可以连接的点
		NSDictionary* downDownLinkPoints = [self getXLinkPoints:p1DownChanel
			p2Chanel:p2DownChanel pieceWidth:pieceWidth];
		// 获取以p1为中心的向右通道
		p1RightChanel = [self getRightChanelFromPoint:point1
			max:widthMax width:pieceWidth];
		// 获取以p2为中心的向右通道
		NSArray* p2RightChanel = [self getRightChanelFromPoint:point2
			max:widthMax width:pieceWidth];
		// 获取point1向右遍历, point2向右遍历时纵向可以连接的点
		NSDictionary* rightRightLinkPoints = [self getYLinkPoints:p1RightChanel
			p2Chanel:p2RightChanel pieceHeight:pieceHeight];
		// 获取以p1为中心的向左通道
		NSArray* p1LeftChanel = [self getLeftChanelFromPoint:point1
			min:0 width:pieceWidth];
		// 获取以p2为中心的向左通道
		p2LeftChanel = [self getLeftChanelFromPoint:point2
			min:0 width:pieceWidth];
		// 获取point1向左遍历, point2向右遍历时纵向可以连接的点
		NSDictionary* leftLeftLinkPoints = [self getYLinkPoints:p1LeftChanel
			p2Chanel:p2LeftChanel pieceHeight:pieceHeight];
		[result addEntriesFromDictionary:upDownLinkPoints];
		[result addEntriesFromDictionary:rightLeftLinkPoints];
		[result addEntriesFromDictionary:upUpLinkPoints];
		[result addEntriesFromDictionary:downDownLinkPoints];
		[result addEntriesFromDictionary:rightRightLinkPoints];
		[result addEntriesFromDictionary:leftLeftLinkPoints];
	}
	// point2位于point1的右下角
	if ([self isRightDownP1:point1 p2:point2])
	{
		// 获取point1向下遍历, point2向上遍历时横向可连接的点
		NSDictionary* downUpLinkPoints = [self getXLinkPoints:p1DownChanel
			p2Chanel:p2UpChanel pieceWidth:pieceWidth];
		// 获取point1向右遍历, point2向左遍历时纵向可连接的点
		NSDictionary* rightLeftLinkPoints = [self getYLinkPoints:p1RightChanel
			p2Chanel:p2LeftChanel pieceHeight:pieceHeight];
		// 获取以p1为中心的向上通道
		p1UpChanel = [self getUpChanelFromPoint:point1
			min:0 height:pieceHeight];
		// 获取以p2为中心的向上通道
		p2UpChanel = [self getUpChanelFromPoint:point2
			min:0 height:pieceHeight];
		// 获取point1向上遍历, point2向上遍历时横向可连接的点
		NSDictionary* upUpLinkPoints = [self getXLinkPoints:p1UpChanel
			p2Chanel:p2UpChanel pieceWidth:pieceWidth];
		// 获取以p1为中心的向下通道
		p1DownChanel = [self getDownChanelFromPoint:point1
			max:heightMax height:pieceHeight];
		// 获取以p2为中心的向下通道
		p2DownChanel = [self getDownChanelFromPoint:point2
			max:heightMax height:pieceHeight];
		// 获取point1向下遍历, point2向下遍历时横向可连接的点
		NSDictionary* downDownLinkPoints = [self getXLinkPoints:p1DownChanel
			p2Chanel:p2DownChanel pieceWidth:pieceWidth];
		// 获取以p1为中心的向左通道
		NSArray* p1LeftChanel = [self getLeftChanelFromPoint:point1
			min:0 width:pieceWidth];
		// 获取以p2为中心的向左通道
		p2LeftChanel = [self getLeftChanelFromPoint:point2
			min:0 width:pieceWidth];
		// 获取point1向左遍历, point2向左遍历时纵向可连接的点
		NSDictionary* leftLeftLinkPoints = [self getYLinkPoints:p1LeftChanel
			p2Chanel:p2LeftChanel pieceHeight:pieceHeight];
		// 获取以p1为中心的向右通道
		p1RightChanel = [self getRightChanelFromPoint:point1
			max:widthMax width:pieceWidth];
		// 获取以p2为中心的向右通道
		NSArray* p2RightChanel = [self getRightChanelFromPoint:point2
			max:widthMax width:pieceWidth];
		// 获取point1向右遍历, point2向右遍历时纵向可以连接的点
		NSDictionary* rightRightLinkPoints = [self getYLinkPoints:p1RightChanel
			p2Chanel:p2RightChanel pieceHeight:pieceHeight];
		[result addEntriesFromDictionary:downUpLinkPoints];
		[result addEntriesFromDictionary:rightLeftLinkPoints];
		[result addEntriesFromDictionary:upUpLinkPoints];
		[result addEntriesFromDictionary:downDownLinkPoints];
		[result addEntriesFromDictionary:leftLeftLinkPoints];
		[result addEntriesFromDictionary:rightRightLinkPoints];
	}
   	return result;
    
}

/**
 * 获取p1和p2之间最短的连接信息
 * @param p1 第一个点
 * @param p2 第二个点
 * @param turns 放转折点的NSDictionary
 * @param shortDistance 两点之间的最短距离
 * @return p1和p2之间最短的连接信息
 */
- (FKLinkInfo*) getShortcutFromPoint:(FKPoint*) p1 toPoint:(FKPoint*) p2
	turns:(NSDictionary*) turns distance:(NSInteger)shortDistance
{
	NSMutableArray* infos = [[NSMutableArray alloc] init];
	// 遍历结果NSDictionary
	for (FKPoint* point1 in turns)
	{
		FKPoint* point2 = turns[point1];
		// 将转折点与选择点封装成FKLinkInfo对象, 放到NSArray集合中
		[infos addObject:[[FKLinkInfo alloc]
			initWithP1:p1 p2:point1 p3:point2 p4:p2]];
	}
	return [self getShortcut:infos shortDistance:shortDistance];
}
/**
 * 从infos中获取连接线最短的那个FKLinkInfo对象
 * @param infos
 * @return 连接线最短的那个FKLinkInfo对象
 */
- (FKLinkInfo*) getShortcut:(NSArray*) infos shortDistance:(int) shortDistance
{
	int temp1 = 0;
	FKLinkInfo* result = nil;
	for (int i = 0; i < infos.count; i++)
	{
		FKLinkInfo* info = [infos objectAtIndex:i];
		// 计算出几个点的总距离
		NSInteger distance = [self countAll:info.points];
		// 将循环第一个的差距用temp1保存
		if (i == 0)
		{
			temp1 = distance - shortDistance;
			result = info;
		}
		// 如果下一次循环的值比temp1的还小, 则用当前的值作为temp1
		if (distance - shortDistance < temp1)
		{
			temp1 = distance - shortDistance;
			result = info;
		}
	}
	return result;
}

/**
 * 计算NSArray中所有点的距离总和
 * @param points 需要计算的连接点
 * @return 所有点的距离的总和
 */
- (NSInteger) countAll:(NSArray*) points
{
	NSInteger result = 0;
	for (int i = 0; i < points.count - 1; i++)
	{
		// 获取第i个点
		FKPoint* point1 = [points objectAtIndex:i];
		// 获取第i + 1个点
		FKPoint* point2 = [points objectAtIndex:i + 1];
		// 计算第i个点与第i + 1个点的距离，并添加到总距离中
		result += [self getDistanceFromPoint:point1 toPoint:point2];
	}
	return result;
}

/**
 * 获取两个点之间的最短距离
 * @param p1 第一个点
 * @param p2 第二个点
 * @return 两个点的距离距离总和
 */
- (CGFloat) getDistanceFromPoint:(FKPoint*) p1 toPoint:(FKPoint*) p2
{
	int xDistance = abs(p1.x - p2.x);
	int yDistance = abs(p1.y - p2.y);
	return xDistance + yDistance;
}

/**
 * 遍历两个集合, 先判断第一个集合的元素的x坐标与另一个集合中的元素x坐标相同(纵向),
 * 如果相同, 即在同一列, 再判断是否有障碍, 没有则加到NSMutableDictionary中去
 * @return 存放可以纵向直线连接的连接点的键值对
 */
- (NSDictionary*) getYLinkPoints:(NSArray*) p1Chanel
	p2Chanel:(NSArray*) p2Chanel pieceHeight:(NSInteger) pieceHeight
{
	NSMutableDictionary* result = [[NSMutableDictionary alloc]init];
	for (int i = 0; i < p1Chanel.count; i++)
	{
		FKPoint* temp1 = [p1Chanel objectAtIndex:i];
		for (int j = 0; j < p2Chanel.count; j++)
		{
			FKPoint* temp2 = [p2Chanel objectAtIndex:j];
			// 如果x坐标相同(在同一列)
			if (temp1.x == temp2.x)
			{
				// 没有障碍则加到结果的NSMutableDictionary中
				if (![self isYBlockFromP1:temp1 toP2:temp2 pieceHeight:pieceHeight])
				{
					[result setObject:temp2 forKey:temp1];
				}
			}
		}
	}
	return [result copy];
}

/**
 * 遍历两个集合, 先判断第一个集合的元素的y坐标与另一个集合中的元素y坐标相同(横向),
 * 如果相同, 即在同一行, 再判断是否有障碍, 没有则加到NSMutableDictionary中去
 * @return 存放可以横向直线连接的连接点的键值对
 */
- (NSDictionary*) getXLinkPoints:(NSArray*) p1Chanel
	p2Chanel:(NSArray*) p2Chanel pieceWidth:(NSInteger) pieceWidth
{
	NSMutableDictionary* result = [[NSMutableDictionary alloc]init];
	for (int i = 0; i < p1Chanel.count; i++)
	{
		// 从第一通道中取一个点
		FKPoint* temp1 = [p1Chanel objectAtIndex:i];
		// 再遍历第二个通道, 看下第二通道中是否有点可以与temp1横向相连
		for (int j = 0; j < p2Chanel.count; j++)
		{
			FKPoint* temp2 = [p2Chanel objectAtIndex:j];
			// 如果y坐标相同(在同一行), 再判断它们之间是否有直接障碍
			if (temp1.y == temp2.y)
			{
				if (![self isXBlockFromP1:temp1 toP2:temp2 pieceWidth:pieceWidth])
				{
					// 没有障碍则加到结果的NSMutableDictionary中
					[result setObject:temp2 forKey:temp1];
				}
			}
		}
	}
	return [result copy];
}

/**
 * 判断point2是否在point1的左上角
 * @return p2位于p1的左上角时返回YES，否则返回NO
 */
- (BOOL) isLeftUpP1:(FKPoint*) point1 p2:(FKPoint*) point2
{
	return (point2.x < point1.x && point2.y < point1.y);
}
/**
 * 判断point2是否在point1的左下角
 * @return p2位于p1的左下角时返回YES，否则返回NO
 */
- (BOOL) isLeftDownP1:(FKPoint*) point1 p2:(FKPoint*) point2
{
	return (point2.x < point1.x && point2.y > point1.y);
}
/**
 * 判断point2是否在point1的右上角
 * @return p2位于p1的右上角时返回YES，否则返回NO
 */
- (BOOL) isRightUpP1:(FKPoint*) point1 p2:(FKPoint*) point2
{
	return (point2.x > point1.x && point2.y < point1.y);
}
/**
 * 判断point2是否在point1的右下角
 * @return p2位于p1的右下角时返回YES，否则返回NO
 */
- (BOOL) isRightDownP1:(FKPoint*) point1 p2:(FKPoint*) point2
{
	return (point2.x > point1.x && point2.y > point1.y);
}
/**
 * 获取两个不在同一行或者同一列的坐标点的直角连接点, 即只有一个转折点
 * @param point1 第一个点
 * @param point2 第二个点
 * @return 两个不在同一行或者同一列的坐标点的直角连接点
 */
-(FKPoint*) getCornerPointFromStartPoint:(FKPoint*) point1
	toPoint:(FKPoint*) point2 width:(NSInteger) pieceWidth
	height:(NSInteger) pieceHeight
{
	// 先判断这两个点的位置关系
	// point2在point1的左上角, point2在point1的左下角
	if ([self isLeftUpP1: point1 p2:point2] ||
		[self isLeftDownP1:point1 p2:point2])
	{
		// 参数换位, 重新调用本方法
		return [self getCornerPointFromStartPoint:point2 toPoint:point1
			width:pieceWidth height:pieceHeight];
	}
	// 获取point1向右, 向上, 向下的三个通道
	NSArray* point1RightChanel = [self getRightChanelFromPoint:point1
		max:point2.x width:pieceWidth];
	NSArray* point1UpChanel = [self getUpChanelFromPoint:point1
		min:point2.y height:pieceHeight];
	NSArray* point1DownChanel = [self getDownChanelFromPoint:point1
		max:point2.y height:pieceHeight];
	// 获取point2向下, 向左, 向下的三个通道
	NSArray* point2DownChanel = [self getDownChanelFromPoint:point2
		max:point1.y height:pieceHeight];
	NSArray* point2LeftChanel = [self getLeftChanelFromPoint:point2
		min:point1.x width:pieceWidth];
	NSArray* point2UpChanel = [self getUpChanelFromPoint:point2
		min:point1.y height:pieceHeight];
	if ([self isRightUpP1:point1 p2:point2])
	{
		// point2在point1的右上角
		// 获取p1向右和p2向下的交点
		FKPoint* linkPoint1 = [self getWrapPointChanel1:point1RightChanel
			chanel2:point2DownChanel];
		// 获取p1向上和p2向左的交点
		FKPoint* linkPoint2 = [self getWrapPointChanel1:point1UpChanel
			chanel2:point2LeftChanel];
		// 返回其中一个交点, 如果没有交点, 则返回nil
		return (linkPoint1 == nil) ? linkPoint2 : linkPoint1;
	}
	if ([self isRightDownP1:point1 p2:point2])
	{
		// point2在point1的右下角
		// 获取p1向下和p2向左的交点
		FKPoint* linkPoint1 = [self getWrapPointChanel1:point1DownChanel
				chanel2:point2LeftChanel];
		// 获取p1向右和p2向下的交点
		FKPoint* linkPoint2 = [self getWrapPointChanel1:point1RightChanel
				chanel2:point2UpChanel];
		return (linkPoint1 == nil) ? linkPoint2 : linkPoint1;
	}
	return nil;
}

/**
 * 遍历两个通道, 获取它们的交点
 * @param p1Chanel 第一个点的通道
 * @param p2Chanel 第二个点的通道
 * @return 两个通道有交点，返回交点，否则返回nil
 */
- (FKPoint*) getWrapPointChanel1:(NSArray*)p1Chanel chanel2:(NSArray*)p2Chanel
{
	for (int i = 0; i < p1Chanel.count; i++)
	{
		FKPoint* temp1 = [p1Chanel objectAtIndex:i];
		for (int j = 0; j < p2Chanel.count; j++)
		{
			FKPoint* temp2 = [p2Chanel objectAtIndex:j];
			if ([temp1 isEqual:temp2])
			{
				// 如果两个NSArray中有元素有同一个, 表明这两个通道有交点
				return temp1;
			}
		}
	}
	return nil;
}

/**
 * 返回指定FKPoint对象的左边通道
 * @param p 给定的FKPoint参数
 * @param pieceWidth piece图片的宽
 * @param min 向左遍历时最小的界限
 * @return 给定Point左边的通道
 */
- (NSArray*) getLeftChanelFromPoint:(FKPoint*)p min:(NSInteger)min
	width:(NSInteger)pieceWidth
{
	NSMutableArray* result = [[NSMutableArray alloc] init];
	// 获取向左通道, 由一个点向左遍历, 步长为FKPiece图片的宽
	for (int i = p.x - pieceWidth; i >= min
		 ; i = i - pieceWidth)
	{
		// 遇到障碍, 表示通道已经到尽头, 直接返回
		if ([self hasPieceAtX:i y:p.y])
		{
			return result;
		}
		[result addObject:[[FKPoint alloc] initWithX:i y:p.y]];
	}
	return result;
}

/**
 * 返回指定FKPoint对象的右边通道
 * @param p 给定的FKPoint参数
 * @param pieceWidth
 * @param max 向右时的最右界限
 * @return 给定Point右边的通道
 */
- (NSArray*) getRightChanelFromPoint:(FKPoint*)p max:(NSInteger)max
	width:(NSInteger)pieceWidth
{
	NSMutableArray* result = [[NSMutableArray alloc] init];
	// 获取向右通道, 由一个点向右遍历, 步长为FKPiece图片的宽
	for (int i = p.x + pieceWidth; i <= max
		 ; i = i + pieceWidth)
	{
		// 遇到障碍, 表示通道已经到尽头, 直接返回
		if ([self hasPieceAtX:i y:p.y])
		{
			return result;
		}
		[result addObject:[[FKPoint alloc] initWithX:i y:p.y]];		
	}
	return result;
}

/**
 * 返回指定FKPoint对象的上边通道
 * @param p 给定的FKPoint参数
 * @param min 向上遍历时最小的界限
 * @param pieceHeight
 * @return 给定Point上面的通道
 */
- (NSArray*) getUpChanelFromPoint:(FKPoint*)p min:(NSInteger)min
	height:(NSInteger)pieceHeight
{
	NSMutableArray* result = [[NSMutableArray alloc] init];
	// 获取向上通道, 由一个点向上遍历, 步长为FKPiece图片的高
	for (int i = p.y - pieceHeight; i >= min
		 ; i = i - pieceHeight)
	{
		// 遇到障碍, 表示通道已经到尽头, 直接返回
		if ([self hasPieceAtX:p.x y:i])
		{
			// 如果遇到障碍, 直接返回
			return result;
		}
		[result addObject:[[FKPoint alloc] initWithX:p.x y:i]];
	}
	return result;
}
/**
 * 返回指定FKPoint对象的下边通道
 * @param p 给定的FKPoint参数
 * @param max 向上遍历时的最大界限
 * @return 给定Point下面的通道
 */
- (NSArray*) getDownChanelFromPoint:(FKPoint*)p max:(NSInteger)max
	height:(NSInteger)pieceHeight
{
	NSMutableArray* result = [[NSMutableArray alloc] init];
	// 获取向下通道, 由一个点向下遍历, 步长为FKPiece图片的高
	for (int i = p.y + pieceHeight; i <= max
		 ; i = i + pieceHeight)
	{
		// 遇到障碍, 表示通道已经到尽头, 直接返回
		if ([self hasPieceAtX:p.x y:i])
		{
			// 如果遇到障碍, 直接返回
			return result;
		}
		[result addObject:[[FKPoint alloc] initWithX:p.x y:i]];
	}
	return result;
}
@end