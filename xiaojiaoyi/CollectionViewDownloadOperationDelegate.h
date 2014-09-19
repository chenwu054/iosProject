//
//  CollectionViewDownloadOperationDelegate.h
//  xiaojiaoyi
//
//  Created by chen on 9/11/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionViewDownloadOperation.h"

@class  CollectionViewDownloadOperation;

@protocol CollectionViewDownloadOperationDelegate <NSObject>

-(void) imageDownloadDidFinish: (CollectionViewDownloadOperation*)operation;


@end
