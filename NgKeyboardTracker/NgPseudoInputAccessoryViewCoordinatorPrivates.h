//
//  NgPseudoInputAccessoryViewCoordinatorPrivates.h
//  NgKeyboardTracker
//
//  Created by Meiwin Fu on 3/7/15.
//  Copyright (c) 2015 Meiwin Fu. All rights reserved.
//

#ifndef NgKeyboardTracker_NgPseudoInputAccessoryViewCoordinatorPrivates_h
#define NgKeyboardTracker_NgPseudoInputAccessoryViewCoordinatorPrivates_h

@class NgInputViewTracker;

@protocol NgPseudoInputAccessoryViewCoordinatorDelegate
@optional
- (void)pseudoInputAccessoryViewCoordinator:(NgPseudoInputAccessoryViewCoordinator *)coordinator
                               didSetHeight:(CGFloat)height;
- (NgInputViewTracker *)pseudoInputAccessoryViewCoordinatorRequestedInputViewTracker:(NgPseudoInputAccessoryViewCoordinator *)coordinator;

@end

@interface NgPseudoInputAccessoryViewCoordinator (Privates)
- (instancetype)_init;
- (void)setDelegate:(id<NgPseudoInputAccessoryViewCoordinatorDelegate>)delegate;
@end

#endif
