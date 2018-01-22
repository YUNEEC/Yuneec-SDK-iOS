//
//  YNCSDKAircraftHealth.h
//  Yuneec_SDK_iOS
//
//  Copyright © 2018 Yuneec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class contains the drone's component health and status.
 */
@interface YNCHealth : NSObject

/**
 State of the gyroscope calibration
 */
@property (nonatomic, assign) BOOL gyrometerCalibrationOk;

/**
 State of the accelerometer calibration
 */
@property (nonatomic, assign) BOOL accelerometerCalibrationOk;

/**
 State of the magnetometer calibration
 */
@property (nonatomic, assign) BOOL magnetometerCalibrationOk;

/**
 State of the level calibration
 */
@property (nonatomic, assign) BOOL levelCalibrationOk;

/**
 Status of the local position
 */
@property (nonatomic, assign) BOOL localPositionOk;

/**
 Status of the global position
 */
@property (nonatomic, assign) BOOL globalPositionOk;

/**
 Status of the home position
 */
@property (nonatomic, assign) BOOL homePositionOk;

@end

/**
 This delegate provides health status updates of the drone.
 */
@protocol YNCSDKAircraftHealthDelegate <NSObject>
/**
 Receives health status updates.
 
 @param health The health status
 */
- (void)onHealthUpdate:(YNCHealth *)health;
@end

/**
 This class provides a method to subscribe to drone health updates.
 */
@interface YNCSDKAircraftHealth: NSObject
/**
 * Subscribes to drone health updates.
 *
 * @param delegate The Drone Health delegate object
 */
- (void)subscribe:(id<YNCSDKAircraftHealthDelegate>) delegate;
@end

/**
 This delegate provides the overall health status.
 */
@protocol YNCSDKAircraftHealthAllOkDelegate <NSObject>
/**
 Receives overall health status updates.
 
 @param healthAllOk true if all health flags are ok
 */
- (void)onHealthAllOkUpdate:(BOOL)healthAllOk;
@end

/**
 This class provides a method to subscribe to overall health status updates.
 */
@interface YNCSDKAircraftHealthAllOk: NSObject
/**
 * Subscribes to overall health status updates.
 *
 * @param delegate The Overall Health delegate object
 */
- (void)subscribe:(id<YNCSDKAircraftHealthAllOkDelegate>) delegate;
@end

