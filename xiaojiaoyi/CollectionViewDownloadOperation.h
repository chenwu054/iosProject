//
//  CollectionViewDownloadOperation.h
//  xiaojiaoyi
//
//  Created by chen on 9/11/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionViewCell.h"
#import "YelpViewController.h"
#import "CollectionViewDownloadOperationDelegate.h"

//@protocol CollectionViewDownloadOperationDelegate;

@interface CollectionViewDownloadOperation : NSOperation

@property (nonatomic) NSIndexPath *indexPathInCollecionView;
@property (nonatomic) CollectionViewCell* cell;
@property (nonatomic) id<CollectionViewDownloadOperationDelegate> delegate;

-(CollectionViewDownloadOperation*) initWithIndexPath:(NSIndexPath*)indexPath collecionViewCell:(CollectionViewCell *)cell delegate:(id<CollectionViewDownloadOperationDelegate>)delegate;
@end
