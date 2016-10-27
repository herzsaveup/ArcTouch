//
//  UMMovieDetailViewController.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

/*
    Movie Detail View Controller to show the movie details. 
    Needs a UMMovieObject to configure the view
 */

#import "UMGeneralViewController.h"

@class UMMovieObject;

@interface UMMovieDetailViewController : UMGeneralViewController

@property (strong, nonatomic) UMMovieObject *movie;

@end
