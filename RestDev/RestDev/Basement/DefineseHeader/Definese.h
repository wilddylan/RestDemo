//
//  Definese.h
//  RestDev
//
//  Created by XueYulun on 15/6/15.
//  Copyright (c) 2015年 __Dylan. All rights reserved.
//

#ifndef RestDev_Definese_h
#define RestDev_Definese_h

/*!
 *  Load Pods Library
 */
#import <RestKit/RestKit.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <MagicalRecord/MagicalRecord.h>
#import <M13ProgressSuite/M13ProgressHUD.h>
#import <M13ProgressSuite/M13ProgressViewStripedBar.h>
#import <CDZPinger/CDZPinger.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <M13ProgressSuite/M13ProgressConsole.h>

/*!
 *  Load HTTP Server
 */
#import "HTTPServer.h"
#import "MapEngin.h"

/*!
 *  Load Model
 */
#import "Student.h"

#import "Car.h"
#import "Seat.h"

/*!
 *  Singleton
 */
#undef	X_SINGLETON_DEC
#define X_SINGLETON_DEC( __class ) \
+ (__class *)sharedInstance;

#undef	X_SINGLETON_DEF
#define X_SINGLETON_DEF( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#endif
