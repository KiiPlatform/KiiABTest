//
//
// Copyright 2013 Kii Corporation
// http://kii.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
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

    // retrieve the stats from the cache and calculate CTR
    int redsDisplayed = [ABStorage getDisplayed:@"red"];
    int redsClicked = [ABStorage getClicked:@"red"];
    double redPercentageClicked = (redsDisplayed > 0) ? ((double)redsClicked / (double)redsDisplayed) : 0.0;

    int greensDisplayed = [ABStorage getDisplayed:@"green"];
    int greensClicked = [ABStorage getClicked:@"green"];
    double greenPercentageClicked = (greensDisplayed > 0) ? ((double)greensClicked / (double)greensDisplayed) : 0.0;

    int bluesDisplayed = [ABStorage getDisplayed:@"blue"];
    int bluesClicked = [ABStorage getClicked:@"blue"];
    double bluePercentageClicked = (bluesDisplayed > 0) ? ((double)bluesClicked / (double)bluesDisplayed) : 0.0;

    
    // determine CTR & assign weight to colors
    int redWeight = 100 + 1000*redPercentageClicked;
    int greenWeight = 100 + 1000*greenPercentageClicked;
    int blueWeight = 100 + 1000*bluePercentageClicked;
    
    
    // create ranges based on weights
    NSRange redRange = NSMakeRange(0, redWeight); // { 0, 106 }
    NSRange greenRange = NSMakeRange(redWeight, redWeight + greenWeight); // { 106, 228 }
    
    // we don't need this... but just to show the approximate range:
    //NSRange blueRange = NSMakeRange(redWeight + greenWeight, redWeight + greenWeight + blueWeight); // { 228, 341 }
    
    // 'throw a dart' at our ranges to see where it lands
    int rand = arc4random() % (redWeight + greenWeight + blueWeight);
    
    // if the dart is in the red section...
    if(NSLocationInRange(rand, redRange)) {
        
        // make the button red
        _donateButton.backgroundColor = [UIColor redColor];
        _buttonColorString = @"red";
        
    }
    
    // or the green section
    else if(NSLocationInRange(rand, greenRange)) {
        
        // make the button green
        _donateButton.backgroundColor = [UIColor greenColor];
        _buttonColorString = @"green";
        
    }
    
    // or the blue section
    else {
        
        // make the button blue
        _donateButton.backgroundColor = [UIColor blueColor];
        _buttonColorString = @"blue";
        
    }
    
    // save the 'displayed' result to our backend
    NSMutableDictionary *extras = [NSMutableDictionary dictionary];
    [extras setObject:_buttonColorString forKey:@"button_color"];
    [extras setObject:@"displayed" forKey:@"event_status"];
    
    [KiiAnalytics trackEvent:@"button" withExtras:extras];
    
}


/* The 'donate' button was clicked */
- (IBAction)sendToDonate:(id)sender
{
    
    // save the result
    NSMutableDictionary *extras = [NSMutableDictionary dictionary];
    [extras setObject:_buttonColorString forKey:@"button_color"];
    [extras setObject:@"clicked" forKey:@"event_status"];
    
    [KiiAnalytics trackEvent:@"button" withExtras:extras];
    
    
    // do something for the user
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
