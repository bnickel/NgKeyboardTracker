//
//  NgInputViewTracker.h
//  NgKeyboardTracker
//
//  Created by Brian Nickel on 8/21/15.
//  Copyright © 2015 BlockThirty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NgInputViewTracker : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
- (void)inputAccessoryView:(nonnull UIView *)inputAccessoryView willMoveToSuperview:(nullable UIView *)newSuperview;

@end
