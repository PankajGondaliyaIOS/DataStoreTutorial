//
//  DatabaseManager.h
//  CoreDataTutorial
//
//  Created by Pankaj on 31/07/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

+ (DatabaseManager *)sharedInstance;
-(void)insertArtistAndGener:(NSDictionary*)dictArtist;
-(NSArray*)fetchAllArtists;
-(void)deleteAllArtist;
-(void)deleteAllGener;

@end
