//
//  ConsoleViewController.h
//  FicsClient
//
//  Created by Andrea Giancola on 04/08/2012.
//  Copyright 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FicsConnector.h"

@interface ConsoleViewController : UIViewController<FicsConnectorDelegate>

@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
