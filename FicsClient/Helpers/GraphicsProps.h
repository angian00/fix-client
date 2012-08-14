//
//  GraphicsProps.h
//  FicsClient
//
//  Created by Andrea Giancola on 13/08/12.
//  Copyright 2012. All rights reserved.
//


#import <UIKit/UIKit.h>

// extern NSInteger screenW, screenH;


@interface GraphicsProps : NSObject
{
    // NSInteger screenWidth;
    // NSInteger screenHeight;

    // UIColor infoTextColor;
    // UIColor infoTextBkgColor;
}

// @property (readonly) NSInteger screenWidth;

+ (void)initialize;

+ (NSInteger)screenWidth;
+ (NSInteger)screenHeight;
+ (NSInteger)playerNameWidth;
+ (NSInteger)playerNameHeight;

+ (NSString *)imgChessboard;

+ (UIColor *)colorInfoBkg;
+ (UIColor *)colorInfoText;

+ (UIFont *)fontPlayerName;


@end


