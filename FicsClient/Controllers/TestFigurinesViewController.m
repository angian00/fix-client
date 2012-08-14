//
//  ConsoleViewController.m
//  FicsClient
//
//  Created by Andrea Giancola on 04/08/2012.
//  Copyright 2012. All rights reserved.
//

#import "TestFigurinesViewController.h"


@interface TestFigurinesViewController ()

- (void)setupTextView;
- (void)printChessSymbols;

@end


@implementation TestFigurinesViewController

@synthesize textView=_textView;


- (id)init
{
    self = [super init];

    if (self) {
        //...
    }
    return self;
}

- (void)dealloc
{
    [_textView release];
    [super dealloc];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    //    self.title = NSLocalizedString(@"ConsoleTitle", @"");
    self.title = @"Testing Unicode chess symbols rendering";
    
    [self setupTextView];
    [self printChessSymbols];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view
    self.textView = nil;
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

- (void)setupTextView
{
    self.textView = [[[UITextView alloc] initWithFrame:self.view.frame] autorelease];
    self.textView.textColor = [UIColor whiteColor];
    //    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor darkGrayColor];
    
    self.textView.editable = NO;
    self.textView.scrollEnabled = YES;
    
    [self.view addSubview: self.textView];
}

- (void)printChessSymbols
{
//    NSString *fontName = @"Courier New";
    NSString *fontName = @"AmericanTypewriter";
    CGFloat fontSize = 50.0;
    NSString *fullText = @"";
    unichar utf16Symbol = 0x2654; //white king

    fullText = [fullText stringByAppendingFormat:@"%@ [%.1f]\n", fontName, fontSize];
    fullText = [fullText stringByAppendingFormat:@"%C \n", utf16Symbol];

    self.textView.font = [UIFont fontWithName:fontName size:fontSize];
//    [self.textView setFont:[UIFont fontWithName:fontName size:fontSize]];
    self.textView.text = fullText;
}

@end
