/*
 * YNCSDKCamera.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

#import "YNCSDKDrone.h"

@class YNCCameraSettings;

/**
 Completion block for the asynchronous getSettings() function for the camera.

 @param receiveData the camera setting data
 @param error the error object if an error occurred during the get operation, or nil if no error occurred.
 */
typedef void (^YNCReceiveDataCompletionBlock)(YNCCameraSettings *receiveData, NSError *error);

/**
 This class manages the camera settings of the drone.
 */
@interface YNCCameraSettings : NSObject
/**
 Aperture value
 */
@property (nonatomic, assign) double apertureValue;

/**
 Shutter speed (in seconds)
 */
@property (nonatomic, assign) double shutterSpeedS;

/**
 ISO value
 */
@property (nonatomic, assign) double isoSensitivity;

/**
 White balance temperature (in K)
 */
@property (nonatomic, assign) double whitespaceBalanceTemperatureK;

/**
 True, if auto aperture mode
 */
@property (nonatomic, assign) BOOL apertureAuto;

/**
 True, if auto shutter speed mode
 */
@property (nonatomic, assign) BOOL shutterAuto;

/**
 True, if auto ISO mode
 */
@property (nonatomic, assign) BOOL isoAuto;

/**
 True, if auto white balance mode
 */
@property (nonatomic, assign) BOOL whitespaceAuto;

@end

/**
 This class provides methods for performing camera actions.
 */
@interface YNCSDKCamera : NSObject

/**
 Triggers the take photo command.
 
 @param completion the callback function after completion
 */
+ (void)takePhotoWithCompletion:(YNCCompletionBlock)completion;

/**
 Starts video recording.
 
 @param completion the callback function after completion
 */
+ (void)startVideoWithCompletion:(YNCCompletionBlock)completion;

/**
 Stops video recording.
 
 @param completion the callback function after completion
 */
+ (void)stopVideoWithCompletion:(YNCCompletionBlock)completion;

/**
 Starts taking photos in burst mode (every n intervals).
 
 @param intervalS the interval (in seconds) between photos in burst mode
 @param completion the callback function after completion
 */
+ (void)startPhotoInterval:(double)intervalS Completion:(YNCCompletionBlock)completion;

/**
 Stops taking photos in burst mode.
 
 @param completion the callback function after completion
 */
+ (void)stopPhotoIntervalWithCompletion:(YNCCompletionBlock)completion;

/**
 Sets the camera settings.
 
 @param completion the callback function after completion
 */
+ (void)setSettings:(YNCCameraSettings *)cameraSettings Completion:(YNCCompletionBlock)completion;

/**
 Gets the camera settings.
 
 @param receiveDataCompletion the completion block for getSettings()
 */
+ (void)getSettings:(YNCReceiveDataCompletionBlock)receiveDataCompletion;

@end
