/*
 * YNCSDKMission.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/

#import <Foundation/Foundation.h>

/**
 Data type for mission completion blocks that contain error results, if any.
 */
typedef void (^YNCMissionCompletion)(NSError *error);

/**
 This delegate provides status updates for waypoint missions.
 */
@protocol YNCSDKMissionDelegate <NSObject>
@optional

/**
 * Receives the current waypoint in the mission.
 *
 * @param current the current waypoint number
 * @param total the total number of waypoints in the mission
 */
- (void)receiveCurrentMissionItemIndex:(int)current WithTotalItems:(int)total;

/**
 * Receives the error status for mission commands.
 *
 * @param error the error object
 */
- (void)receiveMissionError:(NSError *)error;
@end

/**
 Data type for the callback block for mission progress updates. The callback returns the total number of waypoints, and the current waypoint number.
 */
typedef void (^YNCMissionProgressCallbackBlock)(int current, int total);

/**
 This class manages missions for the drone.
 */
@interface YNCSDKMission : NSObject

 /**
 * Sends the added waypoints to the drone and creates a mission.
 *
 * @param missionItems the array of waypoints in the mission
 * @param completion the completion function block
 */
+ (void)sendMissionWithMissionItems:(NSMutableArray *) missionItems
                     withCompletion:(YNCMissionCompletion)completion;

 /**
 * Starts the mission. If a mission has been paused, it will be continued from the current position.
 *
 * @param completion the completion function block
 */
+ (void)startMissionWithCompletion:(YNCMissionCompletion)completion;

 /**
 * Pauses the current mission.  The drone will hover in place.
 *
 * @param completion the completion function block
 */
+ (void)pauseMissionWithCompletion:(YNCMissionCompletion)completion;

/**
 * Subscribes to the progress updates in the current mission.
 *
 * @param callback the callback block
 */
+ (void)subscribeProgressWithCallback:(YNCMissionProgressCallbackBlock)callback;

/**
 * This allows to go back to 0
 *
 * @param completion the completion function block
 */
+ (void)restartMissionWithCompletion:(YNCMissionCompletion)completion;

@end
