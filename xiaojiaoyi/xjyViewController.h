//
//  xjyViewController.h
//  xiaojiaoyi
//
//  Created by chen on 8/24/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OADataFetcher.h"
#import "OAHMAC_SHA1SignatureProvider.h"
//#import "OASignatureProviding.h"
#import "YelpViewController.h"

@interface xjyViewController : UIViewController <DataFetcherDelegate>
@property (weak, nonatomic) IBOutlet UIButton *yelpButton;
@property (strong,nonatomic) OADataFetcher *dataFetcher;
@property (nonatomic) NSString* term;
@property (nonatomic) NSString* query;
@property (nonatomic) NSString* limit;
@property (nonatomic) NSString* location;
@property (nonatomic) id<MenuNavigationDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *slideButton;


@end
