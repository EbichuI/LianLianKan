//
//  BlViewController.m
//  Link
//
//  Created by stu024 on 15/11/4.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "BlViewController.h"
#import "LeiViewController.h"
#import <AVFoundation/AVFoundation.h>

#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height

@interface BlViewController ()<UINavigationControllerDelegate>

@end

AVAudioPlayer * bgplayer;
NSURL * url;


NSTimer * zhen;
NSTimer * timer11;
UIImageView * uiv;
BOOL flag=YES;
@implementation BlViewController
@synthesize xingArray;
- (void)viewDidLoad {
    [super viewDidLoad];
//     BlViewController * fv=[[BlViewController alloc] init];
//    UINavigationController * nc=[[UINavigationController alloc] initWithRootViewController:fv];

   

    UIImage * img=[UIImage imageNamed:@"5.png"];
    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imgview.image=img;
    [self.view addSubview:imgview];

    
//    timer11=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(move1) userInfo:nil repeats:YES];
//    
//    xingArray=[[NSMutableArray alloc]initWithCapacity:0];
//    
//    for (int i=0; i<17; i++) {
//        
//        //确定敌机的初始位置
//        UIImageView * man1=[[UIImageView alloc]initWithFrame:CGRectMake(0, height+35, 30, 30)];
//        //得到图片
//        if (i%5==0) {
//            man1.image=[UIImage imageNamed:@"xingxing1"];
//        }
//        if (i%5==1) {
//            man1.image=[UIImage imageNamed:@"xingxing2"];
//        }
//        if (i%5==2) {
//            man1.image=[UIImage imageNamed:@"xingxing3"];
//        }
//        if (i%5==3) {
//            man1.image=[UIImage imageNamed:@"xingxing4"];
//        }
//        if (i%5==4) {
//            man1.image=[UIImage imageNamed:@"xingxing5"];
//        }
//        [xingArray addObject:man1];
//        [self.view addSubview:man1];
//        
//    }

   // animation1 = [[pushanimation alloc] init];
    //隐藏NavigationBar
    //self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
//    UIImage * cang=[UIImage imageNamed:@"cang.png"];
//    uiv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33, 30)];
//    uiv.image=cang;

//    zhen = [NSTimer scheduledTimerWithTimeInterval:5
//                                             target:self selector:@selector(guanjian) userInfo:nil repeats:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeyinyue) name:@"yinyue" object:nil];

     url=[[NSBundle mainBundle]URLForResource:@"kanong" withExtension:@"mp3"];
////
////    //????????????????
    bgplayer=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    bgplayer.numberOfLoops=-1;

    //背景音乐的播放
    if (flag) {
        //[bgplayer play];
        NSLog(@"播放音乐");
    }
    else
    {
        [bgplayer stop];
    }
    
    
//   
//    UIImage * img=[UIImage imageNamed:@"5.png"];
//    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
//    imgview.image=img;
//    [self.view addSubview:imgview];
    UIButton * bu4=[[UIButton alloc]initWithFrame:CGRectMake((width/2)-50, height-380, 100, 33)];
    [bu4 setTitle:@"退出游戏" forState:UIControlStateNormal];
    bu4.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu4.titleLabel.font=[UIFont systemFontOfSize:24];
    [bu4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bu4 addTarget:self action:@selector(chuli4) forControlEvents:UIControlEventTouchUpInside];
//    CABasicAnimation * hua1=[CABasicAnimation animation];
//    hua1.keyPath=@"transform.translation.x";
//    hua1.toValue=@(240);
//    hua1.repeatCount=MAXFLOAT;
//    hua1.duration=4;
//    [bu4.layer addAnimation:hua1 forKey:nil];
    
    
    UIButton * bu3=[[UIButton alloc]initWithFrame:CGRectMake((width/2)-50, height-440, 100, 33)];
    [bu3 setTitle:@"游戏设置" forState:UIControlStateNormal];
    bu3.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu3.titleLabel.font=[UIFont systemFontOfSize:24];
    [bu3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bu3 addTarget:self action:@selector(chuli3) forControlEvents:UIControlEventTouchUpInside];
//    CABasicAnimation * hua2=[CABasicAnimation animation];
//    hua2.keyPath=@"transform.translation.x";
//    hua2.toValue=@(-300);
//    hua2.repeatCount=MAXFLOAT;
//    hua2.duration=4;
//    [bu3.layer addAnimation:hua2 forKey:nil];
    
    
    UIButton * bu2=[[UIButton alloc]initWithFrame:CGRectMake((width/2)-50, height-500, 100, 33)];
    [bu2 setTitle:@"游戏类型" forState:UIControlStateNormal];
    bu2.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu2.titleLabel.font=[UIFont systemFontOfSize:24];
    [bu2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bu2 addTarget:self action:@selector(chuli2) forControlEvents:UIControlEventTouchUpInside];
    

//    CABasicAnimation * hua3=[CABasicAnimation animation];
//    hua3.keyPath=@"transform.translation.x";
//    hua3.toValue=@(240);
//    hua3.repeatCount=MAXFLOAT;
//    hua3.duration=4;
//    [bu2.layer addAnimation:hua3 forKey:nil];
//
    
    [self.view addSubview:bu2];
    [self.view addSubview:bu3];
    [self.view addSubview:bu4];
    [self.view addSubview:uiv];
   
}
-(void)chuli2;
{
    
       [[NSNotificationCenter defaultCenter] postNotificationName:@"lala2" object:nil];
}
-(void)chuli3;
{
    UIImage * img2=[UIImage imageNamed:@"6.png"];
    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imgview.image=img2;
    [self.view addSubview:imgview];
    
    UIButton * bu11=[[UIButton alloc]initWithFrame:CGRectMake((width-180)/2, height-330, 100, 50)];
    [bu11 setTitle:@"音效设置" forState:UIControlStateNormal];
    [bu11 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    bu11.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu11.titleLabel.font=[UIFont systemFontOfSize:24];
    UISwitch * s=[[UISwitch alloc]initWithFrame:CGRectMake((width+30)/2,height-320, 80, 20)];
//    [s setOn:YES animated:YES];
    [s addTarget:self action:@selector(yinxiao) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:s];

    
    UIButton * bu22=[[UIButton alloc]initWithFrame:CGRectMake((width-180)/2, height-380, 100, 50)];
    [bu22 setTitle:@"背景音乐" forState:UIControlStateNormal];
    [bu22 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    bu22.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu22.titleLabel.font=[UIFont systemFontOfSize:24];
    UISwitch * s1=[[UISwitch alloc]initWithFrame:CGRectMake((width+30)/2,height-370, 80, 20)];
//    [s1 setOn:YES animated:YES];
    [s1 addTarget:self action:@selector(yinyue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:s1];

    
    UIButton * bu33=[[UIButton alloc]initWithFrame:CGRectMake(20, 40, 50, 30)];
    [bu33 setTitle:@"返回" forState:UIControlStateNormal];
    [bu33 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    bu33.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu33.titleLabel.font=[UIFont systemFontOfSize:24];
    [bu33 addTarget:self action:@selector(fanhui2) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:bu11];
    [self.view addSubview:bu22];
    [self.view addSubview:bu33];


}
-(void)fanhui2
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fanhui2" object:nil];
}
-(void)yinyue
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"yinyue" object:nil];
}
-(void)chuli4
{
    UIActionSheet * as=[[UIActionSheet alloc]initWithTitle:@"确定退出游戏？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil];
        [as showInView:self.view];

}
-(void)closeyinyue
{
    if (flag) {
        [bgplayer stop];
        flag=NO;
    }
    else{
        [bgplayer play];
        flag=YES;
    }
}
static int x=0;
-(void)xingmove
{
    x++;
    if(x%10==0){
        //在第几数组中得到一个敌机
        for(UIImageView * diji in xingArray){
            
            //如果他的tag为0（都为0）
            if(diji.tag==0){
                
                //使其tag的值变为1
                diji.tag=1;
                CGRect rect=diji.frame;
                
                //随即得到x的值
                int x=arc4random()%(320-35);
                
                //得到的x值给飞机出现时的横轴x
                rect.origin.x=x;
                
                //得到的y值给飞机出现时的横轴y
                rect.origin.y=rect.origin.y+8;
                
                //把所得的所有值给飞机
                diji.frame=rect;
                break;
            }
        }
        
    }
    for(UIImageView *diji in xingArray)
    {
        int heigh=568;
        //当飞机的tag为1时   飞机被选中 正在移动的飞机
        if(diji.tag == 1){
            CGRect rect =diji.frame;
            
            //飞机每次移动5
            rect.origin.y=rect.origin.y-15;
            
            //将所得值给飞机
            diji.frame=rect;
            
            //当飞机飞出屏幕边缘时
            if(rect.origin.y<=0){
                
                //使飞机的tag值变回0
                diji.tag=0;
                
                //飞机回到初始位置
                diji.frame=CGRectMake(0, height+35, 30, 30);
            }
        }
    }
    
}
-(void)move1
{
    [self xingmove];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)viewDidAppear:(BOOL)animated;
//{
//    [super viewDidAppear:animated];
//    self.navigationController.delegate=self;
//}
//- (void)viewWillDisappear:(BOOL)animated;
//{
//    [super viewWillDisappear:animated];
//    if (self.navigationController.delegate==self) {
//        self.navigationController.delegate=nil;
//    }
//}
//- (void)buttonClicked:(id)sender {
//    NSLog(@"egwgwwef");
//     LeiViewController * presentController = [[LeiViewController alloc]init];
//    [self.navigationController pushViewController:presentController animated:YES];
//    NSLog(@"habdkabsdkabdkabf");
//}
//#pragma mark delegate
//- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                fromViewController:(UIViewController *)fromVC
//                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
//{
//     NSLog(@"pppppppppppppp");
//    if(operation==UINavigationControllerOperationPush)
//    {
//        return self.animation;
//    }
//    return nil;
//}
@end
