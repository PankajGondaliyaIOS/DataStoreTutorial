//
//  Artist+CoreDataProperties.h
//  DataStoreTutorial
//
//  Created by Pankaj on 02/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Artist.h"

NS_ASSUME_NONNULL_BEGIN

@interface Artist (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *artistName;
@property (nullable, nonatomic, retain) NSString *artWorkUrl;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *generOfArtist;

@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addGenerOfArtistObject:(NSManagedObject *)value;
- (void)removeGenerOfArtistObject:(NSManagedObject *)value;
- (void)addGenerOfArtist:(NSSet<NSManagedObject *> *)values;
- (void)removeGenerOfArtist:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
