//
//  ProfileServices.h
//  DataStoreTutorial
//
//  Created by Pankaj on 01/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileServices : NSObject
+ (ProfileServices *)sharedInstance;
-(void)loadItunesData:(BOOL)bisShowLoader sucess:(void(^)(NSArray *arrResponse))successHandler failure:(void(^)(NSString *strFailureMessage))failureHandler;

@end
