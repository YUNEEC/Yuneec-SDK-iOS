/** @brief YNCSDKCamera  implementation file */

#import "YNCSDKCamera.h"

#import "YNCSDKInternal.h"

#include <dronecore/dronecore.h>
#include <functional>

using namespace dronecore;
using namespace std::placeholders;

//MARK: C Functions
//MARK: receive camera operate result
void receive_camera_result(YNCCameraCompletion completion, Camera::Result result) {
    if (completion) {
        NSError *error = nullptr;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
        }

        completion(error);
    }
}

//MARK: receive color mode result
void receive_color_mode_result(YNCColorModeCompletion completion, Camera::Result result, Camera::ColorMode colorMode) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraColorMode tmpColorMode = YNCCameraColorMode::YNCUNKNOWN;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpColorMode, error);
        }
        else {
            switch (colorMode) {
                case Camera::ColorMode::ENHANCED:
                    tmpColorMode = YNCENHANCED;
                    break;
                case Camera::ColorMode::NEUTRAL:
                    tmpColorMode = YNCNEUTRAL;
                    break;
                case Camera::ColorMode::NIGHT:
                    tmpColorMode = YNCNIGHT;
                    break;
                case Camera::ColorMode::UNPROCESSED:
                    tmpColorMode = YNCUNPROCESSED;
                    break;
                default:
                    tmpColorMode = YNCUNKNOWN;
                    break;
            }
            completion(tmpColorMode, error);
        }
    }
}

#if 0
//MARK: receive get camera setting result
void receive_camera_settings_result(YNCReceiveDataCompletionBlock completion, Camera::Result result, Camera::Settings settings) {
    if (completion) {
        NSError *error = nullptr;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(nil, error);
        } else {
            YNCCameraSettings *tmpSettings = [YNCCameraSettings new];
            tmpSettings.apertureValue = settings.aperture_value;
            tmpSettings.shutterSpeedS = settings.shutter_speed_s;
            tmpSettings.isoSensitivity = settings.iso_sensitivity;
            tmpSettings.whitespaceBalanceTemperatureK = settings.white_space_balance_temperature_k;
            tmpSettings.apertureAuto = settings.aperture_auto;
            tmpSettings.shutterAuto = settings.shutter_auto;
            tmpSettings.isoAuto = settings.iso_auto;
            tmpSettings.whitespaceAuto = settings.white_space_auto;

            completion(tmpSettings, error);
        }
    }
}
#endif

//MARK: Class YNCCameraSettings implementation
@implementation YNCCameraSettings
@end

//MARK: Class YNCSDKCamera implementation
@interface YNCSDKCamera ()

@end

@implementation YNCSDKCameraSettings

//MARK: get Camera Mode

+ (void)getColorModeWithCompletion:(YNCColorModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_color_mode_async(std::bind(&receive_color_mode_result, completion, _1, _2));
}

@end


@implementation YNCSDKCamera

//MARK: Camera TakePhoto
+ (void)takePhotoWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().take_photo_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StartVideo
+ (void)startVideoWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().start_video_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StopVideo
+ (void)stopVideoWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().stop_video_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StartPhotoInterval
+ (void)startPhotoInterval:(double)intervalS Completion:(YNCCameraCompletion)completion{
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().start_photo_interval_async(intervalS, std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StopPhotoInterval
+ (void)stopPhotoIntervalWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().stop_photo_interval_async(std::bind(&receive_camera_result, completion, _1));
}

#if 0
//MARK: Camera set settings
+ (void)setSettings:(YNCCameraSettings *)cameraSettings Completion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dronecore::Camera::Settings settings;
    settings.aperture_value = cameraSettings.apertureValue;
    settings.shutter_speed_s = cameraSettings.shutterSpeedS;
    settings.iso_sensitivity = cameraSettings.isoSensitivity;
    settings.white_space_balance_temperature_k = cameraSettings.whitespaceBalanceTemperatureK;

    settings.aperture_auto = cameraSettings.apertureAuto;
    settings.shutter_auto = cameraSettings.shutterAuto;
    settings.iso_auto = cameraSettings.isoAuto;
    settings.white_space_auto = cameraSettings.whitespaceAuto;

    dc->device().camera().set_settings_async(settings, std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera get settings
+ (void)getSettings:(YNCReceiveDataCompletionBlock)receiveDataCompletion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_settings_async(std::bind(&receive_camera_settings_result, receiveDataCompletion, _1, _2));
}
#endif

@end
