//
//  HomeViewController.h
//  DataStoreTutorial
//
//  Created by Pankaj on 01/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStoreTutorialBaseViewController.h"

@interface HomeViewController : DataStoreTutorialBaseViewController

@property (nonatomic, strong) NSMutableArray *arrArtists;

-(void)callLoadItunesDataWebservice:(void(^)(NSArray *arrResponse))succesHandlerOfFetch;

@end
