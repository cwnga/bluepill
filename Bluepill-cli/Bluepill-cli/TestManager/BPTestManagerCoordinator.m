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

// DTX framework
#import "DTXConnection.h"
#import "DTXProxyChannel.h"
#import "DTXRemoteInvocationReceipt.h"
#import "DTXTransport.h"

@interface BPTestManagerCoordinator() <XCTestManager_IDEInterface>

@end

@implementation BPTestManagerCoordinator

#pragma mark - XCTestManager_IDEInterface protocol

- (id)_XCT_launchProcessWithPath:(NSString *)path bundleID:(NSString *)bundleID arguments:(NSArray *)arguments environmentVariables:(NSDictionary *)environment {
    return nil;
}



@end
