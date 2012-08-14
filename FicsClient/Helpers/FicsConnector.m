//
//  FicsConnector.m
//  FicsClient
//
//  Created by Andrea Giancola on 04/08/2012.
//  Copyright 2012. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import <CFNetwork/CFNetwork.h>

#import "FicsConnector.h"


#define FICS_HOST @"www.freechess.org"
#define FICS_PORT 5000


static void MyCFReadStreamCallback (CFReadStreamRef stream, CFStreamEventType type, void *pInfo);
static void MyCFWriteStreamCallback (CFWriteStreamRef stream, CFStreamEventType type, void *pInfo);


////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////


@implementation FicsConnector

@synthesize delegate=_delegate;


- (id)init
{
    self = [super init];

    if (self) {
        //...
    }
    return self;
}


- (void)connect
{
    CFHostRef host = CFHostCreateWithName(kCFAllocatorDefault, (CFStringRef)FICS_HOST);
    if (!host)
    {
        NSLog(@"Error resolving host %@", FICS_HOST);
        return;
    }
    
    CFStreamCreatePairWithSocketToCFHost(kCFAllocatorDefault, host, FICS_PORT, &inStream, &outStream);
    CFRelease(host);
    
    if (!inStream)
    {
        NSLog(@"Error: inStream is null");
        return;
    }
    
    
    CFStreamClientContext context = {0, self, nil, nil, nil};
    CFOptionFlags optFlags = kCFStreamEventHasBytesAvailable | kCFStreamEventErrorOccurred | kCFStreamEventEndEncountered;

    if (CFReadStreamSetClient(inStream, optFlags, &MyCFReadStreamCallback, &context)) {
        CFReadStreamScheduleWithRunLoop(inStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    }
    
    optFlags = kCFStreamEventErrorOccurred | kCFStreamEventEndEncountered;
    if (CFWriteStreamSetClient(outStream, optFlags, &MyCFWriteStreamCallback, &context)) {
        CFWriteStreamScheduleWithRunLoop(outStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    }
    
    
    BOOL success = CFReadStreamOpen(inStream);
    CFErrorRef error = CFReadStreamCopyError(inStream);
    if (!success || (error && CFErrorGetCode(error) != 0)) {
        NSLog(@"Connect error %@ : %ld", CFErrorGetDomain(error), CFErrorGetCode(error));
        return;
    }
    else {
        NSLog(@"Connected to %@", FICS_HOST);
    }

    if ([_delegate respondsToSelector:@selector(serverConnected)]) {
        [_delegate serverConnected];
    }
}

- (void)disconnect
{
    CFReadStreamUnscheduleFromRunLoop(inStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    CFReadStreamClose(inStream);
    CFRelease(inStream);
    
    CFWriteStreamUnscheduleFromRunLoop(outStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    CFWriteStreamClose(outStream);
    CFRelease(outStream);
    
    if ([_delegate respondsToSelector:@selector(serverDisconnected)]) {
        [_delegate serverDisconnected];
    }
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark CF Callbacks
////////////////////////////////////////////////////////////////////////////////

- (void)doCFReadStreamCallback:(CFStreamEventType)eventType forStream:(CFReadStreamRef)stream
{
#define BUF_SIZE 1000
    static UInt8 buf[BUF_SIZE];
    static CFIndex nRemBytes = 0;
    CFIndex nBytesRead;
    CFErrorRef error;
    int lineStart;
    
    NSLog(@"networkReadCallback of type %ld", eventType);

    switch (eventType) {
        case kCFStreamEventHasBytesAvailable:
            nBytesRead = CFReadStreamRead(stream, buf + nRemBytes, BUF_SIZE - nRemBytes);
            if (nBytesRead > 0) {
                //look for complete lines
                lineStart = 0;
                for (int i = nRemBytes; i < nRemBytes + nBytesRead; i++) {
                    if (buf[i] == '\n' || buf[i] == '\r') {
                        buf[i] = 0x00;
                        if (i - lineStart > 0)
                            [self.delegate lineReceived:
                                [NSString stringWithCString:((char *)buf + lineStart)
                                                   encoding: NSUTF8StringEncoding]];

                        lineStart = i + 1;
                    };

                }

                NSLog(@"Remote data read: [%s]", buf);
                nRemBytes = nBytesRead - lineStart;
                //shift remaining bytes to the beginning of the buffer
                for (int i=0; i < nRemBytes; i++) {
                    buf[i] = buf[lineStart + i];
                }
                buf[nRemBytes] = 0x00;
            }
            break;

        case kCFStreamEventErrorOccurred:
            error = CFReadStreamCopyError(stream);
            NSLog(@"Socket error occurred %@ : %ld", CFErrorGetDomain(error), CFErrorGetCode(error));
            
            [self disconnect];
            break;
        
        case kCFStreamEventEndEncountered:
            NSLog(@"Connection closed by remote server");
            [self disconnect];
            break;
    }
}

- (void)doCFWriteStreamCallback:(CFStreamEventType)eventType forStream:(CFWriteStreamRef)stream
{
    NSLog(@"networkWriteCallback of type %ld", eventType);
}



/**
 * This is the callback we setup for CFReadStream.
 * This method does nothing but forward the call to it's Objective-C counterpart
 **/
static void MyCFReadStreamCallback (CFReadStreamRef stream, CFStreamEventType type, void *pInfo)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	FicsConnector *theSocket = [[(FicsConnector *)pInfo retain] autorelease];
	[theSocket doCFReadStreamCallback:type forStream:stream];
	
	[pool release];
}


/**
 * This is the callback we setup for CFWriteStream.
 * This method does nothing but forward the call to it's Objective-C counterpart
 **/
static void MyCFWriteStreamCallback (CFWriteStreamRef stream, CFStreamEventType type, void *pInfo)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	FicsConnector *theSocket = [[(FicsConnector *)pInfo retain] autorelease];
	[theSocket doCFWriteStreamCallback:type forStream:stream];
	
	[pool release];
}


@end

