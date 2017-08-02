//
//  NetworkManager.h
//  CoreDataTutorial
//
//  Created by Pankaj on 31/07/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

@property(nonatomic, strong)NSString   *strBaseUrl;

+ (NetworkManager *)sharedInstance;
-(void)GET:(BOOL)bisShowLoader sucess:(void(^)(NSDictionary *response))successHandler failure:(void(^)(NSString *strFailureMessage))failureHandler;

@end
