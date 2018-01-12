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
 Data type for the different color modes.
 */
typedef NS_ENUM (NSInteger, YNCCameraColorMode) {
    /**
     Neutral mode
     */
    YNCCameraColorModeNeutral = 0,
    /**
     Enhanced mode
     */
    YNCCameraColorModeEnhanced,
    /**
     Night mode
     */
    YNCCameraColorModeNight,
    /**
     Unprocessed mode. In this mode, no additional color processing and no artificial sharpening will be performed.
     */
    YNCCameraColorModeUnprocessed,
    /**
     Unknown color mode
     */
    YNCCameraColorModeUnknown
};

/**
 Data type for completion blocks for color mode camera setting that contain error results, if any.
 */
typedef void (^YNCColorModeCompletion)(YNCCameraColorMode colorMode, NSError *error);

/**
 Data type for the different white balance settings.
 */
typedef NS_ENUM (NSInteger, YNCCameraWhiteBalance) {
    /**
     Auto white balance setting
     */
    YNCCameraWhiteBalanceAuto = 0,
    /**
     Incandescent white balance setting
     */
    YNCCameraWhiteBalanceIncandescent,
    /**
     Sunset white balance setting
     */
    YNCCameraWhiteBalanceSunset,
    /**
     Sunnny white balance setting
     */
    YNCCameraWhiteBalanceSunny,
    /**
     Cloudy white balance setting
     */
    YNCCameraWhiteBalanceCloudy,
    /**
     Fluorescent white balance setting
     */
    YNCCameraWhiteBalanceFluorescent,
    /**
     Lock white balance setting
     */
    YNCCameraWhiteBalanceLock,
    /**
     Unknown white balance setting
     */
    YNCCameraWhiteBalanceUnknown,
};

/**
 Data type for completion blocks for white balance camera setting that contain error results, if any.
 */
typedef void (^YNCWhiteBalanceSettingCompletion)(YNCCameraWhiteBalance whiteBalance, NSError *error);

/**
 Data type for the different exposure modes.
 */
typedef NS_ENUM (NSInteger, YNCCameraExposureMode) {
    /**
     Auto mode
     */
    YNCCameraExposureModeAuto = 0,
    /**
     Manual mode
     */
    YNCCameraExposureModeManual,
    /**
     Unknown exposure mode
     */
    YNCCameraExposureModeUnknown
};

/**
 Data type for completion blocks for exposure mode camera setting that contain error results, if any.
 */
typedef void (^YNCExposureModeCompletion)(YNCCameraExposureMode exposureMode, NSError *error);

/**
 This class contains fields associated with the camera resolution.
 */
@interface YNCCameraResolution : NSObject

/**
 Pixel value for width
 */
@property (nonatomic, assign) int widthPixels;

/**
 Pixel value for height
 */
@property (nonatomic, assign) int heightPixels;

/**
 Data type for completion blocks for camera resolution that contain error results, if any.
 */
typedef void (^YNCCameraResolutionCompletion)(YNCCameraResolution *resolution, NSError *error);

@end

/**
 This class provides methods to set and get camera settings.
 */
@interface YNCSDKCameraSettings: NSObject
/**
 * Get color mode
 *
 * @param completion the callback function after completion
 */
+ (void)getColorModeWithCompletion:(YNCColorModeCompletion) completion;

/**
 * Set color mode
 * @param colorMode the color mode to be set
 * @param completion the callback function after completion
 */
+ (void)setColorMode:(YNCCameraColorMode)colorMode WithCompletion:(YNCColorModeCompletion) completion;

/**
 * Get white balance setting
 * @param completion the callback function after completion
 */
+ (void)getWhiteBalanceWithCompletion:(YNCWhiteBalanceSettingCompletion) completion;

/**
 * Set white balance setting
 * @param whiteBalance the white balance to be set
 * @param completion the callback function after completion
 */
+ (void)setWhiteBalance:(YNCCameraWhiteBalance)whiteBalance WithCompletion:(YNCWhiteBalanceSettingCompletion) completion;

/**
 * Get exposure mode
 *
 * @param completion the callback function after completion
 */
+ (void)getExposureModeWithCompletion:(YNCExposureModeCompletion) completion;

/**
 * Set exposure mode
 * @param exposureMode the exposure mode to be set
 * @param completion the callback function after completion
 */
+ (void)setExposureMode:(YNCCameraExposureMode)exposureMode WithCompletion:(YNCExposureModeCompletion) completion;

/**
 * Get camera resolution
 * @param completion the callback function after completion
 */
+ (void)getResolutionWithCompletion:(YNCCameraResolutionCompletion) completion;

@end

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

@end
