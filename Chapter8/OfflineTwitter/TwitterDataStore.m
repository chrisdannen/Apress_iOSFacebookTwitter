//
//  TwitterDataStore.m
//  OfflineTwitter
//
//  Created by Christopher White on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterDataStore.h"
#import <CoreData/CoreData.h>
#import "Tweet.h"

@implementation TwitterDataStore

@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

- (NSArray*)tweets 
{
    NSMutableArray *tweets = nil;
    
    @synchronized(self) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tweet" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
        [sortDescriptors release];
        [sortDescriptor release];
        
        NSError *error = nil;
        NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        if (mutableFetchResults == nil) {
            // Handle the error.
        }
        
        tweets = [mutableFetchResults retain];
        [mutableFetchResults release];    
        [request release];
    }

    return tweets;
}

- (void)deleteTweets
{
    @synchronized(self) {
        NSArray *tweets = [self tweets];
        for (Tweet *tweet in tweets) {
            [self.managedObjectContext deleteObject:tweet];
        }
        
        // Commit the change.
        
        NSError *error = nil;
        
        if (![self.managedObjectContext save:&error]) {
            // Handle the error.
        }
    }
}

- (void)synchronizeTweets:(NSArray*)tweets
{
    NSAutoreleasePool *autoReleasePool = [[NSAutoreleasePool alloc] init];
    
    @synchronized(self) {
        [self deleteTweets];
        
        for (NSDictionary *tweetDictionary in tweets) {
            Tweet *tweet = (Tweet *)[NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:self.managedObjectContext];
            
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            NSNumber * tweetId = [f numberFromString:[tweetDictionary objectForKey:@"id"]];
            [tweet setId:tweetId];
            [f release];

            NSString *text = [tweetDictionary objectForKey:@"text"];
            [tweet setText:text];
        }

        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Handle the error.
        }
    }
    
    //post a notification that the tweets are available...have responder update itself on the main thread
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tweetsDidSynchronize" 
														object:self 
													  userInfo:nil];
    
    [autoReleasePool release];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataOffline" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataOffline.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)dealloc
{
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

@end
