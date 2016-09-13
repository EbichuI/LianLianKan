//
//  FKPieceImage.h
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKPieceImage : NSObject
//图片
@property (nonatomic, strong) UIImage* image;
//图片编号
@property (nonatomic, copy) NSString* imageId;
//图片初始化方法
- (id)initWithImage:(UIImage*)image imageId:(NSString*)imageId;
@end
