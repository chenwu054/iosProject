//
//  CollectionViewDownloadOperation.m
//  xiaojiaoyi
//
//  Created by chen on 9/11/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "CollectionViewDownloadOperation.h"
#import "CollectionViewDownloadOperationDelegate.h"

@implementation CollectionViewDownloadOperation

-(CollectionViewDownloadOperation *)initWithIndexPath:(NSIndexPath*)indexPath collecionViewCell:(CollectionViewCell *)cell delegate:(id<CollectionViewDownloadOperationDelegate>)delegate
{
    if(self = [super init]){
        _delegate = delegate;
        _indexPathInCollecionView = indexPath;
        _cell=cell;
    }
    return self;
}

-(void)main
{
    @autoreleasepool {
        //NSURLSessionConfiguration *config =[NSURLSessionConfiguration ephemeralSessionConfiguration];
        if(self.isCancelled)
            return;
        
        NSData *data= [NSData dataWithContentsOfURL:_cell.imageURL];
        if(self.isCancelled){
            _cell.image=nil;
            _cell.hasImage=NO;
            return;
        }
        
        if(data){
            _cell.image = [UIImage imageWithData:data];
            _cell.hasImage=YES;
        }
        else{
            _cell.hasImage=NO;
            _cell.isFailed=YES;
        }
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageDownloadDidFinish:) withObject:self waitUntilDone:NO];
    }
}

@end
