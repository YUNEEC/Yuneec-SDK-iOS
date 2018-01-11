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

//MARK: Class YNCSDKCamera implementation
@interface YNCSDKCamera ()

@end

@implementation YNCSDKCameraSettings

//MARK: get Camera Mode

+ (void)getColorModeWithCompletion:(YNCColorModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_color_mode_async(std::bind(&receive_color_mode_result, completion, _1, _2));
}

+ (void)setColorMode:(YNCCameraColorMode)colorMode WithCompletion:(YNCColorModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::ColorMode cameraColorMode = getColorModeEnum(colorMode);
    dc->device().camera().set_color_mode_async(cameraColorMode, std::bind(&receive_color_mode_result, completion, _1, _2));
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
