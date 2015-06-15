//
//  HTTPServer.m
//
//
//  Created by XueYulun on 15/6/15.
//
//

#import "HTTPServer.h"

@implementation HTTPServer

X_SINGLETON_DEF(HTTPServer)

+ (void)ListenHTTPRequest {
    
    [OHHTTPStubs setEnabled:YES];
    
    [OHHTTPStubs onStubActivation:^(NSURLRequest *request, id<OHHTTPStubsDescriptor> stub) {
        DDLogDebug(@"[HTTP Swizzle]: Request: %@, stubbed: %@", request.URL, stub.name);
    }];
}

+ (void)EndListenHTTPRequest {
    
    [OHHTTPStubs setEnabled:NO];
}

- (void)AddScheme: (NSString *)scheme file: (NSString *)fileName {
    
    [self.StubSchemeDict setValue:fileName forKey:scheme];
}

- (NSDictionary *)StubSchemeDict {
    
    if (!_StubSchemeDict) {
        _StubSchemeDict = [NSMutableDictionary dictionary];
    }
    
    return _StubSchemeDict;
}

@end
