#import "ISAlternativeRefreshControl.h"

static CGFloat const FRTRefreshControlHeight = 45.f;
static CGFloat const FRTRefreshControlThreshold = -110.f;

@interface ISAlternativeRefreshControl ()

@property (nonatomic) ISRefreshingState refreshingState;
@property (nonatomic) CGFloat progress;

@end

@implementation ISAlternativeRefreshControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.threshold = -110.f;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.threshold = -110.f;
    }
    return self;
}

#pragma mark - accessors

- (BOOL)isRefreshing
{
    return self.refreshingState == ISRefreshingStateRefreshing;
}

#pragma mark - UIView events

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (void)didMoveToSuperview
{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [self.superview addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.superview && [keyPath isEqualToString:@"contentOffset"]) {
        [self.superview bringSubviewToFront:self];
        [self keepOnTop];
        [self updateRefreshingState];
        [self updateProgress];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - contentOffset actions

- (void)keepOnTop
{
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    CGFloat offset = [(UIScrollView *)self.superview contentOffset].y;
    if (offset < -self.frame.size.height) {
        self.frame = CGRectMake(0.f, offset, self.frame.size.width, self.frame.size.height);
    } else {
        self.frame = CGRectMake(0.f, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }
}

- (void)updateProgress
{
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    CGFloat progress = [(UIScrollView *)self.superview contentOffset].y / FRTRefreshControlThreshold;
    [self willChangeProgress:progress];
    [self setProgress:progress];
    [self didChangeProgress];
}

- (void)updateRefreshingState
{
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    CGFloat offset = [scrollView contentOffset].y;
    
    switch (self.refreshingState) {
        case ISRefreshingStateNormal:
            if (offset < FRTRefreshControlThreshold) {
                [self beginRefreshing];
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
            break;
            
        case ISRefreshingStateRefreshed:
            if (offset >= 0.f && !scrollView.isTracking) {
                [self resetRefreshingState];
            }
            break;
            
        default: break;
    }
}

#pragma mark -

// ISRefreshingStateNormal -> ISRefreshingStateRefreshing,
- (void)beginRefreshing
{
    if (self.isRefreshing) {
        return;
    }

    [self willChangeRefreshingState:ISRefreshingStateRefreshing];
    self.refreshingState = ISRefreshingStateRefreshing;
    
    UIScrollView *scrollView = (id)self.superview;
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top += FRTRefreshControlHeight;
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         scrollView.contentInset = inset;
                     }
                     completion:^(BOOL finished) {
                         [self didChangeRefreshingState];
                     }];
}

// ISRefreshingStateRefreshing -> ISRefreshingStateRefreshed,
- (void)endRefreshing
{
    if (!self.isRefreshing) {
        return;
    }
    
    [self willChangeRefreshingState:ISRefreshingStateRefreshed];
    
    UIScrollView *scrollView = (id)self.superview;
    CGFloat offset = scrollView.contentOffset.y;
    UIEdgeInsets inset = scrollView.contentInset;
    inset.top -= FRTRefreshControlHeight;
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         scrollView.contentInset = inset;
                     }
                     completion:^(BOOL finished) {
                         self.refreshingState = ISRefreshingStateRefreshed;
                         [self didChangeRefreshingState];
                         
                         if (offset <= 0.f) {
                             [self didChangeRefreshingState];
                             [self resetRefreshingState];
                         }
                     }];
}

// ISRefreshingStateRefreshed -> ISRefreshingStateNormal
- (void)resetRefreshingState
{
    [self willChangeRefreshingState:ISRefreshingStateNormal];
    self.refreshingState = ISRefreshingStateNormal;
    [self didChangeRefreshingState];
}

#pragma mark - ISAlternativeRefreshControl events

- (void)willChangeProgress:(CGFloat)progress
{
}

- (void)didChangeProgress
{
}

- (void)willChangeRefreshingState:(ISRefreshingState)refreshingState
{
}

- (void)didChangeRefreshingState
{
}

@end
