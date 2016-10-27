//
//  UMMovieGenresManager.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMMovieGenresManager : NSObject

+ (void)serializeMovieGenres:(NSArray *)genres;

+ (NSArray *)movieGenres;
+ (NSDictionary *)movieGenreInfoWithGenreId:(NSInteger)genreId;

@end
