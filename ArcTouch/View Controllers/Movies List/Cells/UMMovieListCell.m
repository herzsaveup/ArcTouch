//
//  UMMovieListCell.m
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import "UMMovieListCell.h"
#import "UMMovieObject.h"

static CGFloat const kUMMovieListCellHeight = 200.0;

@interface UMMovieListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieGenreLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseDateLabel;

@end

@implementation UMMovieListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moviePosterImageView.clipsToBounds = YES;
    
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

#pragma mark - Public Methods

+ (CGFloat)height {
    return kUMMovieListCellHeight;
}

- (void)configureCellWithMovieObject:(UMMovieObject *)movie {
    self.movieNameLabel.text = movie.movieName;
    self.movieGenreLabel.text = movie.movieGenresString;
    self.movieReleaseDateLabel.text = [NSString stringWithFormat:@"Release Date: %@", movie.movieReleaseDate];
    [self.moviePosterImageView sd_setImageWithURL:[NSURL URLWithString:movie.movieImageUrl] placeholderImage:[UIImage imageNamed:@"tmdb"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.moviePosterImageView.image = image;
            
        }
    }];
}

@end
