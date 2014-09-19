//
//  YelpViewController.m
//  xiaojiaoyi
//
//  Created by chen on 9/9/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "YelpViewController.h"
#import "MenuTableController.h"

@interface YelpViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
//@property (nonatomic) MenuTableController *menuController;
@property (nonatomic) BOOL isShown;

@end

@implementation YelpViewController

#pragma mark - collection view delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"user just selected row: %ld",indexPath.row);
    
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self shouldPerformSegueWithIdentifier:@"detailViewSegue" sender:[self.collectionView cellForItemAtIndexPath:indexPath]];
    
    NSLog(@"highlighted at row: %ld",indexPath.row);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"should highlight at %ld",indexPath.row);
    return true;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"detailViewSegue"] || [sender isKindOfClass:[UICollectionViewCell class]]){
        NSLog(@"should perform segue");
        return true;
    }
    
    return false;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"preparing for segue");
    
}

-(BOOL)collectionView:collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"should select at %ld",indexPath.row);
    return true;
}
//-(void)setDelegate:(id<MenuNavigationDelegate>)delegate
//{
//    if(!_delegate){
//        NSLog(@"will set Yelp View Delegate");
//        _delegate = delegate;
//    }
//}

- (IBAction)menuButtonClicked:(UIBarButtonItem *)sender {
    
    NSLog(@"collection view's delegate is %@",self.collectionView.delegate);
    
    /*
     Both the sliding and resetting are delegated to Main View Controller
     */
//    if(_isShown){
//        [_delegate slide];
//        _isShown = false;
//    }
//    else{
//        [_delegate reset];
//        _isShown = true;
//    }
}

#pragma mark - collection view data source methods

-(NSMutableArray *)buses
{
    if(!_buses){
        NSOperationQueue *q = [[NSOperationQueue alloc] init];
        [q addOperationWithBlock:^{
            [self fetchData];
        }];
    }
    return _buses;
}

-(NSDictionary*)cells
{
    if(!_cells){
        _cells= [[NSMutableDictionary alloc] initWithCapacity:[self collectionView:nil numberOfItemsInSection:0]];
    }
    return _cells;
}

-(NSOperationQueue*) downloadQueue
{
    if(!_downloadQueue){
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.name=@"downloadCell";
        
    }
    return _downloadQueue;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"calling number of Items in section method");
    return _cells?[_cells count]:0;
//    return 10;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"calling the collection view cell method and indexPath is %ld", indexPath.row);
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    NSArray *subviews = cell.contentView.subviews;
    UIImageView *imageView;
    UILabel *labelView;
    for(int i=0;i<subviews.count;i++){
        if([subviews[i] isKindOfClass:[UIImageView class]]){
            imageView = (UIImageView *)subviews[i];
            imageView.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.width);
            //imageView.image = [UIImage imageNamed:@"apple image.jpg"];
            //sleep(1);
        }
        else if([subviews[i] isKindOfClass:[UILabel class]]){
            labelView = (UILabel*)subviews[i];
            labelView.frame = CGRectMake(2, cell.bounds.size.width, cell.bounds.size.width, cell.bounds.size.height - cell.bounds.size.width);
            //labelView.text = [NSString stringWithFormat:@"this is %ld",indexPath.row];
        }
    }
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[[UIColor blueColor] CGColor]];
    [cell.layer setShadowRadius:5];
    [cell.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.layer setCornerRadius:4.0f];
    NSInteger idx = indexPath.row;
    
    if(!_cells || (CollectionViewCell*)[_cells objectForKey: @(idx)]==nil || !((CollectionViewCell*)[_cells objectForKey:@(idx)]).hasURL){
        imageView.image = [UIImage imageNamed:@"apple image.jpg"];
        labelView.text = [NSString stringWithFormat:@""];
    }
    else if(((CollectionViewCell*)[_cells objectForKey:@(idx)]).isFailed){
        imageView.image = [UIImage imageNamed:@"apple image.jpg"];
        labelView.text = [NSString stringWithFormat:@"image not found"];
        
    }
    else if(!((CollectionViewCell*)[_cells objectForKey:@(idx)]).hasImage){
        imageView.image = [UIImage imageNamed:@"apple image.jpg"];
        labelView.text = [NSString stringWithFormat:@""];
        [self startDownloadCellOperation:indexPath collectionViewCell:[_cells objectForKey:@(idx)]];
    }
    else if(((CollectionViewCell*)[_cells objectForKey:@(idx)]).hasImage){
        CollectionViewCell *cCell =(CollectionViewCell *)[_cells objectForKey:@(idx)];
        imageView.image = cCell.image;
        labelView.text =cCell.name;
    }
    
    return cell;
}

-(void) startDownloadCellOperation:(NSIndexPath*)indexPath collectionViewCell:(CollectionViewCell*)cell
{
    CollectionViewDownloadOperation * operation =[[CollectionViewDownloadOperation alloc] initWithIndexPath:indexPath collecionViewCell:cell delegate:self];
    [_downloadQueue addOperation:operation];
}

//callback method when the image is downloaded
-(void) imageDownloadDidFinish:(CollectionViewDownloadOperation*)operation
{
    NSIndexPath *path = operation.indexPathInCollecionView;
    
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:path]];
    //((CollectionViewCell*)([_cells objectForKey:@(operation.indexPathInCollecionView.row)])).image = operation.cell.image;
}

#pragma mark - data fetching methods
-(void)fetchData
{
    NSString *hostname = @"api.yelp.com";
    NSString *searchPath =@"/v2/search";
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setValue:@"food" forKey:@"term"];
    [params setValue:@"San Francisco" forKey:@"location"];
    //[params setValue:@"10" forKey:@"limit"];
    NSURLRequest * request = [NSURLRequest requestWithHost:hostname path:searchPath params:params];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       // NSLog(@"response is here");
        NSHTTPURLResponse * r = (NSHTTPURLResponse*)response;
        if(r.statusCode == 200){
            //NSLog(@"is successful");
            NSError * error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
            //NSLog(@"%@",json);
            _buses = [json valueForKey:@"businesses"];
            if(!_cells)
                _cells = [[NSMutableDictionary alloc] init];
            for(NSInteger i=0;i<[_buses count];i++){
                //NSLog(@"name is: %@",[_buses[i] valueForKey:@"name"]);
                NSString *name = [_buses[i] valueForKey:@"name"];
                NSString *urlStr = [_buses[i] valueForKey:@"image_url"];
                CollectionViewCell * aCell=[[CollectionViewCell alloc] initWithName:name andURL:[NSURL URLWithString:urlStr]];
                [_cells setObject:aCell forKey:@(i)];
                //NSLog(@"the cells are %@, %@, %@",@(i),((CollectionViewCell*)[_cells objectForKey:@(i)]).name,((CollectionViewCell *)[_cells objectForKey:@(i)]).imageURL);
            }
            //call it on the main queue to refresh the screen immediately!!
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }

    }];
    [task resume];
}

-(void)connection:(NSURLConnection *)connection finishLoadingWithTicket:(OAServiceTicket *)ticket
{
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error withTicket:(OAServiceTicket *)ticket
{
    
}


#pragma mark - life cycle methods

-(void) awakeFromNib
{
    [super awakeFromNib];
    //NSLog(@"calling the init from nib ");
    //[self fetchData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"calling view did load");
    // Do any additional setup after loading the view.
    [self fetchData];
    //download queue is necessary
    [self downloadQueue];
    self.isShown = true;
    
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
