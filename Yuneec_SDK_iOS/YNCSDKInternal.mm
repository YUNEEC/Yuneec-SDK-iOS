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
    return self;
}

- (void)resetDroneCore {
    delete _dc;
    _dc = nullptr;
}

- (void)dealloc {
    // Should never be called.
}

@end
