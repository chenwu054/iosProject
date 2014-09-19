//
//  xjyViewController.m
//  xiaojiaoyi
//
//  Created by chen on 8/24/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "xjyViewController.h"
#import "YPAPISample.h"
#import "NSURLRequest+OAuth.h"
#import "YelpViewController.h"


#define YELP_CONSUMER_KEY @"f1UUkqY-ArXOelq_hGKBOg"
#define YELP_CONSUMER_SECRET @"J-aIV0DJDUOJ4cBdGyBkIKmcdoY"
#define YELP_TOKEN @"-At-okxmS72TvU8_-y1iiO3wU57dzvVY"
#define YELP_TOKEN_SECRET @"cb9FGc7X_WrsbEjihdqZ5y7Hz2Y"

@interface xjyViewController ()

@property NSString *requestStr;
@end

@implementation xjyViewController

- (IBAction)slide:(id)sender
{
    
    
}

-(void) setDelegate:(id<MenuNavigationDelegate>)delegate
{
    if(!_delegate){
        _delegate = delegate;
        //NSLog(@"xjy delegate is set");
    }
}


- (void) setYelpButton:(UIButton *)yelpButton
{
    if(!_yelpButton){
        _yelpButton = yelpButton;
        [_yelpButton addTarget:self action:@selector(shouldPerformSegueWithIdentifier:sender:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender == _yelpButton){
        return YES;
    }
    return false;
}

-(void) setDataFetcher:(OADataFetcher*)aDataFetcher;
{
    if(!_dataFetcher){
        _dataFetcher = aDataFetcher;
        _dataFetcher.delegate = self;
    }
}

- (IBAction)onYelpButtonClicked:(UIButton *)sender
{
    
//
    
}

-(void)connection:(NSURLConnection*)connection
 didFailWithError:(NSError*) error
       withTicket:(OAServiceTicket*)ticket
{
    NSLog(@"calling did fail with error delegate");
    NSLog(@"%@",ticket);
}

-(void)connection:(NSURLConnection *)connection finishLoadingWithTicket:(OAServiceTicket*)ticket
{
    //NSLog(@"calling did finish loading ");
    //NSLog(@"%@",ticket);
    //NSLog(@"%@",ticket.response);
    NSHTTPURLResponse * response = (NSHTTPURLResponse *)[ticket response];
    if([response statusCode]==200){
        //NSLog(@"is successful");
        //NSLog(@"data is:%@",[[NSString alloc] initWithData:[ticket data] encoding:NSUTF8StringEncoding] );
        //NSString *responses = [[NSString alloc] initWithData:[ticket data] encoding:NSUTF8StringEncoding];
        NSError * error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[ticket data] options:0 error: &error];
        //NSLog(@"%@",json);
        NSArray * buses = [json valueForKey:@"businesses"];
        for(int i=0;i<[buses count];i++){
            NSLog(@"name is: %@",[buses[i] valueForKey:@"name"]);
        }
        
    }
    
    //NSLog(@"%@",[[NSString alloc] initWithData:ticket.data encoding:NSUTF8StringEncoding]);
    
}

#pragma mark - collection view
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[YelpViewController class]] ){
        YelpViewController* yelpController = (YelpViewController*)segue.destinationViewController;
        //NSLog(@"will perform segue");
        //yelpController.delegate = self.delegate;
        yelpController.term = _term;
        yelpController.limit = _limit;
        yelpController.query = _query;
        yelpController.location = _location;
    }
}

#pragma mark - controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"calling xjyViewController viewDidLoad");
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
