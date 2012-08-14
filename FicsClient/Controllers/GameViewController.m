//
//  GameViewController.m
//  FicsClient
//
//  Created by Andrea Giancola on 13/08/2012.
//  Copyright 2012. All rights reserved.
//

#import "GraphicsProps.h"
#import "GameInfo.h"
#import "GameViewController.h"


@interface GameViewController ()

- (void)setupSubViews;
- (void)showPos:(Position *)pos;

@end


@implementation GameViewController

@synthesize boardView=_boardView;
@synthesize infoView=_infoView;


- (id)init
{
    self = [super init];

    if (self) {
        self.wantsFullScreenLayout = YES;
        self.hidesBottomBarWhenPushed = YES;
        //...
    }
    return self;
}

- (void)dealloc
{
    [_boardView release];
    [super dealloc];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

// self.title = NSLocalizedString(@"AppName", @"");
    self.title = @"FixClient";
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    [self setupSubViews];

    //TODO: move to proper place
    Position *pos = [[Position alloc] initRandomly];
    [self showPos:pos];
    //
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view
    self.boardView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark private methods
////////////////////////////////////////////////////////////////////////////////

- (void)setupSubViews
{
    NSInteger screenW, screenH;


    screenW = [GraphicsProps screenWidth];
    screenH = [GraphicsProps screenHeight];

    //-- create chessboard panel

    [[GraphicsProps alloc] init];

    //set square frame for chessboard
    CGRect viewRect = CGRectMake(0, 0, screenW, screenW);
    self.boardView = [[UIView alloc] initWithFrame:viewRect];

    //set chessboard background image
    UIImage *img = [UIImage imageNamed:[GraphicsProps imgChessboard]];

    UIView *imageView = [[UIImageView alloc] initWithImage:img];
    [self.boardView addSubview:imageView];
    [self.boardView sendSubviewToBack:imageView];
    [imageView release];

    //compose full view
    [self.view addSubview:self.boardView];
    [self.boardView release];


    //-- create info panel
    viewRect = CGRectMake(0, screenW, screenW, screenH - screenW);
    self.infoView = [[UIView alloc] initWithFrame:viewRect];
    self.infoView.backgroundColor = [GraphicsProps colorInfoBkg];

    //test text view
    viewRect = CGRectMake(0, 0, 500, 200);
    UITextView *tmpView = [[UITextView alloc] initWithFrame:viewRect];
    tmpView.backgroundColor = [UIColor clearColor];
    tmpView.textColor = [GraphicsProps colorInfoText];
    tmpView.editable = NO;
    tmpView.font = [GraphicsProps fontPlayerName];
    tmpView.text = @"Bobby Fischer";

    [self.infoView addSubview:tmpView];
    [tmpView release];


    [self.view addSubview:self.infoView];
    [self.infoView release];
}


- (void)showPos:(Position *)pos
{
    //TODO
}

@end
