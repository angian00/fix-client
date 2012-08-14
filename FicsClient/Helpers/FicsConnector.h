//
//  FicsConnector.h
//  FicsClient
//
//  Created by Andrea Giancola on 04/08/2012.
//  Copyright 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>


@protocol FicsConnectorDelegate;


@interface FicsConnector : NSObject
{
    id<FicsConnectorDelegate> delegate;

    CFReadStreamRef inStream;
    CFWriteStreamRef outStream;
}

@property(nonatomic, assign) id<FicsConnectorDelegate> delegate;

- (id)init;

- (void)connect;
- (void)disconnect;


@end


@protocol FicsConnectorDelegate <NSObject>

@required

@optional

- (void)serverConnected;
- (void)serverDisconnected;

- (void)lineReceived:(NSString *)line;


@end
