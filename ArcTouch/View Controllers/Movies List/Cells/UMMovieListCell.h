//
//  UMMovieListCell.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

/*
    Movies List Cell
 */

#import <UIKit/UIKit.h>

@class UMMovieObject;

@interface UMMovieListCell : UITableViewCell

/*
    Method to configure the cell in the view to reduce configuration code in the View Controller
    as well as to keep the outlet properties hidden from outside classes
 */
- (void)configureCellWithMovieObject:(UMMovieObject *)movie;

/* 
    Static height for the cell
 */
+ (CGFloat)height;

@end
