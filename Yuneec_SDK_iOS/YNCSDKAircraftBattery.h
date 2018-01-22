//
//  YNCSDKAircraftBattery.h
//  Yuneec_SDK_iOS
//
//  Copyright © 2018 Yuneec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class manages the real-time status of the battery component.
 */
@interface YNCBattery : NSObject

/**
 Battery voltage (in volts)
 */
@property (nonatomic, assign) float voltageV;

/**
 Battery remaining (as a percentage)
 */
@property (nonatomic, assign) float remainingPercent;

@end

/**
 * This protocol provides delegate methods to subscribe to battery status updates.
 */
@protocol YNCSDKBatteryDelegate <NSObject>

/**
 * Receives battery status updates.
 *
 * @param battery the battery object
 */
- (void)onBatteryUpdate:(YNCBattery *)battery;
@end

/**
 This class provides a method to subscribe to battery status updates.
 */
@interface YNCSDKBattery : NSObject

/**
 * Subscribes to battery status updates.
 *
 * @param delegate The Battery delegate object
 */
- (void)subscribe:(id<YNCSDKBatteryDelegate>) delegate;
@end

