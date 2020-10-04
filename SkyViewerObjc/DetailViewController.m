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

@end
