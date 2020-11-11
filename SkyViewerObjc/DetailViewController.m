//
//  DetailViewController.m
//  SkyViewerObjc
//
//  Created by Josue Arambula on 10/3/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () 
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation DetailViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self  action:@selector(shareTapped)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    
    self.navigationItem.largeTitleDisplayMode =  UINavigationItemLargeTitleDisplayModeNever;
    UIImage *image = [UIImage imageNamed:self.imageToLoad];
    if (image == nil) {
        NSLog(@"Image is nil");
        return;
    }
    [self.imageView setImage:image];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.hidesBarsOnTap = true;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.hidesBarsOnTap = false;
}

#pragma mark - Objects

// method called via selector
- (void) shareTapped {
    
    
    UIImage *imageItem = [UIImage imageWithData: UIImageJPEGRepresentation([UIImage imageNamed:self.imageToLoad], 1.0)                           scale: 0.8];
    NSArray *items = [NSArray arrayWithObjects:imageItem, self.imageToLoad, nil];
    
    UIActivityViewController * activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    [activityViewController.popoverPresentationController setBarButtonItem: self.navigationItem.rightBarButtonItem];
    if (activityViewController == nil) {
       return;
    }
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

@end
