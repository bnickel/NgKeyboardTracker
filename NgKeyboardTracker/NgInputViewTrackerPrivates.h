//
//  NgInputViewTrackerPrivates.h
//  NgKeyboardTracker
//
//  Created by Brian Nickel on 8/21/15.
//  Copyright © 2015 BlockThirty. All rights reserved.
//

#ifndef NgInputViewTrackerPrivates_h
#define NgInputViewTrackerPrivates_h

@class NgInputViewTracker;

@protocol NgInputViewTrackerDelegate <NSObject>
@optional
- (void)inputViewTracker:(nonnull NgInputViewTracker *)inputViewTracker
  keyboardFrameDidChange:(CGRect)frame;
@end

@interface NgInputViewTracker (Privates)
- (nonnull instancetype)initWithDelegate:(nonnull id<NgInputViewTrackerDelegate>)delegate;
@end

#endif
