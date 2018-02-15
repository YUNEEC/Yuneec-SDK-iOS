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
#include <dronecore/action.h>
#include <dronecore/mission.h>
#include <dronecore/telemetry.h>
#include <dronecore/camera.h>
#include <dronecore/gimbal.h>
#include <dronecore/offboard.h>


/*
 This class provides methods for Dronecore, a messaging library for PX4 using mavlink.
 */
@interface YNCSDKInternal : NSObject

/**
 Dronecore object
 */
@property (nonatomic) dronecore::DroneCore *dc;
@property (nonatomic) dronecore::Action *action;
@property (nonatomic) dronecore::Mission *mission;
@property (nonatomic) dronecore::Telemetry *telemetry;
@property (nonatomic) dronecore::Camera *camera;
@property (nonatomic) dronecore::Gimbal *gimbal;
@property (nonatomic) dronecore::Offboard *offboard;

+ (id)instance;

- (void)resetDroneCore;

@end
