//
//  GraphicsProps.m
//  FicsClient
//
//  Created by Andrea Giancola on 13/08/2012.
//  Copyright 2012. All rights reserved.
//

#import "GraphicsProps.h"

#define DEFAULT_VOID_COLOR [UIColor redColor]

static NSDictionary *dict;

@interface GraphicsProps ()

+ (UIColor *)buildColorForProp:(NSString *)propName;
+ (UIFont *)buildFontForProp:(NSString *)propName;

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert;

@end


@implementation GraphicsProps

+ (void)initialize
{
    NSLog(@"initializing GraphicsProps");

    dict = [NSDictionary dictionaryWithContentsOfFile:
               [[NSBundle mainBundle] pathForResource:@"graphics" ofType:@"plist"]];

    if (![dict count]) {
        NSLog(@"Error loading graphics.plist file");
        return;
    }

    NSLog(@"GraphicsProps initialized: %@", dict);
}


+ (NSInteger)screenWidth
{
    return [[[dict objectForKey: @"layout"] valueForKey: @"screenWidth"] intValue];
}

+ (NSInteger)screenHeight
{
    return [[[dict objectForKey: @"layout"] valueForKey: @"screenHeight"] intValue];
}

+ (NSInteger)playerNameWidth
{
    return [[[dict objectForKey: @"layout"] valueForKey: @"playerNameWidth"] intValue];
}

+ (NSInteger)playerNameHeight
{
    return [[[dict objectForKey: @"layout"] valueForKey: @"playerNameHeight"] intValue];
}


+ (NSString *)imgChessboard
{
    //TODO: move image loading here?
    return [[dict objectForKey: @"imagePaths"] valueForKey: @"chessboard"];
}

+ (UIColor *)colorInfoBkg
{
    NSString *hexStr = [[dict objectForKey: @"colorScheme"] valueForKey: @"infoBkg"];
    return [[self class] colorWithHexString:hexStr];
}

+ (UIColor *)colorInfoText
{
    return [[self class] buildColorForProp:@"infoText"];
}

+ (UIFont *)fontPlayerName;
{
    return [[self class] buildFontForProp:@"playerName"];
}


+ (UIColor *)buildColorForProp:(NSString *)propName
{
    NSString *hexStr = [[dict objectForKey: @"colorScheme"] valueForKey: propName];
    NSLog(@"building color for prop [%@] from hex str [%@]", propName, hexStr);
    return [[self class] colorWithHexString:hexStr];
}

+ (UIFont *)buildFontForProp:(NSString *)propName
{
    NSDictionary *fontDict = [[dict objectForKey: @"fonts"] objectForKey:propName];
    NSLog(@"building font for prop [%@] from sub-dict [%@]", propName, fontDict);
    return [UIFont fontWithName:[fontDict objectForKey: @"fontName"]
                    size:[[fontDict valueForKey: @"fontSize"] intValue]];
}


+ (UIColor *)colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;

    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];

    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end

