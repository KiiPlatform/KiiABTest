//
//  ABStorage.m
//  KiiABTest
//
//  Created by Chris Beauchamp on 4/14/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "ABStorage.h"

#import <KiiAnalytics/KiiAnalytics.h>

@implementation ABStorage

+ (int) getDisplayed:(NSString*)color
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"displayed_%@", color]];
}

+ (int) getClicked:(NSString*)color
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"clicked_%@", color]];
}

+ (void) loadABConfig
{
    NSArray *colors = @[@"red", @"green", @"blue"];
    
    for(__block NSString *color in colors) {
        
        KAFilter *filter = [[KAFilter alloc] init];
        [filter addFilter:@"button_color" withValue:color];
        
        KAResultQuery *query = [[KAResultQuery alloc] init];
        [query setGroupingKey:@"event_status"];
        [query setFilter:filter];
        
        [KiiAnalytics getResult:@"23" usingQuery:query andBlock:^(KAGroupedResult *results, NSError *error) {
            
            if(error == nil) {
                
                int clicked = 0;
                int displayed = 0;
                
                for(KAGroupedSnapShot *snapshot in results.snapshots) {

                    if([snapshot.name isEqualToString:@"clicked"]) {
                        
                        for(NSNumber *n in snapshot.data) {
                            clicked += n.intValue;
                        }
                        
                    } else if([snapshot.name isEqualToString:@"displayed"]) {
                        
                        for(NSNumber *n in snapshot.data) {
                            displayed += n.intValue;
                        }
                        
                    }

                }
                
                // save these values
                [[NSUserDefaults standardUserDefaults] setInteger:clicked forKey:[NSString stringWithFormat:@"clicked_%@", color]];
                [[NSUserDefaults standardUserDefaults] setInteger:displayed forKey:[NSString stringWithFormat:@"displayed_%@", color]];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            } else {
                NSLog(@"Error: %@", error);
            }
            
        }];
    }
    
}

@end
