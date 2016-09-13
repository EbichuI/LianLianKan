//
//  WFKViewController.m
//  Link
//
//  Created by stu024 on 15/11/9.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "WFKViewController.h"
#import "FKGameView.h"
#import "Constants.h"
#import "FKPiece.h"
#import "LeiViewController.h"
#import <AVFoundation/AVFoundation.h>
#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height


@interface WFKViewController ()

@end

@implementation WFKViewController
@synthesize startBn,Fan,lbl;
@synthesize timeText;

int fenshu;
int k;




// 游戏界面类
FKGameView* gameView;
// 游戏剩余时间
NSInteger leftTime;
// 定时器
NSTimer* timer;

BOOL isPlaying;
UIAlertView* lostAlert;
UIAlertView* successAlert;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //    lbl=[[UILabel alloc]initWithFrame:CGRectMake(240, 20, 80, 30)];
    //    [self.view addSubview:lbl];
    //    fenshu=0;
    //lbl.text=[NSString stringWithFormat:@"%d",fenshu];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startGame2:) name:@"wujinmoshi" object:nil];
    
      

    startBn=[[UIButton alloc] initWithFrame:CGRectMake(width-300,height-150, 100, 66)];
    [startBn setTitle:@"开💩" forState:UIControlStateNormal];
    [startBn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIApplication sharedApplication].statusBarHidden = YES;
    timeText=[[UILabel alloc] initWithFrame:CGRectMake(150, 440, 200, 66)];
    self.timeText.textColor = [UIColor colorWithRed:1 green:1
                                               blue: 9/15 alpha:1];
    UIImage * img=[UIImage imageNamed:@"0.png"];
    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imgview.image=img;
    //    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(width, 0, width, height)];
    //    [view addSubview:imgview];
    [self.view addSubview:imgview];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(160, 30, 130, 30)];
    lbl.text=[NSString stringWithFormat:@"游戏得分：%d",fenshu];
//    [self.view addSubview:lbl];
    
    
    
    // 使用room.jpg作为游戏背景图片
    //    UIColor *bgColor = [UIColor colorWithPatternImage:
    //                        [UIImage imageNamed:@"youxi.jpg"]];
    //    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    //    imgview.image=img;
    //    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(width, 0, width, height)];
    //    [view addSubview:imgview];
    
    // self.view.backgroundColor = bgColor;
    // 为startBn按钮设置图片
    //[self.startBn setBackgroundImage:[UIImage imageNamed:@"12.jpg"]
    //  forState:UIControlStateNormal];
    //[self.startBn setBackgroundImage:[UIImage imageNamed:@"12.jpg"]
    //  forState:UIControlStateHighlighted];
    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.startBn addTarget:self action:@selector(startGame2:)
           forControlEvents:UIControlEventTouchUpInside];
    //返回按钮   自创
    Fan=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 50, 30)];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [Fan setTitle:@"返回" forState:UIControlStateNormal];
    [Fan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [startBn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [self.Fan addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
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
     [self.view addSubview:lbl];
    // 初始化游戏失败的对话框
    lostAlert = [[UIAlertView alloc] initWithTitle:@"失败！"
                                           message:@"游戏失败！继续游戏？"delegate:self
                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    // 初始化游戏胜利的对话框
    successAlert = [[UIAlertView alloc] initWithTitle:@"胜利！"
                                              message:@"游戏胜利！继续游戏？"delegate:self
                                    cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
}
//-(void)chuli:(NSNotification *)n
//{
//    k=[[n object]intValue];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ahaha" object:nil];
//
//
//}
- (void) startGame2:(int)k
{
    
    //    UIImage * img=[UIImage imageNamed:@"1.png"];
    //    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    //    imgview.image=img;
    //    [self.view addSubview:imgview];
    
    // 如果之前的timer还未取消，取消timer
    k=5;
  

    fenshu=0;
    // 开始新的游戏游戏
    [gameView startGame:k];
    isPlaying = YES;
    gameView.selectedPiece = nil;
}
- (void) refreshView3
{
    //self.timeText.text = [NSString stringWithFormat:@"剩余时间：%d",leftTime];
    //leftTime--;
//    lbl.text=[NSString stringWithFormat:@"%d",fenshu];
    // 时间小于0, 游戏失败
//    if (leftTime < 0)
//    {
//        [timer invalidate];
//        // 更改游戏的状态
//        isPlaying = NO;
//        [lostAlert show];
//        return;
//    }
}
-(void)fanhui
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fanhui" object:nil];

    [timer invalidate];
    // 更改游戏状态
    isPlaying = NO;
  

}

-(void) alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if(leftTime<0){
        // 如果用户选中的“确定”按钮
        if(buttonIndex == 1)
        {
            //        [self startGame:k];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"wujinmoshi" object:@5];
         
            
            k=5;
            // 开始新的游戏游戏
            [gameView startGame:k];
            isPlaying = YES;
            gameView.selectedPiece = nil;
        }
        else
        {
            [self fanhui];
        }
    
}

- (void)checkWin:(FKGameView *)gameView
{
    {
    // 判断是否还有剩下的方块, 如果没有, 游戏胜利
    fenshu=fenshu+10;
    lbl.text=[NSString stringWithFormat:@"游戏得分：%d",fenshu];
    if (![gameView.gameService hasPieces])        // 游戏胜利
        [successAlert show];
        // 停止定时器
        [timer invalidate];
        // 更改游戏状态
        isPlaying = NO;
    }
}

@end
