//
//  LeiViewController.m
//  Link
//
//  Created by stu024 on 15/11/4.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "LeiViewController.h"
#import "FKViewController.h"
#import "Hand.h"

#import "BlViewController.h"
#import <AVFoundation/AVFoundation.h>
#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height
@interface LeiViewController ()<UINavigationControllerDelegate>

@end

UIButton * bu;
UIButton * bbuu;
UIImageView* iv;
UIImageView* uiv;
// 定义定时器
NSTimer* timer;
NSTimer * timer1;
NSTimer * zhen;
UILabel * la1;
UILabel * la2;
UILabel * la3;
//UIImageView* man;
@implementation LeiViewController

int h;
int i;

@synthesize xiaojiArray;
- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
    
    
    Hand * han=[[Hand alloc]init];
//    [self.view addSubview:han];
    UIImage * img=[UIImage imageNamed:@"7.png"];
    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imgview.image=img;
    [self.view addSubview:imgview];
    
//     UIImage * cang=[UIImage imageNamed:@"cang.png"];
//    uiv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33, 30)];
//    uiv.image=cang;
    la1=[[UILabel alloc]initWithFrame:CGRectMake(width/2+50, -50, 120, 30)];
    la1.text=@"无尽模式";
    la1.textColor=[UIColor redColor];
    la1.font=[UIFont systemFontOfSize:16];
    la2=[[UILabel alloc]initWithFrame:CGRectMake((width-100)/2+20, -50, 120, 30)];
    la2.text=@"变态模式";
    la2.textColor=[UIColor redColor];
    la2.font=[UIFont systemFontOfSize:20];
    la3=[[UILabel alloc]initWithFrame:CGRectMake((width-100)/2-50, -50, 120, 30)];
    la3.text=@"闯关模式";
    la3.textColor=[UIColor redColor];
    la3.font=[UIFont systemFontOfSize:24];

    zhen = [NSTimer scheduledTimerWithTimeInterval:0.5
                                            target:self selector:@selector(fangxia) userInfo:nil repeats:NO];
    
    timer1=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(move) userInfo:nil repeats:YES];

    xiaojiArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i=0; i<17; i++) {
        
        //确定敌机的初始位置
        UIImageView * man=[[UIImageView alloc]initWithFrame:CGRectMake(0, -35, 35, 35)];
        //得到图片
        if (i%5==0) {
            man.image=[UIImage imageNamed:@"r_1"];
        }
        if (i%5==1) {
            man.image=[UIImage imageNamed:@"r_3"];
        }
        if (i%5==2) {
            man.image=[UIImage imageNamed:@"r_5"];
        }
        if (i%5==3) {
            man.image=[UIImage imageNamed:@"r_7"];
        }
        if (i%5==4) {
            man.image=[UIImage imageNamed:@"r_9"];
        }
        [xiaojiArray addObject:man];
        [self.view addSubview:man];

    }
//    [xiaojiArray addObject:man];
//    [self.view addSubview:man];

    UIButton * bu1=[[UIButton alloc]initWithFrame:CGRectMake(width/2+50, height/3, 70, 30)];
    //[bu1 setTitle:@"无尽模式" forState:UIControlStateNormal];
//    la1=[[UILabel alloc]initWithFrame:CGRectMake(width/2+50, -50, 70, 30)];
//    la1.text=@"无尽模式";
//    la1.textColor=[UIColor redColor];
    [bu1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    bu1.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu1.titleLabel.font=[UIFont systemFontOfSize:16];
    [bu1 addTarget:self action:@selector(wujin) forControlEvents:UIControlEventTouchUpInside];
//    CAKeyframeAnimation * k1=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue * key1=[NSValue valueWithCGPoint:la1.layer.position];
//    NSValue * key2=[NSValue valueWithCGPoint:CGPointMake(la1.layer.position.x, la1.layer.position.y+height-450)];
//    //NSValue * key3=[NSValue valueWithCGPoint:CGPointMake(la1.layer.position.x, la1.layer.position.y)];
//    k1.values=@[key1,key2];
//    k1.duration=3;
//   // k1.repeatCount=MAXFLOAT;
//    [la1.layer addAnimation:k1 forKey:nil];
    
    

    
    UIButton * bu2=[[UIButton alloc]initWithFrame:CGRectMake((width-100)/2+20, height/3+40, 80, 40)];
   // [bu2 setTitle:@"变态模式" forState:UIControlStateNormal];
    [bu2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    bu2.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu2.tag=7;
    bu2.titleLabel.font=[UIFont systemFontOfSize:19];
    [bu2 addTarget:self action:@selector(biantai) forControlEvents:UIControlEventTouchUpInside];
//    CAKeyframeAnimation * k2=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue * key12=[NSValue valueWithCGPoint:bu2.layer.position];
//    NSValue * key22=[NSValue valueWithCGPoint:CGPointMake(bu2.layer.position.x, bu2.layer.position.y+230)];
//    NSValue * key32=[NSValue valueWithCGPoint:CGPointMake(bu2.layer.position.x, bu2.layer.position.y)];
//    k2.values=@[key12,key22,key32];
//    k2.duration=4;
//    k2.repeatCount=MAXFLOAT;
//    [bu2.layer addAnimation:k2 forKey:nil];

    
    UIButton * bu3=[[UIButton alloc]initWithFrame:CGRectMake((width-100)/2-50,height/3+80, 100, 50)];
   // [bu3 setTitle:@"闯关模式" forState:UIControlStateNormal];
    [bu3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    bu3.titleLabel.textAlignment=NSTextAlignmentCenter;
    bu3.titleLabel.font=[UIFont systemFontOfSize:24];
    [bu3 addTarget:self action:@selector(chuangguan) forControlEvents:UIControlEventTouchUpInside];
//    CAKeyframeAnimation * k3=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue * key11=[NSValue valueWithCGPoint:bu3.layer.position];
//    NSValue * key21=[NSValue valueWithCGPoint:CGPointMake(bu3.layer.position.x, bu3.layer.position.y+230)];
//    NSValue * key31=[NSValue valueWithCGPoint:CGPointMake(bu3.layer.position.x, bu3.layer.position.y)];
//    k3.values=@[key11,key21,key31];
//    k3.duration=6;
//    k3.repeatCount=MAXFLOAT;
//    [bu3.layer addAnimation:k3 forKey:nil];

    
    UIButton * fan1=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 50, 30)];
    [fan1 setTitle:@"返回" forState:UIControlStateNormal];
    [fan1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    fan1.titleLabel.textAlignment=NSTextAlignmentCenter;
    fan1.titleLabel.font=[UIFont systemFontOfSize:24];
    [fan1 addTarget:self action:@selector(fanhui1) forControlEvents:UIControlEventTouchUpInside];

  
    [self.view addSubview:han];

    [self.view addSubview:bu1];
    [self.view addSubview:bu2];
    [self.view addSubview:bu3];
    [self.view addSubview:fan1];
    [self.view addSubview:la1];
    [self.view addSubview:la2];
    [self.view addSubview:la3];
}
-(void)chuangguan

{
    
        iv = [[UIImageView alloc]
          initWithFrame:CGRectMake(180 , 180 , 100 , 103)];
    // 使用UIImageView加载文件名以butterfly_f开头的多张图片
    iv.image = [UIImage animatedImageNamed:@"loading_0"
                                  duration:1];

    UIImage * img1=[UIImage imageNamed:@"3.png"];
    UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imgview.image=img1;
    [self.view addSubview:imgview];
    iv.transform=CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        iv.transform=CGAffineTransformMakeScale(1.7, 1.7);
    }completion:^(BOOL finish){
        [UIView animateKeyframesWithDuration:2 delay:1 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
             iv.transform=CGAffineTransformMakeScale(0.2, 0.2);
        }completion:nil];
    }];
    
    UIButton * fan3=[[UIButton alloc]initWithFrame:CGRectMake(20, 30, 50, 30)];
    [fan3 setTitle:@"返回" forState:UIControlStateNormal];
    [fan3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    fan3.titleLabel.textAlignment=NSTextAlignmentCenter;
    fan3.titleLabel.font=[UIFont systemFontOfSize:24];
    [fan3 addTarget:self action:@selector(fanhui1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fan3];

    for (i=1; i<7; i++) {
        bu=[[UIButton alloc]initWithFrame:CGRectMake((width/2+130)-50*i, (height-570)+30*i, 70+10*i, 30+10*i)];
        bu.tag=i;
        [bu setTitle:[NSString stringWithFormat:@"第%d关",i] forState:UIControlStateNormal];
        [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bu.titleLabel.textAlignment=NSTextAlignmentCenter;
        bu.titleLabel.font=[UIFont systemFontOfSize:16+2*i];
       [bu addTarget:self action:@selector(chuangguan:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:bu];
        
    }
    for (h=8; h<14; h++) {
        bbuu=[[UIButton alloc]initWithFrame:CGRectMake(width/2-165+50*(h-8), height-370+30*(h-7), 130-10*(h-7), 90-10*(h-7))];
        bbuu.tag=h;
        [bbuu setTitle:[NSString stringWithFormat:@"第%d关",h] forState:UIControlStateNormal];
        [bbuu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bbuu.titleLabel.textAlignment=NSTextAlignmentCenter;
        bbuu.titleLabel.font=[UIFont systemFontOfSize:28-2*(h-8)];
        [bbuu addTarget:self action:@selector(chuangguan:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:bbuu];
    }
    
    [self.view addSubview: iv];
}
-(void)chuangguan:(id)sender
{
    bu=(UIButton *)sender;
//    FKViewController2 *fc=[[FKViewController2 alloc]init];
//    fc.chuan=bu.tag;
    switch (bu.tag) {
        case 1:
        {
           FKViewController * guan=[[FKViewController alloc]init];
           [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@1];
        }
            break;
            case 2:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@2];
        }
            break;
            case 3:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@3];
        }
            break;
            case 4:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@4];
        }
            break;
        case 5:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@5];
        }
            break;
        case 6:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@6];
        }
            break;
        case 8:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@8];
        }
            break;
        case 9:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@9];
        }
            break;
        case 10:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@10];
        }
            break;
        case 11:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@11];
        }
            break;
        case 12:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@12];
        }
            break;
        case 13:
        {
            FKViewController * guan=[[FKViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController=guan;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@13];
        }
            break;

        default:
            break;
    }
}
-(void)biantai
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"biantai" object:nil];
}
-(void)wujin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"wujin" object:nil];

}
-(void)fanhui1
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fanhui1" object:nil];
}
-(void)fanhui3
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fanhui3" object:nil];

}
static int x=0;
-(void)xiaojimove
{
    x++;
    if(x%10==0){
        //在第几数组中得到一个敌机
        for(UIImageView * diji in xiaojiArray){
            
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
    for(UIImageView *diji in xiaojiArray)
    {
        int heigh=568;
        //当飞机的tag为1时   飞机被选中 正在移动的飞机
        if(diji.tag == 1){
            CGRect rect =diji.frame;
            
            //飞机每次移动5
            rect.origin.y=rect.origin.y+5;
            
            //将所得值给飞机
            diji.frame=rect;
            
            //当飞机飞出屏幕边缘时
            if(rect.origin.y>=heigh-20){
                
                //使飞机的tag值变回0
                diji.tag=0;
                
                //飞机回到初始位置
                diji.frame=CGRectMake(0, -35, 35, 35);
            }
        }
    }

}
-(void)move
{
    [self xiaojimove];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fangxia
{
    [UIView animateKeyframesWithDuration:3 delay:0 options:UIViewAnimationCurveLinear|UIViewAnimationCurveLinear animations:^{
        //2
        [UIView addKeyframeWithRelativeStartTime:0.05 relativeDuration:0.7 animations:^{
            la1.center=CGPointMake(la1.layer.position.x, la1.layer.position.y+height-450);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.05 relativeDuration:0.7 animations:^{
            la2.center=CGPointMake(la2.layer.position.x, la2.layer.position.y+280);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.05 relativeDuration:0.7 animations:^{
            la3.center=CGPointMake(la3.layer.position.x, la3.layer.position.y+350);
        }];
    } completion:^(BOOL finished) {
//        [la1 removeFromSuperview];
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
