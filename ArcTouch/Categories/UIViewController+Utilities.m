//
//  UIViewController+Utilities.m
//  Personal Usage
//
//  Created by Herzon Rodriguez on 10/19/15.
//  Copyright © 2015 SymmetryApps. All rights reserved.
//

#import "UIViewController+Utilities.h"

static NSInteger const kHRLoadingViewTag = 10000;

@implementation UIViewController (Utilities)

- (void)hr_showLoadingView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    view.tag = kHRLoadingViewTag;
    view.alpha = 0.0;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.tag = 11000;
    activity.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:activity];
    [activity startAnimating];
    
    [self.view addSubview:view];
    
    [UIView animateWithDuration:0.35 animations:^{
        view.alpha = 1.0;
    }];

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:activity attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:activity attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];

    [self.view addConstraints:@[top, bottom, leading, trailing]];
    [view addConstraints:@[centerY, centerX]];
}

- (void)hr_removeLoadingView {
    UIView *loadingView = [self.view viewWithTag:kHRLoadingViewTag];
    
    [UIView animateWithDuration:0.35 animations:^{
        loadingView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
    }];
}

+ (id)hr_loadViewControllerFromNib {
    NSString *className = NSStringFromClass([self class]);
    id viewController = [[[self class] alloc] initWithNibName:className bundle:nil];
    return viewController;
}

@end
