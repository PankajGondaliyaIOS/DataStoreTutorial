//
//  DatabaseManager.m
//  DataStoreTutorial
//
//  Created by Pankaj on 02/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "DatabaseManager.h"
#import "Constant.h"
#import <CoreData/CoreData.h>
#import "Artist.h"  
#import "Gener.h"

@implementation DatabaseManager

+ (DatabaseManager *)sharedInstance {
    static DatabaseManager *databaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseManager = [[self alloc] init];
    });
    return databaseManager;
}

#pragma mark - Entity Artist
-(void)insertArtistAndGener:(NSDictionary*)dictArtist {
    NSMutableSet*setGener = [[NSMutableSet alloc] init];
    
    NSArray *arrGener =dictArtist[@"genreNames"];
    
    for(NSString *strGener in arrGener) {
        
       NSArray *arrGener =  [self fetchGener:strGener];
        
        if (arrGener.count > 0) {
            // Add Gener
            [setGener addObject:arrGener[0]];
        } else {
            // Add Gener
            [setGener addObject:[self insertGener:strGener]];
        }
    }
    
    [self doInsertArtist:dictArtist[@"artistName"] artworkUrl:dictArtist[@"artworkUrl100"] gener:setGener];
}

-(void)doInsertArtist:(NSString*)artistName artworkUrl:(NSString *)artWorkUrl gener:(NSSet<Gener *> *)Gener {
    
    Artist *artist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:appDelegate.managedObjectContext];
    artist.artistName = artistName;
    artist.artWorkUrl = artWorkUrl;
    [artist addGenerOfArtist:Gener];
    
    // Save the context
    NSError *error = nil;
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    } else {
       // NSLog(@"Artist is added:%@",artist.artistName);
    }
}

-(NSArray*)fetchAllArtists {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Artist" inManagedObjectContext:appDelegate.managedObjectContext];
    NSError *error = nil;
    NSArray *arrArtists = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    //NSLog(@"%@",arrArtists);
    return arrArtists;
}

//Deleting all artists because it is adding new objects everytime WHILE TESTING USING testDataAndTime method
-(void)deleteAllArtist {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Artist"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    [appDelegate.persistentStoreCoordinator executeRequest:delete withContext:appDelegate.managedObjectContext error:&deleteError];
}

#pragma mark - Entity Gener
-(NSArray*)fetchGener:(NSString*)strGenerName {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Gener" inManagedObjectContext:appDelegate.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"generName = %@", strGenerName];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *arrGener = [appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    return arrGener;
}

-(Gener*)insertGener:(NSString *)strGenerName {
    Gener *gener = [NSEntityDescription insertNewObjectForEntityForName:@"Gener" inManagedObjectContext:appDelegate.managedObjectContext];
    [gener setValue:strGenerName forKey:@"generName"];
    // Save the context
    NSError *error = nil;
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    return gener;
}

//Deleting all geners because it is adding new objects everytime WHILE TESTING USING testDataAndTime method
-(void)deleteAllGener {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Gener"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    [appDelegate.persistentStoreCoordinator executeRequest:delete withContext:appDelegate.managedObjectContext error:&deleteError];
}


@end
