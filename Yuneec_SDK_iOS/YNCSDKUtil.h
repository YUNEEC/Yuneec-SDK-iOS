//
//  YNCSDKUtil.h
//  Yuneec_SDK_iOS
//
//  Created by Sushma Sathyanarayana on 2/16/18.
//  Copyright © 2018 Yuneec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YNCSDKConnection.h"

@interface YNCSDKCommon: NSObject

/**
 * Get connection result string
 * @param connectionResultEnum the connection result Enum
 */
+ (NSString*)getConnectionResultString:(YNCConnectionResult) connectionResultEnum;

@end


