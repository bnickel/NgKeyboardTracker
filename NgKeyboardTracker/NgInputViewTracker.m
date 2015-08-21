//
//  NgInputViewTracker.m
//  NgKeyboardTracker
//
//  Created by Brian Nickel on 8/21/15.
//  Copyright © 2015 BlockThirty. All rights reserved.
//

#import "NgInputViewTracker.h"
#import "NgInputViewTrackerPrivates.h"

static int NgInputViewTrackerContext;

@interface NgInputViewTracker () {
    struct {
        int keyboardFrameDidChange;
    } _delegateFlags;
    
    id __weak _inputView;
    id<NgInputViewTrackerDelegate> __weak _delegate;
}
@end

@implementation NgInputViewTracker

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)selectorForSuperview
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return @"center";
    }
    return @"frame";
}

- (void)inputAccessoryView:(UIView *)inputAccessoryView willMoveToSuperview:(UIView *)newSuperview
{
    NSString *sel = [self selectorForSuperview];
    [inputAccessoryView.superview removeObserver:self forKeyPath:sel context:&NgInputViewTrackerContext];
    [newSuperview addObserver:self forKeyPath:sel options:0 context:&NgInputViewTrackerContext];
    _inputView = newSuperview;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == &NgInputViewTrackerContext) {
        CGRect kbframe = [object convertRect:[object bounds] toView:nil];
        [self keyboardFrameDidChange:kbframe];
    }
}

- (void)keyboardFrameDidChange:(CGRect)frame
{
    if (_delegateFlags.keyboardFrameDidChange) [_delegate inputViewTracker:self keyboardFrameDidChange:frame];
}

- (void)dealloc
{
    NSString *sel = [self selectorForSuperview];
    [_inputView removeObserver:self forKeyPath:sel context:&NgInputViewTrackerContext];
}

@end

@implementation NgInputViewTracker (Private)

- (instancetype)initWithDelegate:(id<NgInputViewTrackerDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _delegateFlags.keyboardFrameDidChange = delegate && [delegate respondsToSelector:@selector(inputViewTracker:keyboardFrameDidChange:)];
    }
    return self;
}

@end