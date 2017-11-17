/*
 * YNCSDKInternal.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

#include <dronecore/dronecore.h>


/*
 This class provides methods for Dronecore, a messaging library for PX4 using mavlink.
 */
@interface YNCSDKInternal : NSObject

/**
 Dronecore object
 */
@property (nonatomic) dronecore::DroneCore *dc;

+ (id)instance;

@end
