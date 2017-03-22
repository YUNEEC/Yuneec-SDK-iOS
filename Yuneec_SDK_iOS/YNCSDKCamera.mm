/** @brief YNCSDKCamera  implementation file */

#import "YNCSDKCamera.h"

#import "YNCSDKInternal.h"

#include <dronelink/dronelink.h>
#include <functional>

using namespace dronelink;
using namespace std::placeholders;

//MARK: C Functions
//MARK: receive camera operate result
void receive_camera_result(YNCCompletionBlock completion, Camera::Result result) {
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

//MARK: Class YNCCameraSettings implementation
@implementation YNCCameraSettings
@end

//MARK: Class YNCSDKCamera implementation
@interface YNCSDKCamera ()

@end

@implementation YNCSDKCamera

//MARK: Camera TakePhoto
+ (void)takePhotoWithCompletion:(YNCCompletionBlock)completion {
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().camera().take_photo_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StartVideo
+ (void)startVideoWithCompletion:(YNCCompletionBlock)completion {
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().camera().start_video_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StopVideo
+ (void)stopVideoWithCompletion:(YNCCompletionBlock)completion {
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().camera().stop_video_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StartPhotoInterval
+ (void)startPhotoInterval:(double)intervalS Completion:(YNCCompletionBlock)completion{
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().camera().start_photo_interval_async(intervalS, std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StopPhotoInterval
+ (void)stopPhotoIntervalWithCompletion:(YNCCompletionBlock)completion {
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().camera().stop_photo_interval_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera set settings
+ (void)setSettings:(YNCCameraSettings *)cameraSettings Completion:(YNCCompletionBlock)completion {
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dronelink::Camera::Settings settings;
    settings.aperture_value = cameraSettings.apertureValue;
    settings.shutter_speed_s = cameraSettings.shutterSpeedS;
    settings.iso_sensitivity = cameraSettings.isoSensitivity;
    settings.white_space_balance_temperature_k = cameraSettings.whitespaceBalanceTemperatureK;
    
    settings.aperture_auto = cameraSettings.apertureAuto;
    settings.shutter_auto = cameraSettings.shutterAuto;
    settings.iso_auto = cameraSettings.isoAuto;
    settings.white_space_auto = cameraSettings.whitespaceAuto;
    
    dl->device().camera().set_settings_async(settings, std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera get settings
+ (void)getSettings:(YNCReceiveDataCompletionBlock)receiveDataCompletion {
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().camera().get_settings_async(std::bind(&receive_camera_settings_result, receiveDataCompletion, _1, _2));
}

@end
