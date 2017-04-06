/** @brief YNCSDKInfo  implementation file */

#import "YNCSDKInfo.h"
#import "YNCSDKInternal.h"

#include <functional>
#include <dronelink/dronelink.h>

using namespace dronelink;

@implementation YNCSDKInfo

- (NSString *)droneType
{
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    Info::DroneType droneType;
    droneType = dl->device().info().get_drone_type();
    switch (droneType) {
        case dronelink::Info::DroneType::UNKNOWN:
            return @"UNKNOWN";
            break;
        case dronelink::Info::DroneType::TYPHOON_H_480:
            return @"TYPHOON_H_480";
            break;
        default:
            break;
    }
}


- (NSDictionary *)version
{
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    Info::Version version;
    version = dl->device().info().get_version();
    NSDictionary *dictionary = @{@"flight_sw_major":@(version.flight_sw_major),
                                 @"flight_sw_minor":@(version.flight_sw_minor),
                                 @"flight_sw_patch":@(version.flight_sw_patch),
                                 @"flight_sw_git_hash":[NSString stringWithFormat:@"%s", version.flight_sw_git_hash],
                                 @"os_sw_major":@(version.os_sw_major),
                                 @"os_sw_minor":@(version.os_sw_minor),
                                 @"os_sw_patch":@(version.os_sw_patch),
                                 @"os_sw_git_hash":[NSString stringWithFormat:@"%s", version.os_sw_git_hash],
                                 @"vendor_id":@(version.vendor_id),
                                 @"product_id":@(version.product_id)};
    return dictionary;
}

- (uint64_t)uuid
{
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    return dl->device().info().uuid();
}


@end
