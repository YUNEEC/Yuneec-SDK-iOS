/*
 * YNCSDKGimbal.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/ 

#import <Foundation/Foundation.h>

/**
 Data type for completion blocks for gimbal settings that contain error results, if any.
 */
typedef void (^YNCGimbalCompletion)(NSError *error);

/**
 This class manages the gimbal properties of the drone.
 */
@interface YNCSDKGimbal : NSObject

/**
 * Sets the pitch and yaw of the gimbal.
 *
 * @param pitchDeg the pitch value in degrees
 * @param yawDeg the yaw angle in degrees
 * @param completion the completion block returning the error status, if any
 */
+ (void)setPitchDeg:(float)pitchDeg andYawDeg:(float)yawDeg withCompletion:(YNCGimbalCompletion)completion;

@end
