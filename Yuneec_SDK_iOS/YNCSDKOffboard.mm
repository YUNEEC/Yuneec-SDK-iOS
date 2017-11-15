//
//  YNCSDKOffboard.m
//  Yuneec_SDK_iOSExample
//
//  Created by Julian Oes on 23/12/16.
//  Copyright © 2016 yuneec. All rights reserved.
//

#import "YNCSDKOffboard.h"
#import "YNCSDKInternal.h"

#include <functional>
#include <dronecore/dronecore.h>

using namespace dronecore;
using namespace std::placeholders; // for _1, _2, etc.

@implementation YNCSDKOffboard

void receive_offboard_error(YNCOffboardCompletion completion, Offboard::Result result) {
    if (completion) {
        NSError *error = nullptr;
        if (result != Offboard::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Offboard::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Offboard"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(error);
        }
    }
}

+ (void)startWithCompletion:(YNCOffboardCompletion)completion {
    DroneCore *dl = [[YNCSDKInternal instance] dl];
    dl->device().offboard().start_async(std::bind(&receive_offboard_error, completion, _1));
}

+ (void)stopWithCompletion:(YNCOffboardCompletion)completion {
    DroneCore *dl = [[YNCSDKInternal instance] dl];
    dl->device().offboard().stop_async(std::bind(&receive_offboard_error, completion, _1));
}

+ (void)setVelocityNEDYawWithVelocityNorth:(float)velocityNorth
                          withVelocityEast:(float)velocityEast
                          withVelocityDown:(float)velocityDown
                                   withYaw:(float)yawDeg {
    
    Offboard::VelocityNEDYaw vNEDYaw;
    vNEDYaw.north_m_s = velocityNorth;
    vNEDYaw.east_m_s = velocityEast;
    vNEDYaw.down_m_s = velocityDown;
    vNEDYaw.yaw_deg = yawDeg;
    
    DroneCore *dl = [[YNCSDKInternal instance] dl];
    dl->device().offboard().set_velocity_ned(vNEDYaw);
}

+ (void)setVelocityBodyYawspeedWithVelocityForward:(float)velocityForward
                                 withVelocityRight:(float)velocityRight
                                  withVelocityDown:(float)velocityDown
                                     witchYawspeed:(float)yawspeed {
    
    Offboard::VelocityBodyYawspeed vBodyYawspeed;
    vBodyYawspeed.forward_m_s = velocityForward;
    vBodyYawspeed.right_m_s = velocityRight;
    vBodyYawspeed.down_m_s = velocityDown;
    vBodyYawspeed.yawspeed_deg_s = yawspeed;
    
    DroneCore *dl = [[YNCSDKInternal instance] dl];
    dl->device().offboard().set_velocity_body(vBodyYawspeed);
}

@end
