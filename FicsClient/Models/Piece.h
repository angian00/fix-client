//
//  Piece.h
//  FicsClient
//
//  Created by Andrea Giancola on 13/08/12.
//  Copyright 2012. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    kSideWhite,
    kSideBlack
} Side;

typedef enum {
    kPieceTypePawn,
    kPieceTypeKnight,
    kPieceTypeBishop,
    kPieceTypeQueen,
    kPieceTypeKing,
} PieceType;



@interface Piece : NSObject
{
    PieceType _type;
    Side _side;
}

@property (readonly) PieceType type;
@property (readonly) Side side;

- (unichar)unicodeSymbol;


// all possible instances are exposed as class factory methods.
// they are read-only, and do not store back references to Positions, Games, etc.,
// and hence are implemented as fully reusable singletons.

+ (Piece *)whitePawn;
// + (Piece *)whiteKnight;
// + (Piece *)whiteBishop;
// + (Piece *)whiteQueen;
// + (Piece *)whiteKing;

// + (Piece *)blackPawn;
// + (Piece *)blackKnight;
// + (Piece *)blackBishop;
// + (Piece *)blackQueen;
// + (Piece *)blackKing;

@end

