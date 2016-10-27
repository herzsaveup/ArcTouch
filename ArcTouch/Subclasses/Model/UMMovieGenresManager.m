//
//  UMMovieGenresManager.m
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import "UMMovieGenresManager.h"

#define UMGenresFilePath [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Genres.json"]

@implementation UMMovieGenresManager

+ (void)serializeMovieGenres:(NSArray *)genres {
    NSURL *documentsDirectory = UMGenresFilePath;
    [genres writeToURL:documentsDirectory atomically:YES];
}

+ (NSArray *)movieGenres {
    NSArray *movieGenres = [NSArray arrayWithContentsOfURL:UMGenresFilePath];
    if (!movieGenres) {
        movieGenres = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Genres" ofType:@"json"]] options:NSJSONReadingMutableLeaves error:nil][@"genres"];
    }
    return movieGenres;
}

+ (NSDictionary *)movieGenreInfoWithGenreId:(NSInteger)genreId {
    NSArray *movieGenres = [UMMovieGenresManager movieGenres];
    return [[movieGenres filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %ld", genreId]] firstObject];
}

@end
