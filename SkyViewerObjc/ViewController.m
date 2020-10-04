//
//  ViewController.m
//  SkyViewerObjc
//
//  Created by Josue Arambula on 10/2/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static NSString *SimpleTableIdentifier = @"Picture";
static NSString *StoryboardDetailsId = @"Detail";

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sky Viewer";
    self.navigationController.navigationBar.prefersLargeTitles = true;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[NSBundle mainBundle] resourcePath];
    NSError *error;
    NSArray *items = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:filePath error:&error]];

    if(error){
        NSLog(@"%@",error);
        return;
    }
    // Create the array to hold the table data
    self.tableData = [[NSMutableArray alloc] init];
    for (NSString* item in items) {
        if([item hasPrefix:@"nssl"]){
            [self.tableData addObject:item];
        }
    }
    [self.tableData sortUsingSelector:@selector(compare:)];
}

#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier forIndexPath:indexPath];
    if(cell == nil) {
       // No cells in reuse pool, so we have to create a new one.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    cell.textLabel.text = self.tableData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.storyboard != nil) {
        DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:StoryboardDetailsId];
        vc.imageToLoad = self.tableData[indexPath.row]; // Set the exposed property
        vc.title = [[NSString alloc] initWithFormat:@"Picture %lu of %lu",indexPath.row+1,self.tableData.count];
        [self.navigationController pushViewController:vc animated:NO];
    }
}

#pragma mark - Objects

@end
