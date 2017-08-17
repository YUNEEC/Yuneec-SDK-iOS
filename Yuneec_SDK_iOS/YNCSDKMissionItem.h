//
//  YNCSDKMissionItem.h
//  Yuneec_SDK_iOS
//
//  Created by Julian Oes on 17/02/17.
//  Copyright © 2017 Yuneec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Data type for specifying camera action types.
 */
typedef NS_ENUM (NSInteger, YNCCameraAction) {
    /** Take photo */
    TAKE_PHOTO,
    /** Start burst mode */
    START_PHOTO_INTERVAL,
    /** Stop burst mode */
    STOP_PHOTO_INTERVAL,
    /** Start video */
    START_VIDEO,
    /** Stop video */
    STOP_VIDEO,
    /** No action */
    NONE
};

/**
 This class represents a mission item, i.e. waypoint settings.
 */
@interface YNCSDKMissionItem : NSObject
    
    /** Latitude in degrees */
    @property double latitudeDeg;
    /** Longitude in degrees */
    @property double longitudeDeg;
    /** Relative altitude in meters */
    @property float relativeAltitudeM;
    /** Speed in meters per second */
    @property float speedMS;
    /** True if no stopping at the waypoint*/
    @property bool isFlyThrough;
    /** Pitch (tilt) of gimbal in degrees */
    @property float gimbalPitchDeg;
    /** Yaw (rotation/pan) angle of gimbal in degrees */
    @property float gimbalYawDeg;
    /** Camera action to perform */
    @property YNCCameraAction cameraAction;

@end
