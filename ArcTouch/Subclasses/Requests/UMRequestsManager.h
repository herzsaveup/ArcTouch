//
//  UMRequestsManager.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMRequestsManager : NSObject

+ (void)getUpcomingMoviesListWithCompletionHandler:(void (^)(id responseObject, NSError *error))completionHandler;
+ (void)getMoviesGenresListWithCompletionHandler:(void (^)(id responseObject, NSError *error))completionHandler;

@end
