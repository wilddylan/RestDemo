//
//  HTTPServer.h
//  
//
//  Created by XueYulun on 15/6/15.
//
//

#import <Foundation/Foundation.h>

@interface HTTPServer : NSObject

+ (HTTPServer *)sharedInstance;

/*!
 *  Listen HTTP Request and response test Data
 */
+ (void)ListenHTTPRequest;

/*!
 *  End Listen HTTP Request
 */
+ (void)EndListenHTTPRequest;

//! @abstract Stub Url scheme array
@property (nonatomic, strong) NSDictionary * StubSchemeDict;

/*!
 *  Add Scheme For Stub
 *
 *  @param scheme url scheme description
 */
- (void)AddScheme: (NSString *)scheme file: (NSString *)fileName;

@end
