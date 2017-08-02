//
//  ProfileServices.m
//  DataStoreTutorial
//
//  Created by Pankaj on 01/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "ProfileServices.h"
#import "NetworkManager.h"
#import "DatabaseManager.h"

@implementation ProfileServices

+ (ProfileServices *)sharedInstance {
    static ProfileServices *profileServices = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        profileServices = [[self alloc] init];
    });
    return profileServices;
}

-(void)loadItunesData:(BOOL)bisShowLoader sucess:(void(^)(NSArray *arrResponse))successHandler failure:(void(^)(NSString *strFailureMessage))failureHandler {
    
    [[NetworkManager sharedInstance] GET:true sucess:^(NSDictionary *response) {
        //Save data to database
        NSMutableArray *arrResult = [[response objectForKey:@"feed"] objectForKey:@"results"];
        for(NSDictionary *dictArtist in arrResult) {
            [[DatabaseManager sharedInstance] insertArtistAndGener:dictArtist];
        }
        //Fetch data from database
        successHandler([[DatabaseManager sharedInstance] fetchAllArtists]);
    } failure:^(NSString *strFailureMessage) {
        failureHandler(strFailureMessage);
        NSLog(@"%@",strFailureMessage);
    }];

}


@end
