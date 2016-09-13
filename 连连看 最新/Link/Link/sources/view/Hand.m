//
//  Hand.m
//  Link
//
//  Created by stu024 on 15/11/11.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "Hand.h"
#import "FKViewController.h"
@implementation Hand
int _curX;
int _curY;
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取触碰点
    UITouch * touch=[touches anyObject];
    //得到当前的触碰点
    CGPoint lastTouch=[touch locationInView:self];
    //获取触碰点坐标
    _curX=lastTouch.x;
    _curX=lastTouch.y;
    //同志该组建重会
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
    //获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx,[[UIColor redColor]CGColor]);
    //以触碰点为圆心 花园
    CGContextFillEllipseInRect(ctx, CGRectMake(_curX-10, _curY-10, 20, 20));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
