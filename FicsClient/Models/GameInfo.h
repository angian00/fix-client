//
//  GameInfo.h
//  FicsClient
//
//  Created by Andrea Giancola on 13/08/12.
//  Copyright 2012. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Piece.h"


@interface Player : NSObject
{
    NSString *name;
    NSInteger rating;

    // ...
    // NSString *alias;
}

@property (readonly) NSString *name;
@property (readonly) NSInteger *rating;

@end


@interface Position : NSObject
{
    Piece *_squares[8][8];
}

- (id)initRandomly;
// - (id)initFromFEN:(NSString *)fenStr;
// - (id)initFromFicsStylexxx:(NSString *)stylexxxStr;

- (Piece *)pieceAtXCoord:(NSInteger)xCoord
                yCoord:(NSInteger)yCoord;

@end


@interface GameInfo : NSObject
{
    Player *_wPlayer;
    Player *_bPlayer;
    Position *_currPos;

    //TODO: move list

    // ...
    // NSString *gameId;
    // NSDate *startDate;
}

@property (copy, readonly) Player *wPlayer;
// @property (copy, readonly) Player *bPlayer;
// @property (copy, readonly) Position *currPos;

@end

