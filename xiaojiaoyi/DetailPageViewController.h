//
//  DetailPageViewController.h
//  ;
//
//  Created by chen on 9/15/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "DetailPageContentViewController.h"
#import "xjyAppDelegate.h"
#import "MapViewController.h"
#import "Location.h"

@interface DetailPageViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate,CLLocationManagerDelegate>


@property (nonatomic) NSArray * titles;
@property (nonatomic) NSArray * prices;
@property (nonatomic) NSArray * images;

@property (nonatomic) UIPageViewController* pageVC;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) IBOutlet UIButton *mapViewButton;

@property (nonatomic) CLLocationManager * locationMgr;
@property (nonatomic) CLLocationCoordinate2D MyLocation;

@end
