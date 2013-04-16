//
//  DonationViewController.m
//  KiiABTest
//
//  Created by Chris Beauchamp on 4/15/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "DonationViewController.h"

#import <KiiAnalytics/KiiAnalytics.h>
#import "ABStorage.h"

@interface DonationViewController () {
    UIButton *_donateButton;
    UIButton *_noThanksButton;
    NSString *_buttonColorString;
}

@end

@implementation DonationViewController

@synthesize donateButton = _donateButton;
@synthesize noThanksButton = _noThanksButton;

- (void)viewDidLoad
{
    [super viewDidLoad];

    int redsDisplayed = [ABStorage getDisplayed:@"red"];
    int redsClicked = [ABStorage getClicked:@"red"];
    double redPercentageClicked = (redsDisplayed > 0) ? ((double)redsClicked / (double)redsDisplayed) : 0.0;
    int redWeight = 100 + 1000*redPercentageClicked;
    
    int greensDisplayed = [ABStorage getDisplayed:@"green"];
    int greensClicked = [ABStorage getClicked:@"green"];
    double greenPercentageClicked = (greensDisplayed > 0) ? ((double)greensClicked / (double)greensDisplayed) : 0.0;
    int greenWeight = 100 + 1000*greenPercentageClicked;
    
    int bluesDisplayed = [ABStorage getDisplayed:@"blue"];
    int bluesClicked = [ABStorage getClicked:@"blue"];
    double bluePercentageClicked = (bluesDisplayed > 0) ? ((double)bluesClicked / (double)bluesDisplayed) : 0.0;
    int blueWeight = 100 + 1000*bluePercentageClicked;
    
    
    NSRange redRange = NSMakeRange(0, redWeight); // { 0, 106 }
    NSRange greenRange = NSMakeRange(redWeight, redWeight + greenWeight); // { 106, 228 }
    
    // we don't need this... but just to show the approximate range:
    //NSRange blueRange = NSMakeRange(redWeight + greenWeight, redWeight + greenWeight + blueWeight); // { 228, 341 }
    
    int rand = arc4random() % (redWeight + greenWeight + blueWeight);
    if(NSLocationInRange(rand, redRange)) {
        
        // make the button red
        _donateButton.backgroundColor = [UIColor redColor];
        _buttonColorString = @"red";
        
    } else if(NSLocationInRange(rand, greenRange)) {
        
        // make the button green
        _donateButton.backgroundColor = [UIColor greenColor];
        _buttonColorString = @"green";
        
    } else {
        
        // make the button blue
        _donateButton.backgroundColor = [UIColor blueColor];
        _buttonColorString = @"blue";
        
    }
    
    NSMutableDictionary *extras = [NSMutableDictionary dictionary];
    [extras setObject:_buttonColorString forKey:@"button_color"];
    [extras setObject:@"displayed" forKey:@"event_status"];
    
    [KiiAnalytics trackEvent:@"button" withExtras:extras];
    
}


- (IBAction)sendToDonate:(id)sender
{
    
    NSMutableDictionary *extras = [NSMutableDictionary dictionary];
    [extras setObject:_buttonColorString forKey:@"button_color"];
    [extras setObject:@"clicked" forKey:@"event_status"];
    
    [KiiAnalytics trackEvent:@"button" withExtras:extras];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Woooo!" message:@"You rock! But I didn't think anyone would click this so it's not implemented yet. Oops :)" delegate:nil cancelButtonTitle:@"Your loss, lazy developer" otherButtonTitles:nil];
    [av show];
}

- (IBAction)closeDonateView:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
