//
//  MainViewController.m
//  xiaojiaoyi
//
//  Created by chen on 9/13/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "MainViewController.h"

#define PANEL_WIDTH 40

@interface MainViewController ()

@property (nonatomic) BOOL isReset;
@end

@implementation MainViewController


#pragma mark - table view delegate methods

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self reset];
    NSLog(@"main controller did select table view at index path: %ld,%ld",indexPath.section,indexPath.row);
    [_menuViewController tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath];
    
}



#pragma mark - gesture recognizer setup
-(void) setupGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [panGestureRecognizer setMaximumNumberOfTouches:1];
    [panGestureRecognizer setMaximumNumberOfTouches:1];
    [_viewController.view addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_viewController.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)tap:(UITapGestureRecognizer *)gesture
{
    [self reset];
}
-(void)pan:(UIPanGestureRecognizer *)gesture
{
    
    if(gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateBegan){
        //NSLog(@"calling the pan gesture recognizer");
        CGPoint transition  = [gesture translationInView: _viewController.view]; // ?
        [self slideWithTransition:transition ended:NO];
        
    }
    else if(gesture.state==UIGestureRecognizerStateEnded){
        CGPoint transition = [gesture translationInView: self.view];
        [self slideWithTransition:transition ended:YES];
    }
}

#pragma mark - sub-controllers setup
-(void)setup
{
    if(!_viewController){
        //xjyViewControllerSB
        //xjyTabBarControllerSB
        _viewController =[self.storyboard instantiateViewControllerWithIdentifier:@"xjyTabBarControllerSB"];
        
        [self addChildViewController:_viewController];
        [self.view addSubview:_viewController.view];
        
        _viewController.view.frame = CGRectMake(0,0, _viewController.view.frame.size.width, _viewController.view.frame.size.height);
//        NSArray *childViewControllers=self.childViewControllers;
//        for(int i=0;i<childViewControllers.count;i++){
//            //NSLog(@"child view controller: %@",childViewControllers[i]);
//            NSArray *subChildVCs=((UIViewController*)(childViewControllers[i])).childViewControllers;
//            for(int j=0;j<subChildVCs.count;j++){
//               // NSLog(@"sub child view controller: %@",subChildVCs[j]);
//                NSArray *subsubChildVCs=((UIViewController*)(subChildVCs[i])).childViewControllers;
//                for(int j=0;j<subsubChildVCs.count;j++){
//                    //NSLog(@"sub child view controller: %@",subsubChildVCs[j]);
//                    xjyViewController * c = (xjyViewController *)(subsubChildVCs[j]);
//                    if(!c){
//                        //NSLog(@"xjy view controller is null");
//                    }
//                    else{
//                        //NSLog(@"xjy view controller is NOT null");
//                        if(!c.delegate){
//                            //NSLog(@"xjy delegate is null");
//                            //c.delegate = self;
//                        }
//                    }
//                }
//            }
//        }
        [self setupGestureRecognizer];
        
        //_viewController.delegate = self;
        //[self.navigationController pushViewController:_viewController animated:YES];
        
        //[self.viewController presentViewController:_viewController animated:YES completion:nil];
        [_viewController didMoveToParentViewController:self];
        
    }
    
    if(!_menuViewController){
        _menuViewController = [MenuTableController alloc];
        _menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
        
        [self.view addSubview:_menuViewController.view];
        [self addChildViewController:_menuViewController];
        _menuViewController.view.frame = CGRectMake(_menuViewController.view.frame.size.width,0, _menuViewController.view.frame.size.width, _menuViewController.view.frame.size.height);
        [_menuViewController didMoveToParentViewController:self];
        
        _menuViewController.tableView.delegate = self;
    }
//    NSArray * menuSubViews = _menuViewController.view.subviews;
//    for(int i=0;i<menuSubViews.count;i++){
//        NSLog(@"menu subview is %@", menuSubViews[i]);
//    }
//    NSLog(@"===============");
//    NSArray *viewSubViews = _viewController.view.subviews;
//    for(int i=0;i<viewSubViews.count;i++){
//        NSLog(@"view subview is %@", viewSubViews[i]);
//    }
    
}
/*
slide all the way to the left
 */
 
-(void) slide
{
    //NSLog(@"calling main view slide");
    [UIView animateWithDuration:0.2 delay: 0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        //NSArray *childVCs = self.childViewControllers;
        _viewController.view.frame = CGRectMake(PANEL_WIDTH-_viewController.view.frame.size.width, 0,_viewController.view.frame.size.width, _menuViewController.view.frame.size.height);
        _menuViewController.view.frame = CGRectMake(PANEL_WIDTH, 0,_menuViewController.view.frame.size.width, _menuViewController.view.frame.size.height);
    } completion:^(BOOL finished) {
        if(finished)
            nil;
        //NSLog(@"menu navigation view from main view moved main frame successfully");
    }];
    _isReset=NO;
    
}
/*
 slide based on the transition
 */
-(void) slideWithTransition:(CGPoint)transition ended:(BOOL)ended
{
    //NSLog(@"calling main view slide with transition");
    if((_isReset && transition.x>0) || (!_isReset && transition.x<0))
        return;
    //shortcut same as xiaojiaoyi~
    /*
     this is done because, there is push segue from xjyViewController to the YelpViewController
     therefore, in the !_isReset state, if the 
     */
    if(!_isReset && transition.x>0){
        [self reset];
        return;
    }
    CGFloat centerX = _isReset?_viewController.view.frame.size.width/2:_viewController.view.frame.size.width/2-(_viewController.view.frame.size.width-PANEL_WIDTH);
    _viewController.view.center=CGPointMake(centerX+transition.x,_viewController.view.center.y);
    _menuViewController.view.center=CGPointMake(centerX + _menuViewController.view.frame.size.width + transition.x,_menuViewController.view.center.y);
    
    if(ended){
        if(_isReset){
            if(transition.x<-_viewController.view.frame.size.width/2)
                [self slide];
            else
                [self reset];

        }
        else{
            if(transition.x > _viewController.view.frame.size.width/2)
                [self reset];
            else
                [self slide];
        }
    }
    
}

/*
 slide the view back to original setting
 */
-(void)reset
{
    //NSLog(@"calling main view controller reset");
    [UIView animateWithDuration:0.2 delay: 0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _viewController.view.frame = CGRectMake(0, 0,_viewController.view.frame.size.width, _viewController.view.frame.size.height);
        _menuViewController.view.frame = CGRectMake(_viewController.view.frame.size.width, 0,_menuViewController.view.frame.size.width, _menuViewController.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        if(finished)
            nil;
            //NSLog(@"menu navigation view from main view reset successfully");
    }];
    _isReset = YES;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    self.isReset = true;
    
    // Do any additional setup after loading the view.
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
