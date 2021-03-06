//
//  AppDelegate.m
//  EMall
//
//  Created by Luigi on 16/6/16.
//  Copyright © 2016年 Luigi. All rights reserved.
//

#import "AppDelegate.h"
#import "OCRootTabbarController.h"
#import <UMMobClick/MobClick.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)customeApperance{
    NSDictionary *titleAttibutes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [UIFont oc_boldSystemFontOfSize:18],NSFontAttributeName,
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor clearColor],UITextAttributeTextShadowColor,
                                    nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttibutes];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self customeApperance];
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    sleep(4);//客户觉得启动页太快了，所以就等了2秒
    OCRootTabbarController *rootTarbarController=[[OCRootTabbarController alloc]  init];
    self.window.rootViewController=rootTarbarController;
    [self.window makeKeyAndVisible];
    UMConfigInstance.appKey = @"57d0208e67e58ef9110030fa";
    [MobClick setAppVersion:[EMCommonInfo appVersion]];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
