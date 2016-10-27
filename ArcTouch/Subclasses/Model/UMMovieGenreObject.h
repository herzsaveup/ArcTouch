//
//  UMMovieGenreObject.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMMovieGenreObject : NSObject

+ (NSArray *)createArrayOfGenresFromGenresIds:(NSArray *)genresIdsArray;

@property (assign, nonatomic) NSInteger genreId;
@property (strong, nonatomic) NSString *genreName;

@end
