//
//  Piece.m
//  FicsClient
//
//  Created by Andrea Giancola on 13/08/12.
//  Copyright 2012. All rights reserved.
//


#import "Piece.h"

static Piece *__whitePawn   = nil;
//static Piece *__whiteKnight = nil;
//static Piece *__whiteBishop = nil;
//static Piece *__whiteQueen  = nil;
//static Piece *__whiteKing   = nil;
//
//static Piece *__blackPawn   = nil;
//static Piece *__blackKnight = nil;
//static Piece *__blackBishop = nil;
//static Piece *__blackQueen  = nil;
//static Piece *__blackKing   = nil;


@implementation Piece

@synthesize type=_type, side=_side;


- (unichar)unicodeSymbol
{
    //TODO
    return 0x00;
}

+ (Piece *)whitePawn
{
    if (__whitePawn == nil) {
        __whitePawn = [[Piece alloc] init];
        __whitePawn->_type = kPieceTypePawn;
        __whitePawn->_side = kSideWhite;
    }
    return __whitePawn;
}


@end

