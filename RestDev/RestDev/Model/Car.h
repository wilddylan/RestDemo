//
//  Car.h
//  
//
//  Created by XueYulun on 15/6/15.
//
//

#import <Foundation/Foundation.h>

@class Seat;
@interface Car : NSObject

@property (nonatomic, strong) NSString * cName;
@property (nonatomic, assign) NSInteger  cNumber;
@property (nonatomic, strong) Seat     * cSeat;

@end
