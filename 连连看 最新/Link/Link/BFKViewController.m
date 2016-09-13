//
//  BFKViewController.m
//  Link
//
//  Created by stu024 on 15/11/9.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "BFKViewController.h"
#import "FKGameView.h"
#import "Constants.h"
#import "FKPiece.h"
#import "LeiViewController.h"
#import <AVFoundation/AVFoundation.h>
#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

@interface BFKViewController ()

@end

@implementation BFKViewController
@synthesize startBn,Fan,lbl,g,addtime,zhadan,luan;
@synthesize timeText;

int fenshu;
int k;
int p;
int bb;
int tt;


// 游戏界面类
FKGameView* gameView;
// 游戏剩余时间
NSInteger leftTime;
// 定时器
NSTimer* timer;
UIImageView* iv1;
// 定义定时器
NSTimer* timer;
BOOL isPlaying;
UIAlertView* lostAlert;
UIAlertView* successAlert;
UIAlertView* zhan;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    lbl=[[UILabel alloc]initWithFrame:CGRectMake(240, 20, 80, 30)];
    //    [self.view addSubview:lbl];
    //    fenshu=0;
    //lbl.text=[NSString stringWithFormat:@"%d",fenshu];
    
    iv1 = [[UIImageView alloc]
          initWithFrame:CGRectMake(-20 , 280 , 180 , 280)];
    // 使用UIImageView加载文件名以butterfly_f开头的多张图片
    iv1.image = [UIImage animatedImageNamed:@"p_"
                                  duration:1.2];

         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jixuyouxile) name:@"jixuyouxile" object:nil];
       
     
    addtime=[[UIButton alloc]initWithFrame:CGRectMake(width-230,height-150, 100, 66)];
    [addtime setTitle:@"加时器 ⏳" forState:UIControlStateNormal];
    [self.addtime addTarget:self action:@selector(jiashi1) forControlEvents:UIControlEventTouchUpInside];
    
    zhadan=[[UIButton alloc]initWithFrame:CGRectMake(width-130,height-150, 100, 66)];
    [zhadan setTitle:@"炸弹 💣" forState:UIControlStateNormal];
    [self.zhadan addTarget:self action:@selector(baozha1) forControlEvents:UIControlEventTouchUpInside];
    
    luan=[[UIButton alloc]initWithFrame:CGRectMake(width-230,height-110, 100, 66)];
    [luan setTitle:@"提示器 ⏰" forState:UIControlStateNormal];
    [self.luan addTarget:self action:@selector(tishi1) forControlEvents:UIControlEventTouchUpInside];

    startBn=[[UIButton alloc] initWithFrame:CGRectMake(width-330,height-150, 100, 66)];
    [startBn setTitle:@"开💩" forState:UIControlStateNormal];
    
    [startBn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIApplication sharedApplication].statusBarHidden = YES;
    timeText=[[UILabel alloc] initWithFrame:CGRectMake(100, 30, 150, 30)];
    self.timeText.textColor = [UIColor colorWithRed:0 green:0
                                               blue:0 alpha:1];
    UIImage * img=[UIImage imageNamed:@"0.png"];
    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imgview.image=img;
    //    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(width, 0, width, height)];
    //    [view addSubview:imgview];
    [self.view addSubview:imgview];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(240, 30, 80, 30)];
    [self.view addSubview:lbl];
    [self.view addSubview:addtime];
    [self.view addSubview:zhadan];
    [self.view addSubview:iv1];
    [self.view addSubview:luan];
    fenshu=0;
    
   
       // 为startBn按钮设置图片
    //[self.startBn setBackgroundImage:[UIImage imageNamed:@"12.jpg"]
    //  forState:UIControlStateNormal];
    //[self.startBn setBackgroundImage:[UIImage imageNamed:@"12.jpg"]
    //  forState:UIControlStateHighlighted];
    // 为startBn的Touch Up Inside事件绑定事件处理方法
    [self.startBn addTarget:self action:@selector(startGame1:)
           forControlEvents:UIControlEventTouchUpInside];
    //返回按钮   自创
    Fan=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 50, 30)];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [Fan setTitle:@"👍👂" forState:UIControlStateNormal];
    [self.Fan addTarget:self action:@selector(zanting) forControlEvents:UIControlEventTouchUpInside];
    // 创建FKGameView控件
    gameView = [[FKGameView alloc] initWithFrame:CGRectMake(0, 20, 320, 420)];
    // 创建FKGameService对象
    gameView.gameService = [[FKGameService alloc] init];
    gameView.delegate = self;
    gameView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gameView];
    [self.view addSubview:startBn];
    //[self.view addSubview:luan];
    [self.view addSubview:timeText];
    [self.view addSubview:Fan];
    // 初始化游戏失败的对话框
    lostAlert = [[UIAlertView alloc] initWithTitle:@"失败！"
                                           message:@"游戏失败！继续游戏？"delegate:self
                                 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    // 初始化游戏胜利的对话框
    successAlert = [[UIAlertView alloc] initWithTitle:@"胜利！"
                                              message:@"游戏胜利！继续游戏？"delegate:self
                                    cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    lostAlert.tag=201;
    successAlert.tag=202;
}
-(void)tishi1
{
    //     k=[[n object]intValue];
    if (tt>0) {
        [gameView autohik];
        tt--;
        [luan setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    //}
    //    else
    //    {
    //        [tishi setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    }
    
}

-(void)jiashi1
{
    if(p>0){
        leftTime=leftTime+15;
        p--;
        if (p==2) {
             [addtime setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        }
        if (p==1) {
             [addtime setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
    else
    {
        leftTime=leftTime;
    [addtime setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}
- (void) startGame1:(int)k
{
    tt=1;
    p=3;
    bb=2;
    // 如果之前的timer还未取消，取消timer
    
        k=7;
    iv1.hidden=YES;
    if (timer != nil)
    {
        [timer invalidate];//有效的，时间开启
    }
    // 重新设置游戏时间
    leftTime = DEFAULT_TIME+30;
    fenshu=0;
    // 开始新的游戏游戏
    [gameView startGame:k];
    isPlaying = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView2) userInfo:nil repeats:YES];
    // 将选中方块设为nil。
    gameView.selectedPiece = nil;
    [zhadan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addtime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.timeText.textColor=[UIColor blackColor];
    [luan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


}
- (void) startGameC:(NSNotification *) n
{
    p=3;
    bb=2;
    tt=1;
    // 如果之前的timer还未取消，取消timer
    k=[[n object]intValue];
    //    NSLog(@"%d",k);
    if (timer != nil)
    {
        [timer invalidate];//有效的，时间开启
    }
    // 重新设置游戏时间
    leftTime = DEFAULT_TIME+30;
    fenshu=0;
    
    // 开始新的游戏游戏
    [gameView startGame:k];
    isPlaying = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView2) userInfo:nil repeats:YES];
    // 将选中方块设为nil。
    gameView.selectedPiece = nil;
    [zhadan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addtime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.timeText.textColor=[UIColor blackColor];
    [luan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (void) refreshView2
{
    self.timeText.text = [NSString stringWithFormat:@"剩余⏰：%d",leftTime];
    leftTime--;
    if (leftTime<20) {
        self.timeText.textColor=[UIColor orangeColor];
    }
    if (leftTime<10) {
        self.timeText.textColor=[UIColor redColor];
    }
    lbl.text=[NSString stringWithFormat:@"得分:%d",fenshu];
    // 时间小于0, 游戏失败
    if (leftTime < 0)
    {
        [timer invalidate];
        // 更改游戏的状态
        isPlaying = NO;
        [lostAlert show];
       
        return;
    }
}
-(void)zanting
{
    [timer invalidate];
    // 更改游戏状态
    isPlaying = NO;
    //[Bbgplayer1 stop];

    zhan = [[UIAlertView alloc] initWithTitle:@"游戏已暂停！"
                                     message:@"请选择:" delegate:self
                           cancelButtonTitle:@"继续游戏" otherButtonTitles:@"重新开始",@"返回菜单" ,nil];
    [zhan show];
    zhan.tag=200;
    
}
- (void) alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (alertView.tag) {
        case 201:
            if(buttonIndex == 1)
            {
                //        [self startGame:k];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@7];
            }
            else
            {
               
                [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:nil];
            }
            
            break;
        case 202:
            if(buttonIndex == 1)
            {
                //        [self startGame:k];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@7];
            }
            else
            {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:nil];
            }
            break;
        case 200:
            if(buttonIndex == 1)
            {
               
                //        [self startGame:k];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"chongxin" object:@7];
            }
            if(buttonIndex == 2)
            {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"fanhui" object:nil];
            }
            if(buttonIndex == 0)
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"jixuyouxile" object:nil];
                
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
NSArray* imageValues()
{
    NSMutableArray* resourceValues = [[NSMutableArray alloc] init];
    NSBundle* bundle = [NSBundle mainBundle];
    NSArray* paths = [bundle pathsForResourcesOfType:@"png" inDirectory:nil];
    for (NSString* path in paths)
    {
        NSString* imageName = [path lastPathComponent];
        // 只添加以p_开头的图片
        if ([imageName hasPrefix:@"t_"])
        {
            [resourceValues addObject:imageName];
        }
        
    }
    return [NSArray arrayWithArray:resourceValues];
}
NSMutableArray* getRandomValues(NSArray* sourceValues , NSInteger size)
{
    // 创建结果集合
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for (int i = 0; i < size; i++)
    {
        // 随机获取一个数字，大于、小于sourceValues.count的数值
        int index = arc4random() % (sourceValues.count);
        // 从图片ID集合中获取该图片对象
        NSString* image = [sourceValues objectAtIndex:index];
        // 添加到结果集中
        [result addObject:image];
    }
    return result;
}

NSArray* getPlayValues(NSInteger size)
{
    if (size % 2 != 0)
    {
        // 如果该数除2有余数，将size加1
        size += 1;
    }
    // 再从所有的图片值中随机获取size的一半数量
    NSMutableArray* playImageValues = getRandomValues(imageValues() , size / 2);
    // 将playImageValues集合的元素增加一倍（保证所有图片都有与之配对的图片）
    [playImageValues addObjectsFromArray: playImageValues];
    // 将所有图片ID随机“排序”
    NSInteger i = [playImageValues count];
    while(--i > 0)
    {
        NSInteger j = arc4random() % (i+1);
        [playImageValues exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return [playImageValues copy];
}
NSArray* getPlayImages(int size)
{
    // 随机获取size个图片ID组成的集合
    NSArray* resourceValues = getPlayValues(size);
    NSMutableArray* result = [[NSMutableArray alloc] init];
    // 遍历每个图片ID
    for (NSString* value in resourceValues)
    {
        // 加载图片
        UIImage* image = [UIImage imageNamed:value];
        // 封装图片ID与图片本身
        FKPieceImage* pieceImage = [[FKPieceImage alloc]
                                    initWithImage:image imageId:value];
        [result addObject:pieceImage];
    }
    return result;
}
-(void)baozha1
{
    if(bb>0){
        FKGameView* boom1;
        boom1=[[FKGameView alloc]init];
        [boom1 booooo];
        bb--;
        if (bb==1) {
             [zhadan setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        
    }
    else
    {
        [zhadan setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    //
}
-(void)jixuyouxile
{
    leftTime=leftTime;
    fenshu=fenshu;
    
    //isPlaying = YES;
    if (timer != nil)
    {
        [timer invalidate];//有效的，时间开启
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView2) userInfo:nil repeats:YES];
}
-(void)daluan
{
    [gameView startGame:k];
    isPlaying = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self selector:@selector(refreshView2) userInfo:nil repeats:YES];
    // 将选中方块设为nil。
    gameView.selectedPiece = nil;

}

@end
