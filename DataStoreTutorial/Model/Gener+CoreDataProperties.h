//
//  Gener+CoreDataProperties.h
//  DataStoreTutorial
//
//  Created by Pankaj on 02/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Gener.h"

NS_ASSUME_NONNULL_BEGIN

@interface Gener (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *generName;
@property (nullable, nonatomic, retain) NSSet<Artist *> *artist;

@end

@interface Gener (CoreDataGeneratedAccessors)

- (void)addArtistObject:(Artist *)value;
- (void)removeArtistObject:(Artist *)value;
- (void)addArtist:(NSSet<Artist *> *)values;
- (void)removeArtist:(NSSet<Artist *> *)values;

@end

NS_ASSUME_NONNULL_END
