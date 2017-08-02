//
//  DatabaseManager.h
//  DataStoreTutorial
//
//  Created by Pankaj on 02/08/17.
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
