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
        YNCCameraColorMode tmpColorMode = YNCCameraColorMode::YNCCameraColorModeUnknown;
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
                    tmpColorMode = YNCCameraColorModeEnhanced;
                    break;
                case Camera::ColorMode::NEUTRAL:
                    tmpColorMode = YNCCameraColorModeNeutral;
                    break;
                case Camera::ColorMode::NIGHT:
                    tmpColorMode = YNCCameraColorModeNight;
                    break;
                case Camera::ColorMode::UNPROCESSED:
                    tmpColorMode = YNCCameraColorModeUnprocessed;
                    break;
                default:
                    tmpColorMode = YNCCameraColorModeUnknown;
                    break;
            }
            completion(tmpColorMode, error);
        }
    }
}

Camera::ColorMode getColorModeEnum(YNCCameraColorMode colorMode) {
    Camera::ColorMode cameraColorMode;
    switch (colorMode) {
    case YNCCameraColorModeEnhanced:
            cameraColorMode = Camera::ColorMode::ENHANCED;
        break;
    case YNCCameraColorModeNight:
            cameraColorMode = Camera::ColorMode::NIGHT;
        break;
    case YNCCameraColorModeNeutral:
            cameraColorMode = Camera::ColorMode::NEUTRAL;
        break;
    case YNCCameraColorModeUnprocessed:
            cameraColorMode = Camera::ColorMode::UNPROCESSED;
        break;
    default:
        cameraColorMode = Camera::ColorMode::UNKNOWN;
        break;
    }
    return cameraColorMode;
}

//MARK: receive white balance result
void receive_white_balance_result(YNCWhiteBalanceSettingCompletion completion, Camera::Result result, Camera::WhiteBalance whiteBalance) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraWhiteBalance tmpWhiteBalalnce = YNCCameraWhiteBalance::YNCCameraWhiteBalanceUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpWhiteBalalnce, error);
        }
        else {
            switch (whiteBalance) {
                case Camera::WhiteBalance::AUTO:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceAuto;
                    break;
                case Camera::WhiteBalance::CLOUDY:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceCloudy;
                    break;
                case Camera::WhiteBalance::FLUORESCENT:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceFluorescent;
                    break;
                case Camera::WhiteBalance::INCANDESCENT:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceIncandescent;
                    break;
                case Camera::WhiteBalance::LOCK:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceLock;
                    break;
                case Camera::WhiteBalance::SUNNY:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceSunny;
                    break;
                case Camera::WhiteBalance::SUNSET:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceSunset;
                    break;
                default:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceUnknown;
                    break;
            }
            completion(tmpWhiteBalalnce, error);
        }
    }
}

Camera::WhiteBalance getWhiteBalanceEnum(YNCCameraWhiteBalance whiteBalance) {
    Camera::WhiteBalance cameraWhiteBalance;
    switch (whiteBalance) {
        case YNCCameraWhiteBalanceAuto:
            cameraWhiteBalance = Camera::WhiteBalance::AUTO;
            break;
        case YNCCameraWhiteBalanceSunset:
            cameraWhiteBalance = Camera::WhiteBalance::SUNSET;
            break;
        case YNCCameraWhiteBalanceSunny:
            cameraWhiteBalance = Camera::WhiteBalance::SUNNY;
            break;
        case YNCCameraWhiteBalanceIncandescent:
            cameraWhiteBalance = Camera::WhiteBalance::INCANDESCENT;
            break;
        case YNCCameraWhiteBalanceFluorescent:
            cameraWhiteBalance = Camera::WhiteBalance::FLUORESCENT;
            break;
        case YNCCameraWhiteBalanceCloudy:
            cameraWhiteBalance = Camera::WhiteBalance::CLOUDY;
            break;
        case YNCCameraWhiteBalanceLock:
            cameraWhiteBalance = Camera::WhiteBalance::LOCK;
            break;
        default:
            cameraWhiteBalance = Camera::WhiteBalance::UNKNOWN;
            break;
    }
    return cameraWhiteBalance;
}

//MARK: receive exposure mode result
void receive_exposure_mode_result(YNCExposureModeCompletion completion, Camera::Result result, Camera::ExposureMode exposureMode) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraExposureMode tmpExposureMode = YNCCameraExposureMode::YNCCameraExposureModeUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpExposureMode, error);
        }
        else {
            switch (exposureMode) {
                case Camera::ExposureMode::AUTO:
                    tmpExposureMode = YNCCameraExposureModeAuto;
                    break;
                case Camera::ExposureMode::MANUAL:
                    tmpExposureMode = YNCCameraExposureModeManual;
                    break;
                default:
                    tmpExposureMode = YNCCameraExposureModeUnknown;
                    break;
            }
            completion(tmpExposureMode, error);
        }
    }
}

Camera::ExposureMode getExposureModeEnum(YNCCameraExposureMode exposureMode) {
    Camera::ExposureMode cameraExposureMode;
    switch (exposureMode) {
        case YNCCameraExposureModeAuto:
            cameraExposureMode = Camera::ExposureMode::AUTO;
            break;
        case YNCCameraExposureModeManual:
            cameraExposureMode = Camera::ExposureMode::MANUAL;
            break;
        default:
            cameraExposureMode = Camera::ExposureMode::UNKNOWN;
            break;
    }
    return cameraExposureMode;
}

//MARK: receive camera resolution result
void receive_resolution_result(YNCCameraResolutionCompletion completion, Camera::Result result, Camera::Resolution resolution) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraResolution *tmpResolution = [YNCCameraResolution new];
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpResolution, error);
        }
        else {
            //tmpResolution.widthPixels = resolution.width_pixels;
            //tmpResolution.heightPixels = resolution.height_pixels;
            completion(tmpResolution, error);
        }
    }
}

//MARK: Class YNCSDKCamera implementation
@interface YNCSDKCamera ()

@end

@implementation YNCCameraResolution

@end

@implementation YNCSDKCameraSettings

//MARK: get Camera Mode
+ (void)getColorModeWithCompletion:(YNCColorModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_color_mode_async(std::bind(&receive_color_mode_result, completion, _1, _2));
}

//MARK: set Color Mode
+ (void)setColorMode:(YNCCameraColorMode)colorMode WithCompletion:(YNCColorModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::ColorMode cameraColorMode = getColorModeEnum(colorMode);
    dc->device().camera().set_color_mode_async(cameraColorMode, std::bind(&receive_color_mode_result, completion, _1, _2));
}

//MARK: get White Balance Setting
+ (void)getWhiteBalanceWithCompletion:(YNCWhiteBalanceSettingCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_white_balance_async(std::bind(&receive_white_balance_result, completion, _1, _2));
}

//MARK: set White Balance

+ (void)setWhiteBalance:(YNCCameraWhiteBalance)whiteBalance WithCompletion:(YNCWhiteBalanceSettingCompletion)completion{
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::WhiteBalance cameraWhiteBalance = getWhiteBalanceEnum(whiteBalance);
    dc->device().camera().set_white_balance_async(cameraWhiteBalance, std::bind(&receive_white_balance_result, completion, _1, _2));
}

//MARK: get Exposure Mode
+ (void)getExposureModeWithCompletion:(YNCExposureModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_exposure_mode_async(std::bind(&receive_exposure_mode_result, completion, _1, _2));
}

//MARK: set Exposure Mode
+ (void)setExposureMode:(YNCCameraExposureMode)exposureMode WithCompletion:(YNCExposureModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::ExposureMode cameraExposureMode = getExposureModeEnum(exposureMode);
    dc->device().camera().set_exposure_mode_async(cameraExposureMode, std::bind(&receive_exposure_mode_result, completion, _1, _2));
}

//MARK: get Resolution
+ (void)getResolutionWithCompletion:(YNCCameraResolutionCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_resolution_async(std::bind(&receive_resolution_result,completion, _1, _2));
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

@end
