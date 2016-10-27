//
//  UMMovieListCell.h
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UMMovieObject;

@interface UMMovieListCell : UITableViewCell

- (void)configureCellWithMovieObject:(UMMovieObject *)movie;

+ (CGFloat)height;

@end
