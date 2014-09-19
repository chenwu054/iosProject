//
//  Location.h
//  xiaojiaoyi
//
//  Created by chen on 9/17/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject <MKAnnotation>

@property (nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (Location *) initWithName:(NSString*)name Location:(CLLocationCoordinate2D) location;

@end

