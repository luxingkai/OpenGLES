//
//  AppDelegate.m
//  OpenGL_ES Usage
//
//  Created by tiger fly on 2020/3/20.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GLKUsageController.h"
#import "ShaderViewController.h"
#import "VertexViewController.h"
#import "DrawViewController.h"
#import "VertexShaderController.h"
#import "TextureViewController.h"
#import "FragmentShaderController.h"
#import "FragmentViewController.h"
#import "FrameBufferController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    VertexViewController *vc = [VertexViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}



@end
