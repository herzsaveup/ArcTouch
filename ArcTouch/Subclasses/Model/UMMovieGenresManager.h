//
//  UMMovieGenresManager.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

/*
    Separate class to handle the serialization of the genres list for offline consulting
 */

#import <Foundation/Foundation.h>

@interface UMMovieGenresManager : NSObject

/*
    This method saves the movies genres list in the Documents folder for "future references" (Offline queries).
 */
+ (void)serializeMovieGenres:(NSArray *)genres;


/*
    This method retrieves the saved genres list and uses it, if there are no saved list, it uses a local copy of a dummy
    file just to have some information to display
 */
+ (NSArray *)movieGenres;


/*
    Gets the saved genre information by it's id(s) that the movie object could have
 */
+ (NSDictionary *)movieGenreInfoWithGenreId:(NSInteger)genreId;

@end
