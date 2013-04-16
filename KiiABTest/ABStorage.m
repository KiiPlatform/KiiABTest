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

#import "ABStorage.h"

#import <KiiAnalytics/KiiAnalytics.h>

@implementation ABStorage

// get the data from cache
+ (int) getDisplayed:(NSString*)color
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"displayed_%@", color]];
}

// get the data from cache
+ (int) getClicked:(NSString*)color
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"clicked_%@", color]];
}

/* Called on app open, load the latest stats from the analytics SDK */
+ (void) loadABConfig
{
    
    // iterate through our colors to get stats on each
    NSArray *colors = @[@"red", @"green", @"blue"];
    for(__block NSString *color in colors) {
        
        // create a filter for these stats
        KAFilter *filter = [[KAFilter alloc] init];
        [filter addFilter:@"button_color" withValue:color];
        
        // group the results by 'event_status'
        // i.e. clicked/displayed
        KAResultQuery *query = [[KAResultQuery alloc] init];
        [query setGroupingKey:@"event_status"];
        [query setFilter:filter];
        
        // retrieve the results
        [KiiAnalytics getResult:@"23"
                     usingQuery:query
                       andBlock:^(KAGroupedResult *results, NSError *error) {
            
            // the request was successful
            if(error == nil) {
                
                // keep track of how many clicks/displayed across segments
                int clicked = 0;
                int displayed = 0;
                
                // iterates over each time segment (usually days) to get
                // the stats. we want to aggregate these
                for(KAGroupedSnapShot *snapshot in results.snapshots) {

                    // if this is the 'clicked' stat, increment the count
                    // based on the stored data
                    if([snapshot.name isEqualToString:@"clicked"]) {
                        
                        for(NSNumber *n in snapshot.data) {
                            clicked += n.intValue;
                        }
                        
                    }
                    
                    // if this is the 'displayed' stat, increment the count
                    // based on the stored data                    
                    else if([snapshot.name isEqualToString:@"displayed"]) {
                        
                        for(NSNumber *n in snapshot.data) {
                            displayed += n.intValue;
                        }
                        
                    }

                }
                
                // save these values to cache
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
