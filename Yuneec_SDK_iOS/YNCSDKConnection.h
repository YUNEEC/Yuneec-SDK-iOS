/*
 * YNCSDKConnection.h
 * YUNEEC_SDK_IOS
 *
 * Copyright @ 2016 Yuneec.
 * All rights reserved.
 *
*/ 

#import <Foundation/Foundation.h>

/**
 Data type for connection results.
 */
typedef NS_ENUM (NSInteger, YNCConnectionResult) {
    /**
     Success
     */
    YNCConnectionResultSuccess = 0,
    /**
     Timeout
     */
    YNCConnectionResultTimeOut,
    /**
     Socket Error
     */
    YNCConnectionResultSocketError,
    /**
     Socket Connection Error
     */
    YNCConnectionResultSocketConnectionError,
    /**
     Bind Error
     */
    YNCConnectionResultBindError,
    /**
     ConnectionError
     */
    YNCConnectionResultConnectionError,
    /**
     Not Implemented
     */
    YNCConnectionResultNotImplemented,
    /**
     Device Not Connected
     */
    YNCConnectionResultDeviceNotConnected,
    /**
     Device Busy
     */
    YNCConnectionResultDeviceBusy,
    /**
     Command Denied
     */
    YNCConnectionResultCommandDenied,
    /**
     Destination Ip Unknown
     */
    YNCConnectionResultDestinationIpUnknown,
    /**
     Connections Exhausted
     */
    YNCConnectionResultConnectionsExhausted,
    /**
     Unknown
     */
    YNCConnectionResultUnknown
};

/**
 This delegate provides notification of the connection status.
 */
@protocol YNCSDKConnectionDelegate <NSObject>
@optional
/**
 Connection to drone has been detected (or re-connected).
 */
- (void)onDiscover;

/**
 Connection to drone has timed out. No heartbeat has been received for over 3 seconds.
 */
- (void)onTimeout;
@end

/**
 This class provides methods to manage the wireless link to the drone.
 */
@interface YNCSDKConnection : NSObject
/**
 Returns a singleton instance for the connection.
 */
+ (id)instance;

/**
 * Get connection result string
 * @param connectionResultEnum the connection result Enum
 */
+ (NSString*)getConnectionResultString:(YNCConnectionResult) connectionResultEnum;

/**
 Initiates the connection over UDP to the drone.
 
 @return YNCConnectionResult. In case of error, check the log output for more info.
 */
- (YNCConnectionResult)connect;

/**
  * Remove connection to the drone.
  */
- (void)removeConnection;

/**
 Sets a delegate to get notified about the connection status.
 */
- (void)setDelegate:(id<YNCSDKConnectionDelegate>)delegate;

@end
