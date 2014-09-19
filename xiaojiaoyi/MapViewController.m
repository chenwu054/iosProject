//
//  MapViewController.m
//  xiaojiaoyi
//
//  Created by chen on 9/17/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

#pragma mark - map view delegate methods

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //this is where to set the annotation callout
    NSLog(@"did select annotation view");
    UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    view.leftCalloutAccessoryView =  imageView;
    imageView.image = [UIImage imageNamed:@"twitter small icon.jpg"];
    view.leftCalloutAccessoryView.frame= CGRectMake(0, 0, 40, 40);
    view.rightCalloutAccessoryView  = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    //Location * ann = (Location*) view.annotation;
    //ann.name=nil;
    view.enabled = YES;
    NSLog(@"%d",view.isSelected);
    
}
-(MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSLog(@"calling viewForAnnotation");
    MKPinAnnotationView *aView = (MKPinAnnotationView *)[sender dequeueReusableAnnotationViewWithIdentifier:@"Location"];
    if(!aView){
        NSLog(@"aView is nil");
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Location"];
        aView.pinColor = MKPinAnnotationColorGreen;
        aView.animatesDrop = YES;
        aView.canShowCallout=YES;
        aView.enabled = YES;
    }
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(disclosureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    aView.rightCalloutAccessoryView = rightButton;
    // Add a custom image to the left side of the callout.
    UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter small icon.jpg"]];
    //myCustomImage.frame = CGRectMake(-2, -2, 20, 20);
    aView.leftCalloutAccessoryView = myCustomImage;
    aView.leftCalloutAccessoryView.frame =CGRectMake(0, -2, 40, 40);
    aView.annotation = annotation;
    return aView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    //NSLog(@"callout accessary tapped!");
}

-(void)disclosureButtonClicked:(id)sender
{
    //NSLog(@"disclosure button clicked!");
}

#pragma  mark - lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView.delegate = self;
    // Do any additional setup after loading the view.
    [_mapView addAnnotations: [_pins copy]];
    CLLocationCoordinate2D center;
    center.latitude = ((id<MKAnnotation>)([_mapView.annotations firstObject])).coordinate.latitude;
    center.longitude = ((id<MKAnnotation>)([_mapView.annotations firstObject])).coordinate.longitude;
    CLLocationDistance width = 2000;
    CLLocationDistance height = 2000;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, width, height);
    [_mapView setRegion:region animated:YES];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
