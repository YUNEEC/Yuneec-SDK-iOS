/*
 * YNCSDKCamera.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

/**
 Data type for completion blocks for camera commands that contain error results, if any.
 */
typedef void (^YNCCameraCompletion)(NSError *error);

/**
 Data type for the different camera modes.
 */
typedef NS_ENUM (NSInteger, YNCCameraMode) {
    /**
     Set Camera.Mode to this mode to capture photos
     */
    YNCCameraModePhoto = 0,
    /**
     Set Camera.Mode to this mode for survey missions.
     This mode sets camera to AE mode, metering to "average" and also results in white balance getting locked right before the first photo is taken.
     */
    YNCCameraModePhotoSurvey,
    /**
     Set Camera.Mode to this mode to capture videos
     */
    YNCCameraModeVideo,
    /**
     Unknown camera mode
     */
    YNCCameraModeUnknown
};

/**
 Data type for completion blocks for camera mode that contain error results, if any.
 */
typedef void (^YNCCameraModeCompletion)(YNCCameraMode cameraMode, NSError *error);

/**
 This class contains fields associated with the camera status.
 */
@interface YNCCameraStatus : NSObject

@property (nonatomic, assign) BOOL videoOn;

@property (nonatomic, assign) BOOL photoIntervalOn;

@property (nonatomic, assign) BOOL storageOk;

@property (nonatomic, assign) float usedStorageMib;

@property (nonatomic, assign) float availableStorageMib;

@property (nonatomic, assign) float totalStorageMib;

@end

/**
 Data type for completion blocks for camera status that contain error results, if any.
 */
typedef void (^YNCCameraStatusCompletion)(YNCCameraStatus *cameraStatus, NSError *error);

/**
 This class provides methods for performing camera actions.
 */
@interface YNCSDKCamera : NSObject

/**
 Triggers the take photo command.

 @param completion the callback function after completion
 */
+ (void)takePhotoWithCompletion:(YNCCameraCompletion)completion;

/**
 Starts video recording.

 @param completion the callback function after completion
 */
+ (void)startVideoWithCompletion:(YNCCameraCompletion)completion;

/**
 Stops video recording.

 @param completion the callback function after completion
 */
+ (void)stopVideoWithCompletion:(YNCCameraCompletion)completion;

/**
 Starts taking photos in burst mode (every n intervals).

 @param intervalS the interval (in seconds) between photos in burst mode
 @param completion the callback function after completion
 */
+ (void)startPhotoInterval:(double)intervalS Completion:(YNCCameraCompletion)completion;

/**
 Stops taking photos in burst mode.

 @param completion the callback function after completion
 */
+ (void)stopPhotoIntervalWithCompletion:(YNCCameraCompletion)completion;

/**
 * Set camera mode
 * @param cameraMode the mode to be set
 * @param completion the callback function after completion
 */
+ (void)setCameraMode:(YNCCameraMode)cameraMode WithCompletion:(YNCCameraModeCompletion) completion;

/**
 * Get camera mode
 * @param completion the callback function after completion
 */
+ (void)getCameraModeWithCompletion:(YNCCameraModeCompletion) completion;

/**
 * Get camera status
 * @param completion the callback function after completion
 */
+ (void)getCameraStatusWithCompletion:(YNCCameraStatusCompletion) completion;

@end
