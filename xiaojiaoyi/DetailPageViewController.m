//
//  DetailPageViewController.m
//  xiaojiaoyi
//
//  Created by chen on 9/15/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "DetailPageViewController.h"

@interface DetailPageViewController ()
@property (nonatomic) NSUInteger willTransitionToPageViewIndex;
@end

@implementation DetailPageViewController

#pragma mark - page view data source methods
-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    DetailPageContentViewController *pVC = ((DetailPageContentViewController*)viewController);
    NSUInteger idx = pVC.index;
    if(idx == NSNotFound || idx == _titles.count - 1)
        return nil;
    return [self contentViewAtIndex:++idx];
}

-(UIViewController*) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index =((DetailPageContentViewController*)viewController).index;
    if(index==0 || index == NSNotFound)
        return nil;
    return [self contentViewAtIndex:--index];
    
}

-(DetailPageContentViewController*) contentViewAtIndex:(NSUInteger)index
{
    DetailPageContentViewController *contentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailPageContentController"];
    contentVC.contentImage = _images[index];
    contentVC.contentTitle = _titles[index];
    contentVC.index = index;
    return contentVC;
}

#pragma mark - page view delegate methods
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    _willTransitionToPageViewIndex = ((DetailPageContentViewController*)pendingViewControllers[0]).index;
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //completed meaning it the transition to a new page view is completed
    _pageControl.currentPage = completed?_willTransitionToPageViewIndex:((DetailPageContentViewController*)previousViewControllers[0]).index;
}

#pragma mark - core location delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *curLocation = (CLLocation *)locations.lastObject;
    NSDate* eventDate = curLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              curLocation.coordinate.latitude,
              curLocation.coordinate.longitude);
        _MyLocation.latitude = curLocation.coordinate.latitude;
        _MyLocation.longitude = curLocation.coordinate.longitude;
    }
    
    [_locationMgr stopUpdatingLocation];
}

#pragma mark - map view methods
-(void) mapViewClicked:(UIButton *)sender
{
    NSLog(@"map view clicked");
    [self performSegueWithIdentifier:@"MapViewSegue" sender:self];
    
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"MapViewSegue"]){
        if([segue.destinationViewController isKindOfClass:[MapViewController class]]){
            MapViewController * mapVC = (MapViewController*)segue.destinationViewController;
            //both pins and annotations are null;
            //if the coordinate2D is not visible region or invalid, then it will not be added to MapView.annotations and will not be shown.
            //NSLog(@"mapVC.pins is %@",mapVC.pins);
            NSNumber * latitude = @37.7833;
            NSNumber * longitude = @12.4167;
            NSString * name = @"test";
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = latitude.doubleValue;
            coordinate.longitude = longitude.doubleValue;
            if(!_MyLocation.latitude){
                _MyLocation=coordinate;
            }
            Location *annotation = [[Location alloc] initWithName:name Location:_MyLocation];
            
            mapVC.pins = [[NSMutableArray alloc] init];
            [mapVC.pins addObject:annotation];
            
        }
    }
}

-(IBAction)doneWithMap:(UIStoryboardSegue*)segue
{
    //NSLog(@"unwind segue %@",segue);
}
#pragma mark - lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1. creating data models
    self.titles =@[@"This is google icon",@"This is facebook icon", @"this is linkedin"];
    self.images=@[@"google.jpg",@"facebook.jpg",@"linkedin.jpg"];
    //2. setup page view controller
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    self.pageVC.view.frame = CGRectMake(0,0,320,250);
    //self.pageVC.view.layer.borderWidth = 4.0;
    self.pageVC.view.layer.borderColor = [[UIColor greenColor] CGColor];
    self.pageVC.doubleSided = true;
    
    //3. set up page content view controller
    DetailPageContentViewController *startingVC = [self contentViewAtIndex:0];
    NSArray * contentArray=@[startingVC];
    
    //4. View controller container
    [self.pageVC setViewControllers:contentArray direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    [self.pageVC didMoveToParentViewController:self];
    
    //5. page control setting
    _pageControl.numberOfPages = _titles.count;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(142, 190, 40, 37)];
    [_pageVC.view addSubview:_pageControl];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = _titles.count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.view addSubview:_pageControl];
    
    //6. Core Location
    if(!_locationMgr){
        _locationMgr = [[CLLocationManager alloc] init];
    }
    _locationMgr.delegate = self;
    _locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    _locationMgr.distanceFilter = 500; //in meters
    [_locationMgr startUpdatingLocation];
    
    //7. map view
    _mapViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _mapViewButton.frame = CGRectMake(30, 400, 250, 70);
    _mapViewButton.layer.cornerRadius = 5.0;
    _mapViewButton.backgroundColor = [UIColor grayColor];
    _mapViewButton.titleLabel.text = @"Map View";
    [self.view addSubview:_mapViewButton];
    [_mapViewButton addTarget:self action:@selector(mapViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
