//
//  MenuTableController.m
//  xiaojiaoyi
//
//  Created by chen on 9/13/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "MenuTableController.h"

#define BUTTON_CORNER_RADIUS 10.0f
@interface MenuTableController ()

@property (nonatomic) NSArray *category;
@property (nonatomic) NSArray *subtitles;
@property (nonatomic) NSArray *imageURLs;

@end

@implementation MenuTableController

#pragma mark - table view methods
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _category.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    cell.textLabel.text=_category[row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"table view did select at %ld,%ld",indexPath.section,indexPath.row);
}

#pragma mark - search bar methods
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _searchStr = searchBar.text;
    NSLog(@"search string is: %@",_searchStr);
    [_searchBar resignFirstResponder];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchBar.text = nil;
    [_searchBar resignFirstResponder];
}


#pragma mark - gesture recognizer methods
-(void) tap:(UITapGestureRecognizer *)gesture
{
    
    NSLog(@"tap clicked");
    if([_searchBar isFirstResponder])
        [_searchBar resignFirstResponder];
    else
        NSLog(@"not first responder");
}

#pragma mark - button methods
-(void) buttonSetup
{
    [_buyButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_sellButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _sellButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    _buyButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    [self buttonClicked:_buyButton];
    
}
-(void) buttonClicked:(id)sender
{
    if([sender isKindOfClass:[UIButton class]]){
        UIButton * button = (UIButton*)sender;
        if(button == _buyButton){
            _buyButton.backgroundColor = [UIColor whiteColor];
            _sellButton.backgroundColor = [UIColor grayColor];
            _isBuy=YES;
        }
        else if(button == _sellButton){
            _buyButton.backgroundColor=[UIColor grayColor];
            _sellButton.backgroundColor=[UIColor whiteColor];
            _isBuy=NO;
            
        }
        else{
            NSLog(@"error: button is neither buttons");
        }
    }
    else
        NSLog(@"error: sender if not button class");
}

#pragma mark - controller lifecycle 

-(void)categorySetup{
    _category=@[@"digital products", @"baby", @"life service"];
    _subtitles=@[@"cell phone laptop camera...",@"stroller milk_powder baby_cloths",@"tutor carpool cleaning hiring"];
    _imageURLs=@[@"twitter small icon.jpg", @"twitter small icon.jpg", @"twitter small icon.jpg" ];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self categorySetup];
    
    // Do any additional setup after loading the view.
    _searchBar.delegate = self;
    _searchBar.showsCancelButton =YES;

    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tapGR];
    [_tableView addGestureRecognizer:tapGR];
    [_bkg addGestureRecognizer:tapGR];
    //_tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self buttonSetup];
    
    
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
