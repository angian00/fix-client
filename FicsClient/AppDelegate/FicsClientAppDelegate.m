//
//  FicsClientAppDelegate.m
//  FicsClient
//
//  Created by Andrea Giancola on 04/08/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ConsoleViewController.h"
#import "GameViewController.h"
//#import "TestFigurinesViewController.h"
#import "FicsConnector.h"

#import "FicsClientAppDelegate.h"


@implementation FicsClientAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // ConsoleViewController *console = [[ConsoleViewController alloc] init];

    //DEBUG
    // FicsConnector *connector = [[FicsConnector alloc] init];
    // connector.delegate = console;
    // [connector connect];
    //

    GameViewController *gameVC = [[GameViewController alloc] init];

    //DEBUG
    // TestFigurinesViewController *testFig = [[TestFigurinesViewController alloc] init];
    //

    UINavigationController *rootC = [[UINavigationController alloc] initWithRootViewController:gameVC];
    rootC.navigationBarHidden = YES;

    //[console release];
    [gameVC release];
    // [testFig release];


    [self.window addSubview:rootC.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
