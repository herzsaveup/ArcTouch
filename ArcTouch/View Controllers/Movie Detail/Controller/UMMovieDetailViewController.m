//
//  UMMovieDetailViewController.m
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import "UMMovieDetailViewController.h"
#import "UMMovieObject.h"

@interface UMMovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieGenreLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieReleaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieOverviewLabel;

@end

@implementation UMMovieDetailViewController

/*
    Used NSMutableAttributedString for some texts to improve their "looks"
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Detail";
    
    self.moviePosterImageView.clipsToBounds = YES;
    self.moviePosterImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.moviePosterImageView.layer.borderWidth = 1.0;
    [self.moviePosterImageView sd_setImageWithURL:[NSURL URLWithString:self.movie.movieImageUrl]];
    
    NSString *movieName = self.movie.movieName;
    NSString *movieYear = self.movie.movieYear;
    NSMutableAttributedString *attributedMovieName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@)", movieName, movieYear] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0], NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    [attributedMovieName addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0], NSForegroundColorAttributeName: [UIColor whiteColor]} range:[attributedMovieName.string rangeOfString:movieName]];
    self.movieNameLabel.attributedText = attributedMovieName;
    
    self.movieGenreLabel.text = self.movie.movieGenresString;
    
    NSString *movieReleaseDateText = @"Release Date:";
    NSString *movieReleaseDate = self.movie.movieReleaseDate;
    NSMutableAttributedString *attributedMovieReleaseDate = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", movieReleaseDateText, movieReleaseDate] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [attributedMovieReleaseDate addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0]} range:[attributedMovieReleaseDate.string rangeOfString:movieReleaseDateText]];
    self.movieReleaseDateLabel.attributedText = attributedMovieReleaseDate;
    
    NSString *movieOverviewText = @"Overview";
    NSString *movieOverview = self.movie.movieOverview;
    NSMutableAttributedString *attributedMovieOverview = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", movieOverviewText, movieOverview] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [attributedMovieOverview addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]} range:[attributedMovieOverview.string rangeOfString:movieOverviewText]];
    self.movieOverviewLabel.attributedText = attributedMovieOverview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
