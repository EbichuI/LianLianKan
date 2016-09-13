//
//  WFKViewController.h
//  Link
//
//  Created by stu024 on 15/11/9.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "FKViewController.h"
#import "FKGameView.h"
@interface WFKViewController : FKViewController<UIAlertViewDelegate
, FKGameViewDelegate,UIActionSheetDelegate>
//代理在FKGameView的文件中定义
@property (strong, nonatomic)  UIButton *startBn;
@property(strong,nonatomic)UIButton * Fan;
@property (strong, nonatomic)  UILabel *timeText;
@property(strong,nonatomic)UILabel * lbl;


@end
