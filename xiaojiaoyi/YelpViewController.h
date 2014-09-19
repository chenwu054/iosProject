//
//  YelpViewController.h
//  xiaojiaoyi
//
//  Created by chen on 9/9/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OADataFetcher.h"
#import "NSURLRequest+OAuth.h"
#import "CollectionViewCell.h"
#import "CollectionViewDownloadOperation.h"
#import "CollectionViewDownloadOperationDelegate.h"

@protocol MenuNavigationDelegate <NSObject>

-(void) slide;
-(void) reset;
-(void) slideWithTransition:(CGPoint)transition ended:(BOOL)ended;

@end

@interface YelpViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, DataFetcherDelegate,CollectionViewDownloadOperationDelegate>

@property (nonatomic) NSString* term;
@property (nonatomic) NSString* query;
@property (nonatomic) NSString* limit;
@property (nonatomic) NSString* location;

@property (nonatomic) NSMutableArray *buses;
@property (nonatomic) NSMutableDictionary *cells;
@property (nonatomic) NSOperationQueue * downloadQueue;
@property (nonatomic) id<MenuNavigationDelegate> delegate;

//@property (nonatomic) IBOutlet UICollectionView *collectionView;


@end
