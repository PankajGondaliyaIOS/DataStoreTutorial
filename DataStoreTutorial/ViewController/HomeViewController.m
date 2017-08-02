//
//  HomeViewController.m
//  DataStoreTutorial
//
//  Created by Pankaj on 01/08/17.
//  Copyright © 2017 Pankaj. All rights reserved.
//

#import "HomeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProfileServices.h"
#import "DatabaseManager.h"
#import "ArtistCellTypeOne.h"
#import "ArtistCellTypeTwo.h"
#import "ArtistCellTypeThree.h"
#import "Artist.h"
#import "Gener.h"

@interface HomeViewController () {
    IBOutlet UICollectionView *collArtist;
}

@end

@implementation HomeViewController

@synthesize arrArtists;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initiateView];
}

#pragma mark - View Initiation Methods
-(void)initiateView {
    //Set navigation
    [self setNavigationTitle:@"Top Artists"];
    
    NSArray *arrArtist = [[DatabaseManager sharedInstance] fetchAllArtists];
    if (arrArtist.count>0) {
        arrArtists = [arrArtist mutableCopy];
        arrArtist = nil;
        [collArtist reloadData];
    } else {
        //Call API if the data is not available to the database
        [self callLoadItunesDataWebservice:^(NSArray *arrResponse) {
            arrArtists = [arrResponse mutableCopy];
            arrResponse = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [collArtist reloadData];
            });
        }];
    }
}

#pragma mark - UICollectionview Delegate-Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger returncount = 0;
    returncount = arrArtists.count;
    return returncount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Artist *artist = [arrArtists objectAtIndex:indexPath.row];
    UICollectionViewCell *returnCell;
    //Prototype cell one
    if (indexPath.row<3) {
        static NSString *cellIdentifier = @"ArtistCellTypeOne";
        ArtistCellTypeOne *cellItem = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        //Set name
        cellItem.lblName.text = artist.artistName;
        //Set gener
        NSString *strGenerOfArtist = @"";
        for(Gener *gener in artist.generOfArtist) {
            strGenerOfArtist = [NSString stringWithFormat:@"%@\n%@",strGenerOfArtist,gener.generName];
        }
        cellItem.lblGener.text = strGenerOfArtist;
        //Set image
        [cellItem.imgArtwork sd_setImageWithURL:[NSURL URLWithString:artist.artWorkUrl] placeholderImage:[UIImage imageNamed:@"place_holder_loading"]];
        returnCell = cellItem;
    } else if (indexPath.row<6){
        //Prototype cell two
        static NSString *cellIdentifier = @"ArtistCellTypeTwo";
        ArtistCellTypeTwo *cellItem = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        //Set name
        cellItem.lblName.text = artist.artistName;
        //Set gener
        NSString *strGenerOfArtist = @"";
        for(Gener *gener in artist.generOfArtist) {
            strGenerOfArtist = [NSString stringWithFormat:@"%@\n%@",strGenerOfArtist,gener.generName];
        }
        cellItem.lblGener.text = strGenerOfArtist;
        //Set image
        [cellItem.imgArtwork sd_setImageWithURL:[NSURL URLWithString:artist.artWorkUrl] placeholderImage:[UIImage imageNamed:@"place_holder_loading"]];
        returnCell = cellItem;
    } else {
        //Prototype cell two
        static NSString *cellIdentifier = @"ArtistCellTypeThree";
        ArtistCellTypeThree *cellItem = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        //Set name
        cellItem.lblName.text = artist.artistName;
        //Set gener
        NSString *strGenerOfArtist = @"";
        for(Gener *gener in artist.generOfArtist) {
            strGenerOfArtist = [NSString stringWithFormat:@"%@\n%@",strGenerOfArtist,gener.generName];
        }
        cellItem.lblGener.text = strGenerOfArtist;
        //Set image
        [cellItem.imgArtwork sd_setImageWithURL:[NSURL URLWithString:artist.artWorkUrl] placeholderImage:[UIImage imageNamed:@"place_holder_loading"]];
        returnCell = cellItem;
    }
    
    return returnCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize returnSize = CGSizeMake(self.view.frame.size.width, 75);
    return returnSize;
}

#pragma mark - Webservice Methods
-(void)callLoadItunesDataWebservice:(void(^)(NSArray *arrResponse))succesHandlerOfFetch {
    [[ProfileServices sharedInstance] loadItunesData:true sucess:^(NSArray *arrResponse) {
        succesHandlerOfFetch(arrResponse);
    } failure:^(NSString *strFailureMessage) {
        NSLog(@"This error will be handled by network manager");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
