#import "ISGumRefreshControl.h"
#import "ISScalingActivityIndicatorView.h"
#import "ISGumView.h"

@implementation ISGumRefreshControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];
    
    self.indicatorView = [[ISScalingActivityIndicatorView alloc] init];
    [self addSubview:self.indicatorView];
    
    self.gumView = [[ISGumView alloc] init];
    self.gumView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.gumView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gumView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, 200.f);
    self.indicatorView.frame = CGRectMake(self.frame.size.width/2.f-12, 25-13, 25, 25);
}

#pragma mark - ISAlternativeRefreshControl events

- (void)didChangeProgress
{
    if (self.refreshingState == ISRefreshingStateNormal) {
        self.gumView.maxDistance = ABS(self.threshold) - 35;
        
        if (self.progress <= .35f) {
            self.gumView.distance = 1.f;
        } else {
            self.gumView.distance = (self.progress - .35f) / (1.f-.35f) * self.gumView.maxDistance;
        }
        
        [self.gumView setNeedsDisplay];
    }
}

- (void)willChangeRefreshingState:(ISRefreshingState)refreshingState
{
    switch (refreshingState) {
        case ISRefreshingStateRefreshing:
            [self.gumView shrink];
            [self.indicatorView startAnimating];
            break;
            
        case ISRefreshingStateRefreshed:
            [self.indicatorView stopAnimating];
            break;
            
        default: break;
    }
}

@end
