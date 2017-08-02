//
//  NetworkManager.m
//  DataStoreTutorial
//
//  Created by Pankaj on 01/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "NetworkManager.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "Constant.h"

@implementation NetworkManager

+ (NetworkManager *)sharedInstance {
    static NetworkManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[self alloc] init];
    });
    return networkManager;
}

- (id)init {
    if (self = [super init]) {
        _strBaseUrl = @"https://rss.itunes.apple.com/api/v1/us/apple-music/new-music/10/explicit/json";
    }
    return self;
}

-(void)GET:(BOOL)bisShowLoader sucess:(void(^)(NSDictionary *response))successHandler failure:(void(^)(NSString *strFailureMessage))failureHandler{
    
    if ([self connected]) {
        if (bisShowLoader == true) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD show];
            });
        }
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:_strBaseUrl] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if (!error) {
                successHandler(json);
            } else {
                [self showAlertview:@"Alert" message:@"Could not connect to the server. Please try again"];
                failureHandler(@"An error occured on server.");
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            NSLog(@"%@", json);
        }];
        
        [dataTask resume];
    } else {
        [self showAlertview:@"Alert" message:@"Please check your internet connection and try again."];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

#pragma mark - Check internet connection
-(BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

-(void)showAlertview:(NSString*)strTitle message:(NSString*)strMessage {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:strTitle
                                 message:strMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [appDelegate.window.rootViewController presentViewController:alert animated:true completion:nil];
}


@end
