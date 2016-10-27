//
//  UMMovieObject.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

/*
    Movie object class. Easy to add/modify new/existing properties
 */

#import <Foundation/Foundation.h>

@class UMMovieGenreObject;

@interface UMMovieObject : NSObject

/*
    Only initialization that is useful for this class, to return a useful object
 */
- (instancetype)initWithMovieInfo:(NSDictionary *)movieInfo;

@property (strong, nonatomic) NSString *movieName;
@property (strong, nonatomic) NSString *movieYear;
@property (strong, nonatomic) NSString *movieImageUrl;
@property (strong, nonatomic) NSArray<UMMovieGenreObject *> *movieGenres;
@property (strong, nonatomic) NSString *movieGenresString;
@property (strong, nonatomic) NSString *movieReleaseDate;
@property (strong, nonatomic) NSString *movieOverview;

@end
