//
//  ConsoleViewController.m
//  FicsClient
//
//  Created by Andrea Giancola on 04/08/2012.
//  Copyright 2012. All rights reserved.
//

#import "ConsoleViewController.h"


@interface ConsoleViewController ()

- (void)setupTextView;

@end


@implementation ConsoleViewController

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
    self.title = @"Console";
    
    [self setupTextView];
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
#pragma mark FicsConnectorDelegate methods
////////////////////////////////////////////////////////////////////////////////

- (void)lineReceived:(NSString *)line
{
    NSLog(@"Line received: [%@]", line);
    self.textView.text = [self.textView.text stringByAppendingFormat:@"%@\n", line];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark private methods
////////////////////////////////////////////////////////////////////////////////

- (void)setupTextView
{
    self.textView = [[[UITextView alloc] initWithFrame:self.view.frame] autorelease];
    self.textView.textColor = [UIColor whiteColor];
    self.textView.font = [UIFont fontWithName:@"Courier New" size:14.0];
    //    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor blackColor];

    self.textView.text = @"<Connecting to FICS...>\n";
    self.textView.editable = NO;
//    self.textView.editable = YES;
    self.textView.scrollEnabled = YES;

    [self.view addSubview: self.textView];
}


@end
