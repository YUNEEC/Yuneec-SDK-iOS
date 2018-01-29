/*
 * YNCSDKCamera.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

@class YNCCameraSettings;

/**
 Data type for completion blocks for camera commands that contain error results, if any.
 */
typedef void (^YNCCameraCompletion)(NSError *error);

/**
 Completion block for the asynchronous getSettings() function for the camera.

 @param receiveData The camera setting data
 @param error The error object if an error occurred during the get operation, or nil if no error occurred.
 */
typedef void (^YNCReceiveDataCompletionBlock)(YNCCameraSettings *receiveData, NSError *error);

/**
 This class manages the camera settings of the drone.
 */
@interface YNCCameraSettings : NSObject
/**
 Aperture value, the amount of light allowed in while the shutter is open.
 */
@property (nonatomic, assign) double apertureValue;

/**
 Shutter speed (in seconds). The interval for which the shutter is open.
 */
@property (nonatomic, assign) double shutterSpeedS;

/**
 ISO value. The sensitivity to light of the sensor.
 */
@property (nonatomic, assign) double isoSensitivity;

/**
 White balance temperature (in K). Defines the color rendering of the sensor.
 */
@property (nonatomic, assign) double whitespaceBalanceTemperatureK;

/**
 True, if auto aperture mode. Aperture is set by the camera while Shutter Speed/ISO can be managed by the user.
 */
@property (nonatomic, assign) BOOL apertureAuto;

/**
 True, if auto shutter speed mode. Shutter Speed is set by the camera while Aperture/ISO can be managed by the user.
 */
@property (nonatomic, assign) BOOL shutterAuto;

/**
 True, if auto ISO mode. ISO is set by the camera while Shutter Speed/Aperture can be managed by the user.
 */
@property (nonatomic, assign) BOOL isoAuto;

/**
 True, if auto white balance mode. Camera will autoselect the best white balance based on the scene.
 */
@property (nonatomic, assign) BOOL whitespaceAuto;

@end

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


#if 0
/**
 Sets the camera settings.

 @param completion the callback function after completion
 */
+ (void)setSettings:(YNCCameraSettings *)cameraSettings Completion:(YNCCameraCompletion)completion;

/**
 Gets the camera settings.

 @param receiveDataCompletion the completion block for getSettings()
 */
+ (void)getSettings:(YNCReceiveDataCompletionBlock)receiveDataCompletion;
#endif

@end
