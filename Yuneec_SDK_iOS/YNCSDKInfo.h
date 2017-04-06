/*
 * YNCSDKInfo.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

/**
 Completion block for asynchronous operations. This completion block is used for methods that return at an unknown future time.
 @param error the error object if an error occurred during async operation, or nil if no error occurred.
 */
typedef void (^YNCCompletionBlock)(NSError *error);

/**
 This class provides methods to access basic drone info.
 */
@interface YNCSDKInfo : NSObject

/**
 Drone type
 */
@property (nonatomic, copy, readonly) NSString *droneType;

/**
 * Initializes the drone object with a dictionary.
 */
@property (nonatomic, copy, readonly) NSDictionary *version;

/**
 UUID
 */
@property (nonatomic, assign, readonly) uint64_t uuid;

@end
