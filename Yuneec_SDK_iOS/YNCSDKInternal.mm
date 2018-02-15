/** @brief YNCSDKTelemetry  implementation file */


#import "YNCSDKInternal.h"

using namespace dronecore;


@implementation YNCSDKInternal


#pragma mark Singleton Methods

+ (id)instance {
    static YNCSDKInternal *temp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temp = [[self alloc] init];
    });

    return temp;
}

- (instancetype)init {
    self = [super init];
    _dc = new DroneCore;
    _action = new Action(&_dc->device());
    _mission = new Mission(&_dc->device());
    _telemetry = new Telemetry(&_dc->device());
    _camera = new Camera(&_dc->device());
    _gimbal = new Gimbal(&_dc->device());
    _offboard = new Offboard(&_dc->device());
    return self;
}

- (void)resetDroneCore {
    delete _action;
    delete _mission;
    delete _telemetry;
    delete _camera;
    delete _gimbal;
    delete _offboard;
    delete _dc;
    _dc = nullptr;
}

- (void)dealloc {
    // Should never be called.
}

@end
