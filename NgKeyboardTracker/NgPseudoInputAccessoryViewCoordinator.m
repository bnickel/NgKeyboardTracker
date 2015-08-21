//
//  NgPseudoInputAccessoryViewCoordinator.m
//  NgKeyboardTracker
//
//  Created by Meiwin Fu on 3/7/15.
//  Copyright (c) 2015 Meiwin Fu. All rights reserved.
//

#import "NgPseudoInputAccessoryViewCoordinator.h"
#import "NgPseudoInputAccessoryViewCoordinatorPrivates.h"
#import "NgInputViewTracker.h"

#pragma mark -

@interface NgPseudoInputAccessoryView : UIView {
  CGFloat _height;
  NSLayoutConstraint * _heightConstraint;
  NgInputViewTracker * _tracker;
}
@property (nonatomic) CGFloat height;
@property (nonatomic) NgInputViewTracker *tracker;
@end

@implementation NgPseudoInputAccessoryView
- (void)willMoveToSuperview:(UIView *)aSuperview
{
  [super willMoveToSuperview:aSuperview];
  [_tracker inputAccessoryView:self willMoveToSuperview:aSuperview];
}
- (void)didMoveToSuperview {
  [super didMoveToSuperview];
  
  __block NSLayoutConstraint * heightConstraint = nil;
  [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * constraint, NSUInteger idx, BOOL *stop) {
    if (constraint.firstItem == self &&
        constraint.firstAttribute == NSLayoutAttributeHeight &&
        constraint.relation == NSLayoutRelationEqual) {
      heightConstraint = constraint;
      *stop = YES;
    }
  }];
  _heightConstraint = heightConstraint;
  _heightConstraint.constant = _height;
}
- (void)setHeight:(CGFloat)height {
  if (_height == height) return;
  _height = height;
  _heightConstraint.constant = height;
}
- (CGFloat)height {
  return _height;
}
@end

#pragma mark -
@interface NgPseudoInputAccessoryViewCoordinator () {
  struct {
    int didSetHeight;
  } _delegateFlags;
  
  __weak UIResponder * _weakTrackedResponder;
  BOOL _tracking;
  __weak id<NgPseudoInputAccessoryViewCoordinatorDelegate> _delegate;
  NgPseudoInputAccessoryView * _pseudoInputAccessoryView;
}
@end

@implementation NgPseudoInputAccessoryViewCoordinator

- (instancetype)_init {
  self = [super init];
  if (self) {
    _pseudoInputAccessoryView = [NgPseudoInputAccessoryView new];
    _pseudoInputAccessoryView.backgroundColor = [UIColor clearColor];
    _pseudoInputAccessoryView.userInteractionEnabled = NO;
  }
  return self;
}
- (void)dealloc {
  _pseudoInputAccessoryView = nil;
}
- (void)setDelegate:(id<NgPseudoInputAccessoryViewCoordinatorDelegate>)delegate {
  _delegate = delegate;
  _delegateFlags.didSetHeight = delegate && [(id)delegate respondsToSelector:@selector(pseudoInputAccessoryViewCoordinator:didSetHeight:)];
    if (delegate && [(id)delegate respondsToSelector:@selector(pseudoInputAccessoryViewCoordinatorRequestedInputViewTracker:)]) {
        _pseudoInputAccessoryView.tracker = [delegate pseudoInputAccessoryViewCoordinatorRequestedInputViewTracker:self];
    } else {
        _pseudoInputAccessoryView.tracker = nil;
    }
}
- (void)didSetHeight:(CGFloat)height {
  if (_delegateFlags.didSetHeight) [_delegate pseudoInputAccessoryViewCoordinator:self didSetHeight:height];
}

#pragma mark Public
- (void)setPseudoInputAccessoryViewHeight:(CGFloat)height {
  [(NgPseudoInputAccessoryView *)_pseudoInputAccessoryView setHeight:height];
  [self didSetHeight:height];
}
- (CGFloat)pseudoInputAccessoryViewHeight {
  return [(NgPseudoInputAccessoryView *)_pseudoInputAccessoryView height];
}
- (BOOL)isActive {
  return _pseudoInputAccessoryView.superview != nil;
}
@end
