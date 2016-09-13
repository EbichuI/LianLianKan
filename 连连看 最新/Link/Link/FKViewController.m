//
//  FKViewController.m
//  Link
//
//  Created by yeeku on 13-7-16.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "FKViewController.h"
#import "FKGameView.h"
#import "Constants.h"
#import "FKPiece.h"
#import "LeiViewController.h"
#import "BlViewController.h"
#import "Hand.h"
#import "BFKViewController.h"
#import <AVFoundation/AVFoundation.h>
#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

@interface FKViewController ()

@end

@implementation FKViewController
@synthesize startBn,Fan,lbl,addtime,zhadan;
@synthesize timeText,g;

int fenshu;
int k;
int j;
int boom;
int b;
int t;
UIButton * tishi;
// 游戏界面类
FKGameView* gameView;
// 游戏剩余时间
NSInteger leftTime;
// 定时器
NSTimer* timer;

BOOL isPlaying;
UIAlertView* lostAlert;
UIAlertView* successAlert;
UIAlertView* zan;
- (void)viewDidLoad
{
    fenshu=0;
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startGame:) name:@"xuanguan" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jixuyouxi) name:@"jixuyouxi" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startGameC:) name:@"chongxin" object:nil];
    
      addtime=[[UIButton alloc]initWithFrame:CGRectMake(width-280,height-150, 100, 66)];
    [addtime setTitle:@"加时器 ⏳" forState:UIControlStateNormal];
    [self.addtime addTarget:self action:@selector(jiashi) forControlEvents:UIControlEventTouchUpInside];
    
    zhadan=[[UIButton alloc]initWithFrame:CGRectMake(width-160,height-150, 100, 66)];
    [zhadan setTitle:@"炸弹 💣" forState:UIControlStateNormal];
    [self.zhadan addTarget:self action:@selector(baozha) forControlEvents:UIControlEventTouchUpInside];
    
    tishi=[[UIButton alloc]initWithFrame:CGRectMake(width-280,height-110, 100, 66)];
    [tishi setTitle:@"提示器 ⏰" forState:UIControlStateNormal];
    [tishi addTarget:self action:@selector(tishi) forControlEvents:UIControlEventTouchUpInside];
    
    [startBn setTitle:@"开💩" forState:UIControlStateNormal];

    [UIApplication sharedApplication].statusBarHidden = YES;
    timeText=[[UILabel alloc] initWithFrame:CGRectMake(100, 30, 150, 30)];
    self.timeText.textColor = [UIColor colorWithRed:0 green:0
                                               blue:0 alpha:1];
    UIImage * img=[UIImage imageNamed:@"0.png"];
    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imgview.image=img;
    [self.view addSubview:imgview];

    lbl=[[UILabel alloc]initWithFrame:CGRectMake(240, 30, 80, 30)];
    [self.view addSubview:lbl];
     [self.view addSubview:addtime];
    [self.view addSubview:zhadan];
    [self.view addSubview:tishi];
    // 为startBn按钮设置图片
    //[self.startBn setBackgroundImage:[UIImage imageNamed:@"12.jpg"]
                          //  forState:UIControlStateNormal];
    //[self.startBn setBackgroundImage:[UIImage imageNamed:@"12.jpg"]
                          //  forState:UIControlStateHighlighted];
    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.startBn addTarget:self action:@selector(startGame:)
           forControlEvents:UIControlEventTouchUpInside];
    //返回按钮   自创
    Fan=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 50, 30)];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [Fan setTitle:@"👍👂" forState:UIControlStateNormal];
    [self.Fan addTarget:self action:@selector(zhanting) forControlEvents:UIControlEventTouchUpInside];
    // 创建FKGameView控件
    gameView = [[FKGameView alloc] initWithFrame:CGRectMake(0, 20, 320, 420)];
    // 创建FKGameService对象
    gameView.gameService = [[FKGameService alloc] init];
    gameView.delegate = self;
    gameView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gameView];
    [self.view addSubview:startBn];
    
    [self.view addSubview:timeText];
    [self.view addSubview:Fan];
    // 初始化游戏失败的对话框
    lostAlert = [[UIAlertView alloc] initWithTitle:@"游戏失败！"
                                           message:@"请选择:" delegate:self
                                 cancelButtonTitle:@"返回菜单" otherButtonTitles:@"继续游戏", nil];
    // 初始化游戏胜利的对话框
    successAlert = [[UIAlertView alloc] initWithTitle:@"游戏胜利！"
                                              message:@"请选择:" delegate:self
                                    cancelButtonTitle:@"返回菜单" otherButtonTitles:@"继续游戏", nil];
    lostAlert.tag=101;
    successAlert.tag=102;
}
-(void)jiashi
{
    if(j>0){
        leftTime=leftTime+15;
        j--;
        if (j==2) {
            [addtime setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        }
        if (j==1) {
            [addtime setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
    else
    {
    leftTime=leftTime;
    [addtime setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}
- (void) startGame:(NSNotification *) n
{
    j=3;
    b=2;
    t=1;
    // 如果之前的timer还未取消，取消timer
    
    k=[[n object]intValue];
//    NSLog(@"%d",k);
    if (timer != nil)
    {
        [timer invalidate];//有效的，时间开启
    }
    // 重新设置游戏时间
    leftTime = DEFAULT_TIME+k*8;
    fenshu=0;
    
    // 开始新的游戏游戏
    [gameView startGame:k];
    isPlaying = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView1) userInfo:nil repeats:YES];
    // 将选中方块设为nil。
    gameView.selectedPiece = nil;
    [zhadan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addtime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tishi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.timeText.textColor=[UIColor blackColor];
}
- (void) startGameC:(NSNotification *) n
{
    j=3;
    b=2;
    t=1;
    // 如果之前的timer还未取消，取消timer
    k=[[n object]intValue];
    //    NSLog(@"%d",k);
    if (timer != nil)
    {
        [timer invalidate];//有效的，时间开启
    }
    // 重新设置游戏时间
    leftTime = DEFAULT_TIME+k*8;
    fenshu=0;
    
    // 开始新的游戏游戏
    [gameView startGame:k];
    isPlaying = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView1) userInfo:nil repeats:YES];
    // 将选中方块设为nil。
    gameView.selectedPiece = nil;
    [zhadan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addtime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.timeText.textColor=[UIColor blackColor];
    [tishi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

   }

- (void) refreshView1
{
    self.timeText.text = [NSString stringWithFormat:@"剩余⏳：%ld",leftTime];
    leftTime--;
    if (leftTime<15) {
        self.timeText.textColor=[UIColor orangeColor];
    }
    if (leftTime<8) {
        self.timeText.textColor=[UIColor redColor];
    }
   // shuchu=fenshu;
    lbl.text=[NSString stringWithFormat:@"得分:%d",fenshu];
    // 时间小于0, 游戏失败
//    shuchu=fenshu;
    if (leftTime < 0)
    {
        
        [timer invalidate];
        // 更改游戏的状态
        isPlaying = NO;
        [lostAlert show];
            return;
    }
}
-(void)zhanting
{
    NSLog(@"11111111");
    [timer invalidate];
    // 更改游戏状态
    isPlaying = NO;
    zan = [[UIAlertView alloc] initWithTitle:@"游戏已暂停！"
                                     message:@"请选择:" delegate:self
                           cancelButtonTitle:@"继续游戏" otherButtonTitles:@"重新开始",@"返回菜单" ,nil];
    [zan show];
    zan.tag=100;
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:nil];
}
- (void) alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if(leftTime<0){
    NSLog(@"%d",fenshu);
    switch (alertView.tag) {
        case 101:
            if(buttonIndex == 1)
            {
                //        [self startGame:k];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@(k)];
            }
            else
            {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:nil];
            }

            break;
            case 102:
            if(buttonIndex == 1)
            {
                //        [self startGame:k];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@(k)];
            }
            else
            {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:nil];
            }
            break;
            case 100:
            if(buttonIndex == 1)
                    {
                        
                        //        [self startGame:k];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"chongxin" object:@(k)];
                    }
                    if(buttonIndex == 2)
                    {
                        
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:nil];
                    }
                    if(buttonIndex == 0)
                    {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"jixuyouxi" object:nil];
                        
                    }
            break;

        default:
            break;
    }
       }

- (void)checkWin:(FKGameView *)gameView
{
    // 判断是否还有剩下的方块, 如果没有, 游戏胜利
    fenshu=fenshu+10;
    if (![gameView.gameService hasPieces])
    {
        // 游戏胜利
        [successAlert show];
        // 停止定时器
        [timer invalidate];
        // 更改游戏状态
        isPlaying = NO;
                  }
    
}
-(void)baozha
{
    if(b>0){
    FKGameView* boom;
    boom=[[FKGameView alloc]init];
        [boom booooo];
        b--;
        if (b==1) {
             [zhadan setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
    else
    {
        [zhadan setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
//
}
-(void)jixuyouxi
{
    leftTime=leftTime;
    fenshu=fenshu;
      isPlaying = YES;
    if (timer != nil)
    {
        [timer invalidate];//有效的，时间开启
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView1) userInfo:nil repeats:YES];
}
-(void)tishi
{
//     k=[[n object]intValue];
  if (t>0) {
       [gameView autohik];
      t--;
      [tishi setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  }

//}
//    else
//    {
//        [tishi setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    }
   
}
@end
