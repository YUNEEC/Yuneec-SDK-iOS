//
//  YNCSDKMission.m
//  Yuneec_SDK_iOSExample
//
//  Created by kenny on 28/12/2016.
//  Copyright © 2016 yuneec. All rights reserved.
//

#import "YNCSDKMission.h"
#import "YNCSDKMissionItem.h"
#import "YNCSDKInternal.h"

#include <dronecore/dronecore.h>
#include <functional>

using namespace dronecore;
using namespace std::placeholders; // for _1, _2, etc.

void receive_mission_error(YNCMissionCompletion completion, dronecore::Mission::Result result) {
    if (result != dronecore::Mission::Result::SUCCESS) {
        NSString *message = [NSString stringWithFormat:@"%s", dronecore::Mission::result_str(result)];
        NSError *error = [NSError errorWithDomain:@"Mission"
                                             code:(int)result
                                         userInfo:@{@"message": message}];
        completion(error);
    }
}

void receive_mission_progress(YNCMissionProgressCallbackBlock callback, int current, int total) {
    if (callback) {
        callback(current, total);
    }
}


@interface YNCSDKMission() {}
@end

@implementation YNCSDKMission

+ (void)sendMissionWithMissionItems:(NSMutableArray *)missionItems
                     withCompletion:(YNCMissionCompletion)completion {
    Mission *mission = [[YNCSDKInternal instance] mission];
    std::vector<std::shared_ptr<MissionItem>> std_vec;

    for (YNCSDKMissionItem *missionItem in missionItems) {
        std::shared_ptr<MissionItem> newItem(new MissionItem());
        newItem->set_position(missionItem.latitudeDeg, missionItem.longitudeDeg);
        newItem->set_relative_altitude(missionItem.relativeAltitudeM);
        newItem->set_fly_through(missionItem.isFlyThrough);
        newItem->set_speed(missionItem.speedMS);
        newItem->set_gimbal_pitch_and_yaw(missionItem.gimbalPitchDeg, missionItem.gimbalYawDeg);
        newItem->set_camera_action([YNCSDKMission convertIntToCameraAction:missionItem.cameraAction]);
        std_vec.push_back(newItem);
    }

    mission->upload_mission_async(std_vec, std::bind(&receive_mission_error, completion, _1));
}

+ (void)startMissionWithCompletion:(YNCMissionCompletion)completion{
    Mission *mission = [[YNCSDKInternal instance] mission];
    mission->start_mission_async(std::bind(&receive_mission_error, completion, _1));
}

+ (void)pauseMissionWithCompletion:(YNCMissionCompletion)completion {
    Mission *mission = [[YNCSDKInternal instance] mission];
    mission->pause_mission_async(std::bind(&receive_mission_error, completion, _1));
}

+ (void)subscribeProgressWithCallback:(YNCMissionProgressCallbackBlock)callback {
    Mission *mission = [[YNCSDKInternal instance] mission];
    mission->subscribe_progress(std::bind(&receive_mission_progress, callback, _1, _2));
}

+ (MissionItem::CameraAction)convertIntToCameraAction:(YNCCameraAction)raw {
    MissionItem::CameraAction cameraAction;

    switch (raw) {
        case TAKE_PHOTO:
            cameraAction = MissionItem::CameraAction::TAKE_PHOTO;
            break;
        case START_PHOTO_INTERVAL:
            cameraAction = MissionItem::CameraAction::START_PHOTO_INTERVAL;
            break;
        case STOP_PHOTO_INTERVAL:
            cameraAction = MissionItem::CameraAction::STOP_PHOTO_INTERVAL;
            break;
        case START_VIDEO:
            cameraAction = MissionItem::CameraAction::START_VIDEO;
            break;
        case STOP_VIDEO:
            cameraAction = MissionItem::CameraAction::STOP_VIDEO;
            break;
        case NONE:
            cameraAction = MissionItem::CameraAction::NONE;

        default:
            break;
    }
    return cameraAction;
}
@end
