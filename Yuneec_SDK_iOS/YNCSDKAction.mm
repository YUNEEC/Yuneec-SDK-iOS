//
//  YNCSDKAction.m
//  Yuneec_SDK_iOSExample
//
//  Created by Julian Oes on 22/12/16.
//  Copyright © 2016 yuneec. All rights reserved.
//

#import "YNCSDKAction.h"
#import "YNCSDKInternal.h"

#include <dronecore/dronecore.h>
#include <functional>

using namespace dronecore;
using namespace std::placeholders; // for _1, _2, etc.


void receive_action_error(YNCActionCompletion completion, Action::Result result) {
    if (completion) {
        NSError *error = nullptr;
        if (result != Action::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Action::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Action"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(error);
        }
    }
}

@implementation YNCAction

+ (void)armWithCompletion:(YNCActionCompletion)completion {
    Action *action = [[YNCSDKInternal instance] action];
    action->arm_async(std::bind(&receive_action_error, completion, _1));
}

+ (void)disarmWithCompletion:(YNCActionCompletion)completion {
    Action *action = [[YNCSDKInternal instance] action];
    action->disarm_async(std::bind(&receive_action_error, completion, _1));
}

+ (void)takeoffWithCompletion:(YNCActionCompletion)completion {
    Action *action = [[YNCSDKInternal instance] action];
    //action->set_takeoff_altitude(1.0);
    action->takeoff_async(std::bind(&receive_action_error, completion, _1));
}

+ (void)landWithCompletion:(YNCActionCompletion)completion {
    Action *action = [[YNCSDKInternal instance] action];
    action->land_async(std::bind(&receive_action_error, completion, _1));
}

+ (void)doReturnToLaunchWithCompletion:(YNCActionCompletion)completion {
    Action *action = [[YNCSDKInternal instance] action];
    action->return_to_launch_async(std::bind(&receive_action_error, completion, _1));
}

+ (void)killWithCompletion:(YNCActionCompletion)completion {
    Action *action = [[YNCSDKInternal instance] action];
    action->kill_async(std::bind(&receive_action_error, completion, _1));
}

@end
