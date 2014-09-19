//
//  CollectionViewCell.m
//  xiaojiaoyi
//
//  Created by chen on 9/11/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell


-(CollectionViewCell *)initWithName:(NSString *)name andURL:(NSURL*)url
{
    _name=name;
    _imageURL=url;
    _image=nil;
    _hasURL=YES;
    _hasImage =NO;
    _isFailed=NO;
    return self;
}

@end

