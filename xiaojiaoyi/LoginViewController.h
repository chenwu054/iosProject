//
//  LoginViewController.h
//  xiaojiaoyi
//
//  Created by chen on 8/24/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookSDK/FacebookSDK.h"

@interface LoginViewController : UIViewController <FBLoginViewDelegate>

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier;

@end
