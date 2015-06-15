//
//  MapEngin.m
//  
//
//  Created by XueYulun on 15/6/15.
//
//

#import "MapEngin.h"
#import "AppDelegate.h"

@implementation MapEngin

+ (void)MapStudent {
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://xx-nb.com"]];
    RKObjectManager * objectManager = ((AppDelegate *)[UIApplication sharedApplication].delegate).objectManager;
//    [objectManager.HTTPClient setDefaultHeader:[UIDevice currentDevice].systemName value:@"OperatingSystem"];
    [objectManager.HTTPClient setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    RKEntityMapping *userMapping = [RKEntityMapping mappingForEntityForName:@"Student" inManagedObjectStore:managedObjectStore];
    userMapping.identificationAttributes = @[ @"sId" ];
    [userMapping addAttributeMappingsFromDictionary:@{
                                                      @"id": @"sId",
                                                      @"gender": @"sGender",
                                                      @"address" : @"sAddress",
                                                      @"name" : @"sName"
                                                      }];
    
//    [userMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user" toKeyPath:@"user" withMapping:userMapping]];
    
    // Register our mappings with the provider
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/Student"
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RestDev.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RestDev" ofType:@"sqlite"];
    
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
}

+ (void)MapCar {
    
    RKObjectManager * objectManager = ((AppDelegate *)[UIApplication sharedApplication].delegate).objectManager;
    [objectManager.HTTPClient setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
 
    RKObjectMapping * seatMapping = [RKObjectMapping mappingForClass:[Seat class]];
    [seatMapping addAttributeMappingsFromDictionary:@{
                                                      @"name" : @"seatName"
                                                      }];
    
    RKObjectMapping * carMapping = [RKObjectMapping mappingForClass:[Car class]];
    [carMapping addAttributeMappingsFromDictionary:@{
                                                     @"name" : @"cName",
                                                     @"number" : @"cNumber",
                                                     }];
    
    // Add relation ship mapping
    RKRelationshipMapping* relationShipMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"seat"
                                                                                             toKeyPath:@"cSeat"
                                                                                           withMapping:seatMapping];
    [carMapping addPropertyMapping:relationShipMapping];
    
    RKResponseDescriptor * descriptor = [RKResponseDescriptor responseDescriptorWithMapping:carMapping method:RKRequestMethodGET pathPattern:@"/Car" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:descriptor];
}

@end
