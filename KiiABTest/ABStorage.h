//
//  ABStorage.h
//  KiiABTest
//
//  Created by Chris Beauchamp on 4/14/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABStorage : NSObject

+ (void) loadABConfig;

+ (int) getClicked:(NSString*)color;
+ (int) getDisplayed:(NSString*)color;

@end
