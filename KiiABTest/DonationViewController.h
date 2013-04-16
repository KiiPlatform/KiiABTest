//
//  DonationViewController.h
//  KiiABTest
//
//  Created by Chris Beauchamp on 4/15/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DonationViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *donateButton;
@property (nonatomic, strong) IBOutlet UIButton *noThanksButton;

- (IBAction)sendToDonate:(id)sender;
- (IBAction)closeDonateView:(id)sender;

@end
