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

//MARK: receive camera mode result
void receive_camera_mode_result(YNCCameraModeCompletion completion, Camera::Result result, Camera::Mode mode) {
    if (completion) {
        YNCCameraMode tmpMode = YNCCameraMode::YNCCameraModeUnknown;
        NSError *error = nullptr;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
        completion(tmpMode, error);
        }
        else {
            switch (mode) {
                case Camera::Mode::PHOTO:
                    tmpMode = YNCCameraModePhoto;
                    break;
                case Camera::Mode::PHOTO_SURVEY:
                    tmpMode = YNCCameraModePhotoSurvey;
                    break;
                case Camera::Mode::VIDEO:
                    tmpMode = YNCCameraModeVideo;
                    break;
                default:
                    tmpMode = YNCCameraModeUnknown;
                    break;
            }
        }
        completion(tmpMode, error);
    }
}

//MARK: receive camera status result
void receive_camera_status_result(YNCCameraStatusCompletion completion, Camera::Result result, Camera::Status status) {
    if (completion) {
        NSError *error = nullptr;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(nil, error);
        }
        else {
            YNCCameraStatus *tmpStatus = [YNCCameraStatus new];
            tmpStatus.photoIntervalOn = status.photo_interval_on;
            tmpStatus.videoOn = status.video_on;
            tmpStatus.availableStorageMib = status.available_storage_mib;
            tmpStatus.totalStorageMib = status.total_storage_mib;
            tmpStatus.usedStorageMib = status.used_storage_mib;
            switch (status.storage_status) {
                case Camera::Status::StorageStatus::FORMATTED:
                    tmpStatus.storageOk = true;
                    break;
                case Camera::Status::StorageStatus::UNFORMATTED:
                    tmpStatus.storageOk = true;
                    break;
                case Camera::Status::StorageStatus::NOT_AVAILABLE:
                    tmpStatus.storageOk = false;
                    break;
                default:
                    break;
            }
            completion(tmpStatus, error);
        }
    }
}

Camera::Mode getCameraModeEnum(YNCCameraMode mode) {
    Camera::Mode cameraMode;
    switch (mode) {
        case YNCCameraModePhoto:
            cameraMode = Camera::Mode::PHOTO;
            break;
        case YNCCameraModeVideo:
            cameraMode = Camera::Mode::VIDEO;
            break;
        case YNCCameraModePhotoSurvey:
            cameraMode = Camera::Mode::PHOTO_SURVEY;
            break;
        default:
            cameraMode = Camera::Mode::UNKNOWN;
            break;
    }
    return cameraMode;
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

//MARK: Class YNCCameraStatus implementation
@implementation YNCCameraStatus
@end

//MARK: Class YNCSDKCamera implementation
@interface YNCSDKCamera ()

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

//MARK: set camera mode
+ (void) setCameraMode:(YNCCameraMode)cameraMode WithCompletion:(YNCCameraModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::Mode cameraModeVal = getCameraModeEnum(cameraMode);
    dc->device().camera().set_mode_async(cameraModeVal,std::bind(&receive_camera_mode_result,completion,_1,_2));
}

//MARK: get camera mode
+ (void) getCameraModeWithCompletion:(YNCCameraModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_mode_async(std::bind(&receive_camera_mode_result,completion,_1,_2));
}

//MARK: get camera status
+ (void) getCameraStatusWithCompletion:(YNCCameraStatusCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_status_async(std::bind(&receive_camera_status_result,completion,_1,_2));
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
