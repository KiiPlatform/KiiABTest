//
//  ViewController.m
//  KiiABTest
//
//  Created by Chris Beauchamp on 4/14/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "ViewController.h"
#import "DonationViewController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    DonationViewController *vc = [[DonationViewController alloc] initWithNibName:@"DonationViewController" bundle:nil];
    [self presentViewController:vc animated:TRUE completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
