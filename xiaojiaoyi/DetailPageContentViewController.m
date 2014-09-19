//
//  DetailPageContentViewController.m
//  xiaojiaoyi
//
//  Created by chen on 9/15/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "DetailPageContentViewController.h"

@interface DetailPageContentViewController ()

@end

@implementation DetailPageContentViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:_contentImage];
    self.labelView.text = self.contentTitle;
    self.labelView.textColor = [UIColor whiteColor];
    self.labelView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    
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
