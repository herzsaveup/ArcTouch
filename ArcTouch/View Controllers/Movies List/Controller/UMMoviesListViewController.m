//
//  UMMoviesListViewController.m
//  ArcTouch
//
//  Created by Herzon Rodriguez on 10/27/16.
//  Copyright © 2016 Symmetry Apps. All rights reserved.
//

#import "UMMoviesListViewController.h"
#import "UMMovieDetailViewController.h"

#import "UMMovieGenresManager.h"
#import "UMRequestsManager.h"
#import "UMMovieListCell.h"
#import "UMMovieObject.h"

@interface UMMoviesListViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    BOOL _isSearching;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *moviesListArray;
@property (strong, nonatomic) NSArray *filteredMoviesListArray;

@end

@implementation UMMoviesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Upcoming Movies";
    
    [SVProgressHUD showWithStatus:@"Getting movies list"];
    
    [self.tableView registerNib:[UMMovieListCell hr_nibForView] forCellReuseIdentifier:[UMMovieListCell hr_reuseIdentifier]];
    
    [UMRequestsManager getMoviesGenresListWithCompletionHandler:^(id responseObject, NSError *error) {
        [UMMovieGenresManager serializeMovieGenres:responseObject[@"genres"]];
        [UMRequestsManager getUpcomingMoviesListWithCompletionHandler:^(id responseObject, NSError *error) {
            [SVProgressHUD dismiss];
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSArray *moviesArray = [responseObject[@"results"] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"release_date" ascending:NO]]];
                NSMutableArray *moviesList = [NSMutableArray new];
                [moviesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [moviesList addObject:[[UMMovieObject alloc] initWithMovieInfo:obj]];
                }];
                
                self.moviesListArray = [NSArray arrayWithArray:moviesList];
                [self.tableView reloadData];
            }
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - NSNotifications

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    [self.tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0)];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0)];
    [self.view layoutIfNeeded];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self.tableView setScrollIndicatorInsets:contentInsets];
    [self.view layoutIfNeeded];
}

#pragma mark - Getters

- (NSArray *)moviesListArray {
    return _isSearching ? _filteredMoviesListArray : _moviesListArray;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moviesListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UMMovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:[UMMovieListCell hr_reuseIdentifier] forIndexPath:indexPath];
    
    [cell configureCellWithMovieObject:self.moviesListArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UMMovieListCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UMMovieDetailViewController *viewController = [UMMovieDetailViewController hr_loadViewControllerFromNib];
    viewController.movie = self.moviesListArray[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _isSearching = YES;
    self.filteredMoviesListArray = self.filteredMoviesListArray ?:  _moviesListArray;
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        self.filteredMoviesListArray = _moviesListArray;
    } else {
        self.filteredMoviesListArray = [_moviesListArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"movieName CONTAINS[cd] %@", searchText]];
    }
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    _isSearching = NO;
    _filteredMoviesListArray = nil;
    [self.tableView reloadData];
    [searchBar setShowsCancelButton:NO animated:YES];
}

@end
