//
//  MapViewController.h
//  xiaojiaoyi
//
//  Created by chen on 9/17/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSMutableArray *pins;
@property (nonatomic) NSString *testStr;


@end
