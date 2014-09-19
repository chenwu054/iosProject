//
//  MenuTableController.h
//  xiaojiaoyi
//
//  Created by chen on 9/13/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableController : UIViewController <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *sellButton;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bkg;

@property (nonatomic) BOOL isBuy;
@property (nonatomic) NSString *searchStr;


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


