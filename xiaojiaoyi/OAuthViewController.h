//
//  OAuthViewController.h
//  xiaojiaoyi
//
//  Created by chen on 9/1/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAuthViewController : UIViewController <UIWebViewDelegate,NSURLConnectionDelegate>
@property (strong, nonatomic) NSString * requestURL;

@end
