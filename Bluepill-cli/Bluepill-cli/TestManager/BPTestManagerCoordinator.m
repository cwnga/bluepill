//
//  BPTestManagerCoordinator.m
//  Bluepill-cli
//
//  Created by Keqiu Hu on 1/23/17.
//  Copyright © 2017 LinkedIn. All rights reserved.
//

#import "BPTestManagerCoordinator.h"

#import <XCTest/XCTestDriverInterface-Protocol.h>
#import <XCTest/XCTestManager_DaemonConnectionInterface-Protocol.h>
#import <XCTest/XCTestManager_IDEInterface-Protocol.h>

#import <DTXConnectionServices/DTXConnection.h>
#import <DTXConnectionServices/DTXProxyChannel.h>
#import <DTXConnectionServices/DTXRemoteInvocationReceipt.h>
#import <DTXConnectionServices/DTXTransport.h>


@interface BPTestManagerCoordinator() <XCTestManager_IDEInterface>

@end

@implementation BPTestManagerCoordinator

@end
