//
//  CollectionViewCell.h
//  xiaojiaoyi
//
//  Created by chen on 9/11/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionViewCell : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *imageURL;
@property (nonatomic) UIImage *image;
@property (nonatomic) BOOL hasImage;
@property (nonatomic) BOOL hasURL;
@property (nonatomic) BOOL isFailed;


-(CollectionViewCell *)initWithName:(NSString *)name andURL:(NSURL*)url;

@end




