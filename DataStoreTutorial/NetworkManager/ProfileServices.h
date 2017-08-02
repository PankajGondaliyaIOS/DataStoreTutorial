//
//  ProfileServices.h
//  CoreDataTutorial
//
//  Created by Pankaj on 31/07/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileServices : NSObject
+ (ProfileServices *)sharedInstance;
-(void)loadItunesData:(BOOL)bisShowLoader sucess:(void(^)(NSArray *arrResponse))successHandler failure:(void(^)(NSString *strFailureMessage))failureHandler;

@end
