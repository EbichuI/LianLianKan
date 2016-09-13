//
//  BFKViewController.h
//  Link
//
//  Created by stu024 on 15/11/9.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "FKViewController.h"
#import "FKGameView.h"
@interface BFKViewController : FKViewController<UIAlertViewDelegate
, FKGameViewDelegate>
//代理在FKGameView的文件中定义
@property (strong, nonatomic)  UIButton *startBn;
@property(strong,nonatomic)UIButton * Fan;
@property (strong, nonatomic)  UILabel *timeText;
@property(strong,nonatomic)UILabel * lbl;
@property(strong,nonatomic)UIButton * addtime1;
@property(strong,nonatomic)UIButton * zhadan1;
@property(strong,nonatomic)UIButton * luan;
@property(nonatomic,assign)int g;

NSArray* imageValues();
NSMutableArray* getRandomValues(NSArray* sourceValues , NSInteger size);
NSArray* getPlayValues(NSInteger size);
NSArray* getPlayImages(int size);
@end
