//
//  Location.m
//  xiaojiaoyi
//
//  Created by chen on 9/17/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "Location.h"

@implementation Location

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return @"";
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}

- (Location *) initWithName:(NSString*)name Location:(CLLocationCoordinate2D)location
{
    self = [super init];
    
    _name = name;
    _coordinate = location;
    return self;
}

@end







