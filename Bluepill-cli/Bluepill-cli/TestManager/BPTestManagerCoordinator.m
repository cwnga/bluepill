//
//  BPTestManagerCoordinator.m
//  Bluepill-cli
//
//  Created by Keqiu Hu on 1/23/17.
//  Copyright © 2017 LinkedIn. All rights reserved.
//

#import "BPTestManagerCoordinator.h"

// XCTest framework
#import "XCTestManager_IDEInterface-Protocol.h"
#import "XCTestManager_TestsInterface-Protocol.h"
#import "XCTestManager_ManagerInterface-Protocol.h"
#import "XCTestManager_DaemonConnectionInterface-Protocol.h"

// DTX framework
#import "DTXConnection.h"
#import "DTXProxyChannel.h"
#import "DTXRemoteInvocationReceipt.h"
#import "DTXTransport.h"
#import "DTXSocketTransport.h"

// sys
#import <sys/socket.h>
#import <sys/un.h>

// CoreSimulator
#import "SimDevice.h"

static const NSString * const testManagerEnv = @"TESTMANAGERD_SIM_SOCK";

@interface BPTestManagerCoordinator() <XCTestManager_IDEInterface>

@property (nonatomic, strong) SimDevice *device;
@end

@implementation BPTestManagerCoordinator

- (void)connect {
    // Get socket id to test manager rd
    int socketFD = socket(AF_UNIX, SOCK_STREAM, 0);
    NSString *socketString = [self.device getenv:testManagerEnv error:nil];
    const char *socketPath = socketString.UTF8String;

    struct sockaddr_un remote;
    remote.sun_family = AF_UNIX;
    strcpy(remote.sun_path, socketPath);
    socklen_t length = (socklen_t)(strlen(remote.sun_path) + sizeof(remote.sun_family) + sizeof(remote.sun_len));
    if (connect(socketFD, (struct sockaddr *)&remote, length) == -1) {
        NSLog(@"ERROR!");
    }

    // Set up DTXTransport
    DTXTransport *transport = [[DTXSocketTransport alloc] initWithConnectedSocket:socketFD disconnectAction:^{
        NSLog(@"Connection failed");
    }];

    // Set up DTXConnection
    DTXConnection *connection = [[DTXConnection alloc] initWithTransport:transport];
    [connection registerDisconnectHandler:^{
        NSLog(@"Disconnected");
    }];
    [connection resume];

    DTXProxyChannel *channel = [connection
                                makeProxyChannelWithRemoteInterface:@protocol(XCTestManager_DaemonConnectionInterface)
                                exportedInterface:@protocol(XCTestManager_IDEInterface)];

    [channel setExportedObject:self queue:dispatch_get_main_queue()];
}

#pragma mark - XCTestManager_IDEInterface protocol

// This is possibly the delegate function we need to boot the Application during UI test.
- (id)_XCT_launchProcessWithPath:(NSString *)path bundleID:(NSString *)bundleID arguments:(NSArray *)arguments environmentVariables:(NSDictionary *)environment {
    return nil;
}

- (id)_XCT_getProgressForLaunch:(id)token {
    return nil;
}

- (id)_XCT_terminateProcess:(id)token {
    return nil;
}

- (id)_XCT_didBeginInitializingForUITesting {
    return nil;
}

- (id)_XCT_initializationForUITestingDidFailWithError:(NSError *)error {
    return nil;
}

- (id)_XCT_handleCrashReportData:(NSData *)arg1 fromFileWithName:(NSString *)arg2 {
    return nil;
}

- (id)_XCT_testSuite:(NSString *)tests didStartAt:(NSString *)time {
    return nil;
}

- (id)_XCT_didBeginExecutingTestPlan {
    return nil;
}

- (id)_XCT_didFinishExecutingTestPlan {
    return nil;
}

- (id)_XCT_testBundleReadyWithProtocolVersion:(NSNumber *)protocolVersion minimumVersion:(NSNumber *)minimumVersion {
    return nil;
}

- (id)_XCT_testCaseDidStartForTestClass:(NSString *)testClass method:(NSString *)method {
    return nil;
}

- (id)_XCT_testCaseDidFailForTestClass:(NSString *)testClass method:(NSString *)method withMessage:(NSString *)message file:(NSString *)file line:(NSNumber *)line {
    return nil;
}

- (id)_XCT_logDebugMessage:(NSString *)debugMessage {
    return nil;
}

- (id)_XCT_logMessage:(NSString *)message {
    return nil;
}

- (id)_XCT_testCaseDidFinishForTestClass:(NSString *)testClass method:(NSString *)method withStatus:(NSString *)statusString duration:(NSNumber *)duration {
    return nil;
}

- (id)_XCT_testSuite:(NSString *)arg1 didFinishAt:(NSString *)arg2 runCount:(NSNumber *)arg3 withFailures:(NSNumber *)arg4 unexpected:(NSNumber *)arg5 testDuration:(NSNumber *)arg6 totalDuration:(NSNumber *)arg7 {
    return nil;
}

- (id)_XCT_nativeFocusItemDidChangeAtTime:(NSNumber *)arg1 parameterSnapshot:(XCElementSnapshot *)arg2 applicationSnapshot:(XCElementSnapshot *)arg3 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedEventNames:(NSArray *)arg1 timestamp:(NSNumber *)arg2 duration:(NSNumber *)arg3 startLocation:(NSDictionary *)arg4 startElementSnapshot:(XCElementSnapshot *)arg5 startApplicationSnapshot:(XCElementSnapshot *)arg6 endLocation:(NSDictionary *)arg7 endElementSnapshot:(XCElementSnapshot *)arg8 endApplicationSnapshot:(XCElementSnapshot *)arg9 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_testCase:(NSString *)arg1 method:(NSString *)arg2 didFinishActivity:(XCActivityRecord *)arg3 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_testCase:(NSString *)arg1 method:(NSString *)arg2 willStartActivity:(XCActivityRecord *)arg3 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedOrientationChange:(NSString *)arg1 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedFirstResponderChangedWithApplicationSnapshot:(XCElementSnapshot *)arg1 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_exchangeCurrentProtocolVersion:(NSNumber *)arg1 minimumVersion:(NSNumber *)arg2 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedKeyEventsWithApplicationSnapshot:(XCElementSnapshot *)arg1 characters:(NSString *)arg2 charactersIgnoringModifiers:(NSString *)arg3 modifierFlags:(NSNumber *)arg4 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedEventNames:(NSArray *)arg1 duration:(NSNumber *)arg2 startLocation:(NSDictionary *)arg3 startElementSnapshot:(XCElementSnapshot *)arg4 startApplicationSnapshot:(XCElementSnapshot *)arg5 endLocation:(NSDictionary *)arg6 endElementSnapshot:(XCElementSnapshot *)arg7 endApplicationSnapshot:(XCElementSnapshot *)arg8 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedKeyEventsWithCharacters:(NSString *)arg1 charactersIgnoringModifiers:(NSString *)arg2 modifierFlags:(NSNumber *)arg3 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedEventNames:(NSArray *)arg1 duration:(NSNumber *)arg2 startElement:(XCAccessibilityElement *)arg3 startApplicationSnapshot:(XCElementSnapshot *)arg4 endElement:(XCAccessibilityElement *)arg5 endApplicationSnapshot:(XCElementSnapshot *)arg6 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedEvent:(NSString *)arg1 targetElementID:(NSDictionary *)arg2 applicationSnapshot:(XCElementSnapshot *)arg3 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_recordedEvent:(NSString *)arg1 forElement:(NSString *)arg2 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_testMethod:(NSString *)arg1 ofClass:(NSString *)arg2 didMeasureMetric:(NSDictionary *)arg3 file:(NSString *)arg4 line:(NSNumber *)arg5 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_testCase:(NSString *)arg1 method:(NSString *)arg2 didStallOnMainThreadInFile:(NSString *)arg3 line:(NSNumber *)arg4 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_testMethod:(NSString *)arg1 ofClass:(NSString *)arg2 didMeasureValues:(NSArray *)arg3 forPerformanceMetricID:(NSString *)arg4 name:(NSString *)arg5 withUnits:(NSString *)arg6 baselineName:(NSString *)arg7 baselineAverage:(NSNumber *)arg8 maxPercentRegression:(NSNumber *)arg9 maxPercentRelativeStandardDeviation:(NSNumber *)arg10 file:(NSString *)arg11 line:(NSNumber *)arg12 {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (id)_XCT_testBundleReady {
    return [self handleUnimplementedXCTRequest:_cmd];
}

- (NSString *)unknownMessageForSelector:(SEL)aSelector {
    return nil;
}

// This will add more logs when unimplemented method from XCTestManager_IDEInterface protocol is called
- (id)handleUnimplementedXCTRequest:(SEL)aSelector {
    NSLog(@"SEL: %@ _ cmd: %@", NSStringFromSelector(aSelector), NSStringFromSelector(_cmd));
    return nil;
}

@end
