//
//  UMMovieGenreObject.m
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import "UMMovieGenreObject.h"
#import "UMMovieGenresManager.h"

static NSString * const kUMGenreIdKey = @"id";
static NSString * const kUMGenreNameKey = @"name";

@implementation UMMovieGenreObject

+ (NSArray *)createArrayOfGenresFromGenresIds:(NSArray *)genresIdsArray {
    NSMutableArray *genresArray = [NSMutableArray new];
    [genresIdsArray enumerateObjectsUsingBlock:^(id _Nonnull genreId, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *genreInfo = [UMMovieGenresManager movieGenreInfoWithGenreId:[genreId integerValue]] ?: @{kUMGenreIdKey: @1, kUMGenreNameKey: @"Mystery"};
        [genresArray addObject:[[UMMovieGenreObject alloc] initWithGenreInfo:genreInfo]];
    }];
    return genresArray;
}

- (instancetype)initWithGenreInfo:(NSDictionary *)genreInfo {
    self = [super init];
    if (self) {
        self.genreId = [genreInfo[kUMGenreIdKey] integerValue];
        self.genreName = genreInfo[kUMGenreNameKey];
    }
    
    return self;
}

@end
