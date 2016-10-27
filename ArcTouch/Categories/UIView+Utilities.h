//
//  UIView+Utilities.h
//  Personal Usage
//
//  Created by Herzon Rodriguez on 10/19/15.
//  Copyright © 2015 SymmetryApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

+ (id)hr_loadViewFromNib;

@end

@interface UIView (CellHelpers)

+ (NSString *)hr_reuseIdentifier;
+ (UINib *)hr_nibForView;

@end
