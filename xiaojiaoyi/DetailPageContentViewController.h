//
//  DetailPageContentViewController.h
//  xiaojiaoyi
//
//  Created by chen on 9/15/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPageContentViewController : UIViewController

@property (nonatomic) NSString *contentTitle;
@property (nonatomic) NSString *contentPrice;
@property (nonatomic) NSString *contentImage;
@property (nonatomic) NSUInteger index;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelView;


@end
