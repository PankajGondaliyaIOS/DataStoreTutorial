//
//  DataStoreTutorialBaseViewController.m
//  DataStoreTutorial
//
//  Created by Pankaj on 01/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "DataStoreTutorialBaseViewController.h"

@interface DataStoreTutorialBaseViewController ()

@end

@implementation DataStoreTutorialBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation bar methods
-(void)setNavigationTitle:(NSString*)strTitle {
    self.title = strTitle;
}

@end
