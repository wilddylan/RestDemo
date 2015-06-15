//
//  Student.h
//  
//
//  Created by XueYulun on 15/6/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * sName;
@property (nonatomic, retain) NSString * sAddress;
@property (nonatomic, retain) NSNumber * sGender;
@property (nonatomic, retain) NSNumber * sId;

@end
