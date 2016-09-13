//
//  FKViewController.h
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FKGameView.h"



@interface FKViewController : UIViewController <UIAlertViewDelegate
	, FKGameViewDelegate>
//代理在FKGameView的文件中定义

@property (strong, nonatomic)  UIButton *startBn;
@property(strong,nonatomic)UIButton * Fan;
@property (strong, nonatomic)  UILabel *timeText;
@property(strong,nonatomic)UILabel * lbl;
@property(strong,nonatomic)UIButton * addtime;
@property(strong,nonatomic)UIButton * zhadan;

//@property(nonatomic,assign)int k;
@property(nonatomic,assign)int g;

@end
