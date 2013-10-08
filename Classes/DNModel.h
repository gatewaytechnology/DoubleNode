//
//  DNModel.h
//  Pods
//
//  Created by Darren Ehlers on 9/27/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "DNUtilities.h"

#import "DNModelWatch.h"
#import "DNModelWatch_getAll.h"

typedef void(^getFromID_resultsHandlerBlock)(id entity);

@interface DNModel : NSObject

+ (NSString*)entityName;

#pragma mark - AppDelegate access functions

+ (id<DNApplicationDelegate>)appDelegate;
+ (NSManagedObjectContext*)managedObjectContext;
+ (NSManagedObjectModel*)managedObjectModel;
+ (void)saveContext;

- (id)init;

- (NSString*)getFromIDFetchTemplate;
- (NSString*)getAllFetchTemplate;
- (NSArray*)getAllSortKeys;

- (void)getFromID:(id)idValue onResult:(getFromID_resultsHandlerBlock)resultsHandler;

- (DNModelWatch*)getAllOnResult:(getAll_resultsHandlerBlock)resultsHandler;

- (void)deleteAll;

@end