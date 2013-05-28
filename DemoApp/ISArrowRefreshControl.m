#import "ISArrowRefreshControl.h"
#import "ISScalingActivityIndicatorView.h"

@implementation ISArrowRefreshControl

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
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.firesOnRelease = YES;
    
    self.indicatorView = [[UIActivityIndicatorView alloc] init];
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:self.indicatorView];
    
    UIImage *image = [UIImage imageNamed:@"arrow"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:self.imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.center = CGPointMake(self.frame.size.width / 2.f, self.frame.size.height / 2.f);
    self.indicatorView.frame = CGRectMake(self.frame.size.width/2.f-15, 25-13, 30, 30);
}

#pragma mark - ISAlternativeRefreshControl events

- (void)didChangeProgress
{
    if (self.refreshingState == ISRefreshingStateNormal) {
        if (self.progress < .5) {
            self.imageView.transform = CGAffineTransformIdentity;
        } else {
            CGFloat progress = (self.progress - .5f) / .5f;
            if (progress > 1.f) {
                progress = 1.f;
            }
            self.imageView.transform = CGAffineTransformMakeRotation(-M_PI * progress);
        }
    }
}

- (void)willChangeRefreshingState:(ISRefreshingState)refreshingState
{
    switch (refreshingState) {
        case ISRefreshingStateNormal:
            self.imageView.hidden = NO;
            break;
            
        case ISRefreshingStateRefreshing:
            self.imageView.hidden = YES;
            [self.indicatorView startAnimating];
            break;
            
        case ISRefreshingStateRefreshed:
            [self.indicatorView stopAnimating];
            break;
            
        default: break;
    }
}
@end
