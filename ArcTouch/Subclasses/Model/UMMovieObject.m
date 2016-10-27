//
//  UMMovieObject.m
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import "UMMovieObject.h"
#import "UMMovieGenreObject.h"

static NSString * const kUMMovieNameKey = @"title";
static NSString * const kUMMovieGenreKey = @"genre_ids";
static NSString * const kUMMovieReleaseDateKey = @"release_date";
static NSString * const kUMMoviePosterImagePathKey = @"poster_path";
static NSString * const kUMMovieOverviewKey = @"overview";

@implementation UMMovieObject

/*
    Here we initialize all needed properties of the movie as well as some "computed" properties like the moviesGenresString
    so it will all stay in one place to be used where needed
 */
- (instancetype)initWithMovieInfo:(NSDictionary *)movieInfo {
    self = [super init];
    if (self) {
        self.movieName = movieInfo[kUMMovieNameKey];
        self.movieReleaseDate = movieInfo[kUMMovieReleaseDateKey];
        self.movieImageUrl = [NSString stringWithFormat:kUMMoviePosterImageBasePath, movieInfo[kUMMoviePosterImagePathKey]];
        self.movieGenres = [UMMovieGenreObject createArrayOfGenresFromGenresIds:movieInfo[kUMMovieGenreKey]];
        NSMutableString *genresString = [NSMutableString new];
        [self.movieGenres enumerateObjectsUsingBlock:^(UMMovieGenreObject * _Nonnull genre, NSUInteger idx, BOOL * _Nonnull stop) {
            [genresString appendFormat:@"%@%@", genre.genreName, idx == self.movieGenres.count-1 ? @"" : @", "];
        }];
        self.movieGenresString = genresString;
        self.movieYear = [self.movieReleaseDate substringToIndex:4]; // This could be tricky as date format can change
        self.movieOverview = movieInfo[kUMMovieOverviewKey];
    }
    return self;
}

@end
