//
//  UIViewController+Utilities.h
//  Personal Usage
//
//  Created by Herzon Rodriguez on 10/19/15.
//  Copyright © 2015 SymmetryApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utilities)

- (void)hr_showLoadingView;
- (void)hr_removeLoadingView;

+ (id)hr_loadViewControllerFromNib;

@end
