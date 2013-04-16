//
//  KAResultQuery.h
//  KiiAnalytics
//
//  Copyright (c) 2013 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KADateRange, KAFilter;

/** Use this class to generate a query against the analytics data
 */
@interface KAResultQuery : NSObject

/** The grouping key associated with the query object */
@property (nonatomic, strong) NSString *groupingKey;

/** The filter associated with the query object */
@property (nonatomic, strong) KAFilter *filter;

/** The date range for the query object */
@property (nonatomic, strong) KADateRange *dateRange;

@end
