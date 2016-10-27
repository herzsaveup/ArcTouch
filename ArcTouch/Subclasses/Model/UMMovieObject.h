//
//  UMMovieObject.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UMMovieGenreObject;

@interface UMMovieObject : NSObject

- (instancetype)initWithMovieInfo:(NSDictionary *)movieInfo;

@property (strong, nonatomic) NSString *movieName;
@property (strong, nonatomic) NSString *movieYear;
@property (strong, nonatomic) NSString *movieImageUrl;
@property (strong, nonatomic) NSArray<UMMovieGenreObject *> *movieGenres;
@property (strong, nonatomic) NSString *movieGenresString;
@property (strong, nonatomic) NSString *movieReleaseDate;
@property (strong, nonatomic) NSString *movieOverview;

@end
