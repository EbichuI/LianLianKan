//
//  FKBaseBoard.h
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import <Foundation/Foundation.h>
//基本的面板逻辑
@interface FKBaseBoard : NSObject
//存放方块的集合
- (NSArray*) createPieces:(NSArray*)pieces;
- (NSArray*) create:(int)k;
@end
