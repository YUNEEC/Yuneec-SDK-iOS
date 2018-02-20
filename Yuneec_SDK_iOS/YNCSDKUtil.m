//
//  YNCSDKUtil.m
//  Yuneec_SDK_iOS
//
//  Created by Sushma Sathyanarayana on 2/16/18.
//  Copyright © 2018 Yuneec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YNCSDKUtil.h"

@implementation YNCSDKCommon

//MARK: Get Camera Mode String
+ (NSString *)getConnectionResultString:(YNCConnectionResult)connectionResultEnum {
    
    switch(connectionResultEnum) {
        case YNCConnectionResultSuccess:
            return @"Success";
        case YNCConnectionResultBindError:
            return @"Bind Error";
        case YNCConnectionResultCommandDenied:
            return @"Command Denied";
        case YNCConnectionResultSocketError:
            return @"Socket Error";
        case YNCConnectionResultNotImplemented:
            return @"Not Implemented";
        case YNCConnectionResultTimeOut:
            return @"Time Out";
        case YNCConnectionResultDeviceNotConnected:
            return @"Device Not Connected";
        case YNCConnectionResultDestinationIpUnknown:
            return @"Destination Ip Unknown";
        case YNCConnectionResultDeviceBusy:
            return @"Device Busy";
        case YNCConnectionResultConnectionsExhausted:
            return @"Connections Exhausted";
        case YNCConnectionResultSocketConnectionError:
            return @"Socket Connection Error";
        default:
            return @"Unknown";
    }
}

@end
