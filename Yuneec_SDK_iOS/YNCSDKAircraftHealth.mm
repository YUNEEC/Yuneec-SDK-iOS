//
//  YNCSDKAircraftHealth.mm
//  Yuneec_SDK_iOS
//
//  Copyright © 2018 Yuneec. All rights reserved.
//

/** @brief YNCSDKAircraftHealth implementation file, Subscribe Aircraft Health status*/


#import "YNCSDKAircraftHealth.h"
#import "YNCSDKInternal.h"


#include <dronecore/dronecore.h>

using namespace dronecore;
using namespace std::placeholders;

static id <YNCSDKAircraftHealthDelegate> _healthDelegate;

static id <YNCSDKAircraftHealthAllOkDelegate> _healthAllOkDelegate;

#pragma mark Receive Health information
void receive_health(Telemetry::Health health) {
    YNCHealth *tmpHealth = [YNCHealth new];
    tmpHealth.homePositionOk = health.home_position_ok;
    tmpHealth.localPositionOk = health.local_position_ok;
    tmpHealth.globalPositionOk = health.global_position_ok;
    tmpHealth.levelCalibrationOk = health.level_calibration_ok;
    tmpHealth.gyrometerCalibrationOk = health.gyrometer_calibration_ok;
    tmpHealth.magnetometerCalibrationOk = health.magnetometer_calibration_ok;
    tmpHealth.accelerometerCalibrationOk = health.accelerometer_calibration_ok;
    
    if (_healthDelegate &&
        [_healthDelegate respondsToSelector:@selector(onHealthUpdate:)]) {
        [_healthDelegate onHealthUpdate:tmpHealth];
    }
}

#pragma mark Receive health all information
void receive_healthAllOk(bool healthAllOk) {
    if (_healthAllOkDelegate && [_healthAllOkDelegate respondsToSelector:@selector(onHealthAllOkUpdate:)]) {
        [_healthAllOkDelegate onHealthAllOkUpdate:healthAllOk];
    }
}

@implementation YNCHealth
@end

@implementation YNCSDKAircraftHealth

- (void)subscribe:(id<YNCSDKAircraftHealthDelegate>) delegate {
    _healthDelegate = delegate;
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().telemetry().health_async(&receive_health);
}

@end

@implementation YNCSDKAircraftHealthAllOk

- (void)subscribe:(id<YNCSDKAircraftHealthAllOkDelegate>) delegate {
    _healthAllOkDelegate = delegate;
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().telemetry().health_all_ok_async(&receive_healthAllOk);
}

@end



