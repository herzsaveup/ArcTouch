//
//  UIView+Utilities.m
//  Personal Usage
//
//  Created by Herzon Rodriguez on 10/19/15.
//  Copyright © 2015 SymmetryApps. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

+ (id)hr_loadViewFromNib {
    NSString *className = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil] lastObject];
}

@end

@implementation UIView (CellReuseIdentifier)

+ (NSString *)hr_reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)hr_nibForView {
    NSString *className = NSStringFromClass([self class]);
    return [UINib nibWithNibName:className bundle:nil];
}

@end
