//
//  KAFilter.h
//  KiiAnalytics
//
//  Copyright (c) 2013 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Use this class to set up one or more filters for your query
 */
@interface KAFilter : NSObject

/** Add a key/value pair to this filter
 
 Use filters to slice your data into useful result sets
 @param filterKey The key to filter by
 @param filterValue The value to filter against
*/
- (void) addFilter:(NSString*)filterKey withValue:(NSString*)filterValue;

@end
