//
//  YNCSDKAircraftBattery.mm
//  Yuneec_SDK_iOS
//
//  Copyright © 2018 Yuneec. All rights reserved.
//

/** @brief YNCSDKAircraftBattery  implementation file, Subscribe Battery status*/

#import "YNCSDKAircraftBattery.h"
#import "YNCSDKInternal.h"


#include <dronecore/dronecore.h>

using namespace dronecore;
using namespace std::placeholders;

static id <YNCSDKBatteryDelegate> _batteryDelegate;

#pragma mark Receive battery data
void receive_battery(Telemetry::Battery battery) {
    YNCBattery *tmpBattery = [YNCBattery new];
    tmpBattery.voltageV = battery.voltage_v;
    tmpBattery.remainingPercent = battery.remaining_percent;
    
    if (_batteryDelegate && [_batteryDelegate respondsToSelector:@selector(onBatteryUpdate:)]) {
        [_batteryDelegate onBatteryUpdate:tmpBattery];
    }
}

@implementation YNCBattery
@end

@implementation YNCSDKBattery

- (void)subscribe:(id<YNCSDKBatteryDelegate>) delegate {
    _batteryDelegate = delegate;
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().telemetry().battery_async(&receive_battery);
}

@end

