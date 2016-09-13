//
//  Constants.h
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#ifndef Link_Constants_h
#define Link_Constants_h
// 设置连连看的每个方块的图片的宽、高
//#define PIECE_WIDTH 40
//#define PIECE_HEIGHT 40
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
// 记录游戏的总时间（100秒）
#define DEFAULT_TIME 40
// FKPiece二维数组第一维的长度
#define xSize 3
// FKPiece二维数组第二维的长度
#define ySize 4
// Board中第一张图片出现的x座标
#define beginImageX 2
// Board中第一张图片出现的y座标
#define beginImageY 25
#endif
