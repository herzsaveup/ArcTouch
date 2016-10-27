//
//  UMRequestsManager.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

/*
    Class methods to make all network calls transparent for any class that uses them
 */

#import <Foundation/Foundation.h>

@interface UMRequestsManager : NSObject

/*
    Request method to get the movies list
 */
+ (void)getUpcomingMoviesListWithCompletionHandler:(void (^)(id responseObject, NSError *error))completionHandler;

/*
 Request method to get the genres list
 */
+ (void)getMoviesGenresListWithCompletionHandler:(void (^)(id responseObject, NSError *error))completionHandler;

@end
