//
//  MainViewController.h
//  xiaojiaoyi
//
//  Created by chen on 9/13/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableController.h"
#import "xjyViewController.h"
#import "YelpViewController.h"

@interface MainViewController : UIViewController <MenuNavigationDelegate,UITableViewDelegate>


@property (nonatomic) MenuTableController* menuViewController;
@property (nonatomic) xjyViewController * viewController;

@end
