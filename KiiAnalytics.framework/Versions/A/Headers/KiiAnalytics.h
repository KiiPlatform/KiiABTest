//
//  KiiAnalytics.h
//  KiiAnalytics
//
//  Copyright (c) 2013 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KAGroupedResult.h"
#import "KAGroupedSnapShot.h"
#import "KAResultQuery.h"
#import "KAFilter.h"
#import "KADateRange.h"

enum {
    kiiAnalyticsSiteUS,
    kiiAnalyticsSiteJP
};
typedef NSUInteger KiiAnalyticsSite;

typedef void (^KAResultBlock)(KAGroupedResult *results, NSError *error);

/** The main SDK class
 
 This class must be initialized on application launch using beginWithID:andKey:. This class also allows the application to make some high-level user calls and access some application-wide data at any time using static methods.
 */
@interface KiiAnalytics : NSObject

/** Initialize the KiiAnalytics SDK
 
 Should reside in applicationDidFinishLaunching:withResult:
 @param appId The application ID found in your Kii developer console
 @param appKey The application key found in your Kii developer console
 */
+ (void) beginWithID:(NSString*)appId andKey:(NSString*)appKey;

/** Initialize the KiiAnalytics SDK
 
 Should reside in applicationDidFinishLaunching:withResult:
 If Kii has provided a custom URL, use this initializer to set it
 @param appId The application ID found in your Kii developer console
 @param appKey The application key found in your Kii developer console
 @param kiiSite One of the enumerator constants kiiAnalyticsSiteUS (United States) or kiiAnalyticsSiteJP (Japan), based on your desired location
 */
+ (void) beginWithID:(NSString*)appId andKey:(NSString*)appKey andSite:(KiiAnalyticsSite)kiiSite;


/** Log a single event to be uploaded to KiiAnalytics
 
 Use this method if you'd like to track an event by name only. If you'd like to track other attributes/dimensions, please use trackEvent:withExtras:
 Will return TRUE every time unless there was an error writing to the cache.
 @param event A string representing the event name for later tracking. This must not nil or empty, and length must be less than or equals 128bytes in UTF-8.
 @return TRUE if the event was added properly, FALSE otherwise
 */
+ (BOOL) trackEvent:(NSString*)event;


/** Log a single event to be uploaded to KiiAnalytics
 
 Use this method if you'd like to track an event by name and add extra information to the event.
 Will return TRUE every time unless there was an error writing to the cache OR if one of the extra key/value pairs was not JSON-encodable.
 @param event A string representing the event name for later tracking. This must not nil or empty, and length must be less than or equals 128bytes in UTF-8.
 @param extras A dictionary of JSON-encodable key/value pairs to be attached to the event
 @return TRUE if the event was added properly, FALSE otherwise
 */
+ (BOOL) trackEvent:(NSString *)event withExtras:(NSDictionary*)extras;

/** Get a result set of analytics based on a specific query
 
 This method allows you to use analytics results within your application
 @param error An NSError object, set to nil, to test for errors
 @param aggregationRuleID The aggregation rule to slice data by
 @param query The query object to use for retrieving data
 @return A result object with the segmented data broken into manageable data structures. Usually KAGroupedSnapShots.
 */
+ (KAGroupedResult*) getResultSynchronous:(NSError**)error
                      withAggregationRule:(NSString*)aggregationRuleID
                               usingQuery:(KAResultQuery*)query;


/** Asynchronously authenticates a user with the server using a valid access token
 
 Authenticates a user with the server. This method is non-blocking.
 
    [KiiUser getResult:@"my-aggregation-rule" 
            usingQuery:myQuery
              andBlock:^(KAGroupedResults *results, NSError *error) {
        
        if(error == nil) {
            NSLog(@"Got results: %@", results);
        }
    }];
 
 @param aggregationRuleID The aggregation rule to slice data by
 @param query The query object to use for retrieving data
 @param block The block to be called upon method completion. See example
 */
+ (void) getResult:(NSString*)aggregationRuleID
        usingQuery:(KAResultQuery*)query
          andBlock:(KAResultBlock)block;

@end
