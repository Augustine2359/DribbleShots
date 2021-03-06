//
//  DSTableViewController.m
//  DribbleShots
//
//  Created by Augustine on 12/12/14.
//  Copyright (c) 2014 Augustine. All rights reserved.
//

#import "DSTableViewController.h"
#import "DSTableViewCell.h"
#import "DSDetailViewController.h"

@interface DSTableViewController ()

@property (nonatomic) DribbleShotType dribbleShotType;
@property (nonatomic, strong) NSArray *shots;
@property (nonatomic) BOOL hasDownloadedEverything;

@end

@implementation DSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.hasDownloadedEverything = NO;
  
  UINib *nib = [UINib nibWithNibName:@"DSTableViewCell" bundle:[NSBundle mainBundle]];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"reuseIdentifier"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableWithShotsOfType:(DribbleShotType)dribbleShotType {
  self.dribbleShotType = dribbleShotType;
  self.shots = [[DSDataManager sharedInstance] getShotsOfType:dribbleShotType];
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.hasDownloadedEverything)
    return [self.shots count];
  else
    return [self.shots count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == [self.shots count])
    return 0;
  else
    return 200;
}

- (DSTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *ReuseIdentifier = @"reuseIdentifier";
  DSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier forIndexPath:indexPath];

  if (indexPath.row == [self.shots count]) {
    NSInteger pageNumber = indexPath.row / PAGES_PER_API_CALL + 1;
    [[DSNetworkManager sharedInstance] getShotsOfType:self.dribbleShotType
                                               onPage:pageNumber
                                              success:^(NSArray *newShots) {
      if ([newShots count] < 1) {
        self.hasDownloadedEverything = YES;
      }
      self.shots = [[DSDataManager sharedInstance] getShotsOfType:self.dribbleShotType];
      [self.tableView reloadData];
    } failure:^(NSError *error) {
      //Assume that this means reached the end of pagination
      if ([error code] == -1011) {
        self.hasDownloadedEverything = YES;
      }
    }];
    [cell populateWithShot:nil];
    return cell;
  }

  Shot *shot = self.shots[indexPath.row];
  [cell populateWithShot:shot];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self performSegueWithIdentifier:@"push" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  DSDetailViewController *detailVC = (DSDetailViewController *)segue.destinationViewController;
  NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
  Shot *shot = self.shots[selectedIndexPath.row];
  DSTableViewCell *cell = (DSTableViewCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
  UIImage *image = [cell imageInCell];
  [detailVC populateWithShot:shot andImage:image];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
