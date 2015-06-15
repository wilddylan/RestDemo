//
//  ViewController.m
//  RestDev
//
//  Created by XueYulun on 15/6/15.
//  Copyright (c) 2015年 __Dylan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CDZPingerDelegate> {
    
    CDZPinger * pingger;
}

@property (weak, nonatomic) IBOutlet M13ProgressViewStripedBar *ProgressBar;
@property (weak, nonatomic) IBOutlet M13ProgressConsole *ConsoleWindow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //! Load ping
    pingger = [[CDZPinger alloc] initWithHost:@"xx-nb.com"];
    pingger.pingWaitTime = 2;
    pingger.delegate = self;
    
    _ConsoleWindow.prefix = @"$ ";
    _ConsoleWindow.progressType = M13ProgressConsoleProgressTypePercentage;
    
    [pingger startPinging];
}

- (void)pinger:(CDZPinger *)pinger didUpdateWithAverageSeconds:(NSTimeInterval)seconds {
    
    if (_ConsoleWindow.lines.count >= 5) {
        
        [_ConsoleWindow clear];
    }
    
    [_ConsoleWindow addNewLineWithString:[NSString stringWithFormat:@"xx-nb.com; time %.f ms, Net OK", seconds * 1000]];
}

- (void)pinger:(CDZPinger *)pinger didEncounterError:(NSError *)error {
    
    [_ConsoleWindow addNewLineWithString:@"Received ping error, net Error"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*!
 *  With out Core Data
 */
- (IBAction)LocalObjects:(UIButton *)sender {
    
    [pingger stopPinging];
    
    // Add stub
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        
        return [[HTTPServer sharedInstance].StubSchemeDict.allKeys containsObject:request.URL.path];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile([[HTTPServer sharedInstance].StubSchemeDict valueForKey:@"/Car"], self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"application/json"}]
                requestTime:2
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }].name = @"CarStub";
    
    _ProgressBar.indeterminate = YES;
    [_ConsoleWindow clear];
    
    RKObjectManager * manager = [RKObjectManager sharedManager];
    [manager getObjectsAtPath:@"/Car" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
       
        _ProgressBar.indeterminate = NO;
        
        NSLog(@"%@", [mappingResult array]);
        
        [mappingResult.array enumerateObjectsUsingBlock:^(Car * obj, NSUInteger idx, BOOL *stop) {
            
            [_ConsoleWindow addNewLineWithString:[NSString stringWithFormat:@"carName = %@, seatName = %@", obj.cName, obj.cSeat.seatName]];
        }];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        _ProgressBar.indeterminate = NO;
        DDLogError(@"%@", error.localizedDescription);
        
        [_ConsoleWindow addNewLineWithString:error.localizedDescription];
    }];
}

/*!
 *  With Core Data
 */
- (IBAction)NetVirtualObjects:(UIButton *)sender {
    
    [pingger stopPinging];
    
    // Add stub
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        
        return [[HTTPServer sharedInstance].StubSchemeDict.allKeys containsObject:request.URL.path];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile([[HTTPServer sharedInstance].StubSchemeDict valueForKey:@"/Student"], self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"application/json"}]
                requestTime:2
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }].name = @"StudentStub";
    
    _ProgressBar.indeterminate = YES;
    [_ConsoleWindow clear];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/Student" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        _ProgressBar.indeterminate = NO;
        
        NSLog(@"%@", [mappingResult array]);
        
        [mappingResult.array enumerateObjectsUsingBlock:^(Student * obj, NSUInteger idx, BOOL *stop) {
            
            [_ConsoleWindow addNewLineWithString:obj.sName];
        }];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        _ProgressBar.indeterminate = NO;
        DDLogError(@"%@", error.localizedDescription);
        
        [_ConsoleWindow addNewLineWithString:error.localizedDescription];
    }];
}

@end
