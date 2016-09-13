//
//  GViewController.m
//  Link
//
//  Created by stu024 on 15/11/4.
//  Copyright © 2015年 crazyit.org. All rights reserved.
//

#import "GViewController.h"
#import "BlViewController.h"
#import <AVFoundation/AVFoundation.h>
#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height
#define count 5

@interface GViewController ()
{
    UIScrollView * sv;
    UIPageControl * pc;
}


@end
int t=0;
@implementation GViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeyinyue) name:@"yinyue" object:nil];

    sv=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    sv.backgroundColor=[UIColor redColor];
    sv.showsHorizontalScrollIndicator=NO;
    sv.pagingEnabled=YES;
    sv.contentSize=CGSizeMake(width*count, 0);
    
    for (int i=0; i<count; i++) {
        UIImage * img=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
        UIImageView * imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        imgview.image=img;
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(i*width, 0, width, height)];
        [view addSubview:imgview];
        if (i==0) {
            UILabel * la1=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 300, 70)];
            la1.text=@"告诉我你最爱连连👀";
            la1.font=[UIFont systemFontOfSize:28];
            la1.textColor=[UIColor redColor];
            [view addSubview:la1];
        }
        if (i==1) {
            UILabel * la2=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 300, 70)];
            la2.text=@"爱。。。。。。。。";
            la2.font=[UIFont systemFontOfSize:28];
            la2.textColor=[UIColor redColor];
            [view addSubview:la2];
        }
        if (i==2) {
            UILabel * la3=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 300, 70)];
            la3.text=@"真的爱。。。。。。";
            la3.font=[UIFont systemFontOfSize:28];
            la3.textColor=[UIColor redColor];
            [view addSubview:la3];
        }
        if (i==3) {
            UILabel * la4=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 300, 70)];
            la4.text=@"真的特别爱。。。。";
            la4.font=[UIFont systemFontOfSize:28];
            la4.textColor=[UIColor redColor];
            [view addSubview:la4];
        }
        if (i==4) {
            UILabel * la5=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 300, 70)];
            la5.text=@"🐰🐰🐰🐰🐰🐰🐰🐰";
            la5.font=[UIFont systemFontOfSize:28];
            la5.textColor=[UIColor redColor];
            [view addSubview:la5];
       
            UIButton * ubt=[UIButton buttonWithType:UIButtonTypeCustom];
            ubt=[[UIButton alloc]initWithFrame:CGRectMake(width/2+60, height-96, 80, 40)];
            [ubt setTitle:@"进入应用" forState:UIControlStateNormal];
            ubt.backgroundColor=[UIColor grayColor];
            [ubt addTarget:self action:@selector(chuli) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:ubt];
        }
        
        [sv addSubview:view];
    }
    sv.delegate=self;
    [self.view addSubview:sv];
    pc=[[UIPageControl alloc]initWithFrame:CGRectMake((width-150)/2, height-66, 150, 44)];
    pc.numberOfPages=count;
    pc.currentPage=0;
    pc.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:pc];
   // [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(gundong) userInfo:nil repeats:YES];
    

}
-(void)chuli
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"start" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    pc.currentPage=scrollView.contentOffset.x/width;
}
-(void)gundong;
{
    t++;
    pc.currentPage=t%5;
    if (t==100)
    {
        t=0;
    }
    [sv setContentOffset:CGPointMake(width*pc.currentPage, 0) animated:YES];
    
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
