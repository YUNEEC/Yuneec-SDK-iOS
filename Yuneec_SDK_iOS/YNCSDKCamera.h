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

@end

/**
 Data type for completion blocks for camera resolution that contain error results, if any.
 */
typedef void (^YNCCameraResolutionCompletion)(YNCCameraResolution *resolution, NSError *error);

/**
 Data type for the different photo formats.
 */
typedef NS_ENUM (NSInteger, YNCCameraPhotoFormat) {
    /**
     JPG photo format
     */
    YNCCameraPhotoFormatJPG = 0,
    /**
     JPG and DNG photo format
     */
    YNCCameraPhotoFormatJPG_AND_DNG,
    /**
     Unknown photo format
     */
    YNCCameraPhotoFormatUnknown
};

/**
 Data type for completion blocks for photo format camera setting that contain error results, if any.
 */
typedef void (^YNCPhotoFormatCompletion)(YNCCameraPhotoFormat photoFormat, NSError *error);

/**
 Data type for the different video formats.
 */
typedef NS_ENUM (NSInteger, YNCCameraVideoFormat) {
    /**
     H264 video format
     */
    YNCCameraVideoFormatH264 = 0,
    /**
     H265 video photo format
     */
    YNCCameraVideoFormatH265,
    /**
     Unknown video format
     */
    YNCCameraVideoFormatUnknown
};

/**
 Data type for completion blocks for video format camera setting that contain error results, if any.
 */
typedef void (^YNCVideoFormatCompletion)(YNCCameraVideoFormat videoFormat, NSError *error);

/**
 Data type for the different photo quality.
 */
typedef NS_ENUM (NSInteger, YNCCameraPhotoQuality) {
    /**
     Photo Quality Low
     */
    YNCCameraPhotoQualityLow = 0,
    /**
     Photo Quality Medium
     */
    YNCCameraPhotoQualityMedium,
    /**
     Photo Quality High
     */
    YNCCameraPhotoQualityHigh,
    /**
     Photo Quality Ultra
     */
    YNCCameraPhotoQualityUltra,
    /**
     Unknown Photo Quality
     */
    YNCCameraPhotoQualityUnknown
};

/**
 Data type for completion blocks for photo quality camera setting that contain error results, if any.
 */
typedef void (^YNCPhotoQualityCompletion)(YNCCameraPhotoQuality photoQuality, NSError *error);

/**
 Data type for the different video resolution.
 */
typedef NS_ENUM (NSInteger, YNCCameraVideoResolution) {
    YNCCameraVideoResUHD_4096_X_2160_60FPS,
    YNCCameraVideoResUHD_4096_X_2160_50FPS,
    YNCCameraVideoResUHD_4096_X_2160_48FPS,
    YNCCameraVideoResUHD_4096_X_2160_30FPS,
    YNCCameraVideoResUHD_4096_X_2160_25FPS,
    YNCCameraVideoResUHD_4096_X_2160_24FPS,
    YNCCameraVideoResUHD_3840_X_2160_60FPS,
    YNCCameraVideoResUHD_3840_X_2160_50FPS,
    YNCCameraVideoResUHD_3840_X_2160_48FPS,
    YNCCameraVideoResUHD_3840_X_2160_30FPS,
    YNCCameraVideoResUHD_3840_X_2160_25FPS,
    YNCCameraVideoResUHD_3840_X_2160_24FPS,
    YNCCameraVideoResUHD_2720_X_1530_60FPS,
    YNCCameraVideoResUHD_2720_X_1530_48FPS,
    YNCCameraVideoResUHD_2720_X_1530_30FPS,
    YNCCameraVideoResUHD_2720_X_1530_24FPS,
    YNCCameraVideoResFHD_1920_X_1080_120FPS,
    YNCCameraVideoResFHD_1920_X_1080_60FPS,
    YNCCameraVideoResFHD_1920_X_1080_50FPS,
    YNCCameraVideoResFHD_1920_X_1080_48FPS,
    YNCCameraVideoResFHD_1920_X_1080_30FPS,
    YNCCameraVideoResFHD_1920_X_1080_25FPS,
    YNCCameraVideoResFHD_1920_X_1080_24FPS,
    YNCCameraVideoResHD_1280_X_720_120FPS,
    YNCCameraVideoResHD_1280_X_720_60FPS,
    YNCCameraVideoResHD_1280_X_720_48FPS,
    YNCCameraVideoResHD_1280_X_720_30FPS,
    YNCCameraVideoResHD_1280_X_720_24FPS,
    /**
     Unknown Video Resolution
     */
    YNCCameraVideoResUnknown
};

/**
 Data type for completion blocks for video resolution camera setting that contain error results, if any.
 */
typedef void (^YNCVideoResolutionCompletion)(YNCCameraVideoResolution videoResolution, NSError *error);

/**
 This class contains fields associated with the camera shutter speed.
 */
@interface YNCCameraShutterSpeed : NSObject

/**
 Shutter speed numerator
 */
@property (nonatomic, assign) int numerator;

/**
 Shutter speed denominator
 */
@property (nonatomic, assign) int denominator;

@end

/**
 Data type for completion blocks for camera shutter speed that contain error results, if any.
 */
typedef void (^YNCShutterSpeedCompletion)(YNCCameraShutterSpeed *shutterSpeed, NSError *error);

/**
 Data type for completion blocks for camera shutter ISO value that contain error results, if any.
 */
typedef void (^YNCISOValueCompletion)(int isoValue, NSError *error);

/**
 This class contains fields associated with the camera metering.
 */
@interface YNCCameraMetering : NSObject

/**
 Data type for the different Metering modes.
 */
typedef NS_ENUM (NSInteger, YNCCameraMeteringMode) {
    /**
     Average metering mode
     */
    YNCCameraMeteringAverage = 0,
    /**
     Center metering mode
     */
    YNCCameraMeteringCenter,
    /**
     Spot metering mode
     */
    YNCCameraMeteringSpot,
    /**
     Unknown metering mode
     */
    YNCCameraMeteringUnknown
};

/**
 Metering mode
 */
@property (nonatomic, assign) YNCCameraMeteringMode mode;
/**
 Screen width percent for spot mode
 */
@property (nonatomic, assign) int spotScreenWidthPercent;
/**
 Screen height percent for spot mode
 */
@property (nonatomic, assign) int spotScreenHeightPercent;

@end

/**
 Data type for completion blocks for camera metering mode that contain error results, if any.
 */
typedef void (^YNCMeteringCompletion)(YNCCameraMetering *metering, NSError *error);

/**
 This class contains fields associated with the camera media info.
 */
@interface YNCCameraMediaInfo : NSObject
/**
 URL of the media.
 */
@property (nonatomic, assign) NSString *path;
/**
 Media size in mib.
 */
@property (nonatomic, assign) double sizeMib;

@end

/**
 Data type for completion blocks for downloading a media that contain error results, if any.
 */
typedef void (^YNCCameraMediaCompletion)(int progress, NSError *error);

/**
 Data type for completion blocks to get the media info that contain error results, if any.
 */
typedef void (^YNCCameraMediaInfosCompletion)(NSMutableArray<YNCCameraMediaInfo*> *YNCCameraMediaInfo , NSError *error);

/**
 This class provides methods to set and get camera settings.
 */
@interface YNCSDKCameraSettings: NSObject
/**
 * Get color mode
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

/**
 * Get photo format
 * @param completion the callback function after completion
 */
+ (void)getPhotoFormatWithCompletion:(YNCPhotoFormatCompletion) completion;

/**
 * Set photo format
 * @param photoFormat the photo format to be set
 * @param completion the callback function after completion
 */
+ (void)setPhotoFormat:(YNCCameraPhotoFormat)photoFormat WithCompletion:(YNCPhotoFormatCompletion) completion;

/**
 * Get video format
 * @param completion the callback function after completion
 */
+ (void)getVideoFormatWithCompletion:(YNCVideoFormatCompletion) completion;

/**
 * Set video format
 * @param videoFormat the video format to be set
 * @param completion the callback function after completion
 */
+ (void)setVideoFormat:(YNCCameraVideoFormat)videoFormat WithCompletion:(YNCVideoFormatCompletion) completion;

/**
 * Get photo quality
 * @param completion the callback function after completion
 */
+ (void)getPhotoQualityWithCompletion:(YNCPhotoQualityCompletion) completion;

/**
 * Set photo quality
 * @param photoQuality the photo quality to be set
 * @param completion the callback function after completion
 */
+ (void)setPhotoQuality:(YNCCameraPhotoQuality)photoQuality WithCompletion:(YNCPhotoQualityCompletion) completion;

/**
 * Get video resolution
 * @param completion the callback function after completion
 */
+ (void)getVideoResolutionWithCompletion:(YNCVideoResolutionCompletion) completion;

/**
 * Set video resolution
 * @param videoResolution the video resolution to be set
 * @param completion the callback function after completion
 */
+ (void)setVideoResolution:(YNCCameraVideoResolution)videoResolution WithCompletion:(YNCVideoResolutionCompletion) completion;

/**
 * Get shutter speed
 * @param completion the callback function after completion
 */
+ (void)getShutterSpeedWithCompletion:(YNCShutterSpeedCompletion) completion;

/**
 * Set shutter speed
 * @param shutterSpeed the shutter speed to be set
 * @param completion the callback function after completion
 */
+ (void)setShutterSpeed:(YNCCameraShutterSpeed *)shutterSpeed WithCompletion:(YNCShutterSpeedCompletion) completion;

/**
 * Get ISO value
 * @param completion the callback function after completion
 */
+ (void)getISOValueWithCompletion:(YNCISOValueCompletion) completion;

/**
 * Set ISO value
 * @param isoValue the ISO value to be set
 * @param completion the callback function after completion
 */
+ (void)setISOValue:(int)isoValue WithCompletion:(YNCISOValueCompletion) completion;

/**
 * Get Metering
 * @param completion the callback function after completion
 */
+ (void)getMeteringWithCompletion:(YNCMeteringCompletion) completion;

/**
 * Set Metering
 * @param metering the metering to be set
 * @param completion the callback function after completion
 */
+ (void)setMetering:(YNCCameraMetering *)metering WithCompletion:(YNCMeteringCompletion) completion;

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

/**
 * Get media infos
 * @param completion the callback function after completion
 */
+ (void)getMediaInfosWithCompletion:(YNCCameraMediaInfosCompletion) completion;

/**
 * Get media
 * @param completion the callback function after completion
 */
+ (void)getMediaWithCompletion:(YNCCameraMediaCompletion) completion;

@end
