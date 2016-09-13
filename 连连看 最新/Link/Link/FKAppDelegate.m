//
//  FKAppDelegate.m
//  Link
//
//  Created by yeeku on 13-10-23.
//  Copyright (c) 2013年 crazyit.org. All rights reserved.
//

#import "FKAppDelegate.h"
#import "FKViewController.h"
#import "GViewController.h"
#import "BlViewController.h"
#import "LeiViewController.h"
#import "FKGameView.h"
#import "BFKViewController.h"
#import "WFKViewController.h"
#import <AVFoundation/AVFoundation.h>
@implementation FKAppDelegate
int k;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor clearColor];
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appchuli) name:@"start" object:nil];
    //self.window.rootViewController=vi;
    id iskey=[[NSUserDefaults standardUserDefaults]objectForKey:@"isfrist"];
    if(iskey==nil){
        [[NSUserDefaults standardUserDefaults]setObject:@"you" forKey:@"isfrist"];
    }
   GViewController * fvc=[[GViewController alloc] init];
    self.window.rootViewController=fvc;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caidan) name:@"lala2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appchuli11) name:@"lala11" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caidan) name:@"fanhui" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appchuli) name:@"fanhui1" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appchuli) name:@"fanhui2" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appchuli11) name:@"lala22" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caidan) name:@"fanhui3" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(biantai) name:@"biantai" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wujin) name:@"wujin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(booooo) name:@"zhadan" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(caidan) name:@"caidan" object:nil];




    return YES;
}
-(void)appchuli
{
    BlViewController * ivc=[[BlViewController alloc]init];
  
    self.window.rootViewController=ivc;
}
//-(void)appchuli2
//{
//    NSLog(@"22222222");
//    ZFKViewController * ivc=[[ZFKViewController alloc]init];
//    self.window.rootViewController=ivc;
//}
-(void)appchuli11
{
    FKViewController * fk=[[FKViewController alloc]init];
    self.window.rootViewController=fk;
}
-(void)wujin
{
    WFKViewController * fk=[[WFKViewController alloc]init];
    self.window.rootViewController=fk;
}
-(void)yinxiao
{
    NSLog(@"LALAALALA");
}
-(void)biantai
{
    BFKViewController * fk=[[BFKViewController alloc]init];
    self.window.rootViewController=fk;

}
-(void)caidan
{
    LeiViewController * fk=[[LeiViewController alloc]init];
//    UINavigationController * nc=[[UINavigationController alloc] initWithRootViewController:fk];
    self.window.rootViewController=fk;

}
//- (void) alertView:(UIAlertView *)alertView
//clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(buttonIndex == 1)
//    {
//        //        [self startGame:k];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"xuanguan" object:@(k)];
//    }
//    if(buttonIndex == 2)
//    {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"caidan" object:nil];
//    }
//    if(buttonIndex == 0)
//    {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"jixuyouxi" object:nil];
//        
//    }
//    
//}

//-(IBAction)yinxiao:(id)sender
//{
//   if([sender isOn]==NO)
//   {
//       
//   }
//}
//-(IBAction)yinyue:(id)sender
//{
//    if([sender isOn]==NO)
//    {
//        
//    }
//
//}
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
