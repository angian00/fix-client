//
//  GameInfo.m
//  FicsClient
//
//  Created by Andrea Giancola on 13/08/12.
//  Copyright 2012. All rights reserved.
//


#import "GameInfo.h"


@implementation GameInfo

@synthesize wPlayer=_wPlayer;
// Player *_bPlayer;
// GamePosition *_currPos;



@end


@implementation Position

- (id)initRandomly
{
    self = [super init];
    if (self) {
        for (int i=0; i < 8; i++) {
            for (int j=0; j < 8; j++) {
                self->_squares[i][j] = nil;
            }
        }

        _squares[1][3] = [Piece whitePawn];
        _squares[2][5] = [Piece whitePawn];
    }
    
    return self;
}

- (Piece *)pieceAtXCoord:(NSInteger)xCoord
                yCoord:(NSInteger)yCoord
{
    if (xCoord < 0 || xCoord >= 8 || yCoord < 0 || yCoord >= 8) {
        [NSException raise:@"Invalid chessboard coords" 
                    format:@"xCoord: %d, yCoord: %d", xCoord, yCoord];
    }

    return _squares[xCoord][yCoord];
}


@end

