//
//  UMMovieGenreObject.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMMovieGenreObject : NSObject

/*
    Creates an array of UMMovieGenreObjects from an array of genreIds for a movie, so it can
    have dot access properties instead of an array of dictionaries
 */
+ (NSArray *)createArrayOfGenresFromGenresIds:(NSArray *)genresIdsArray;

@property (assign, nonatomic) NSInteger genreId;
@property (strong, nonatomic) NSString *genreName;

@end
