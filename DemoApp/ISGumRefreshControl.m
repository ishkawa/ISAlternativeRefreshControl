#import "ISGumRefreshControl.h"
#import "ISGumView.h"

@interface ISGumRefreshControl ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ISGumView *gumView;

@end

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
    
    self.threshold = -60.f;
    self.imageView = [[UIImageView alloc] init];
//    self.imageView.frame = CGRectMake(0, 0, self.mainRadius*2-12, self.mainRadius*2-12);
//    self.imageView.center = CGPointMake(self.frame.size.width/2.f, self.mainRadius);
    self.imageView.image = [UIImage imageNamed:@"ISRefresgControlIcon"];
    [self addSubview:self.imageView];
    
    self.gumView = [[ISGumView alloc] init];
    self.gumView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.gumView];
}

#pragma mark - ISAlternativeRefreshControl events

- (void)didChangeProgress
{
    if (self.refreshingState == ISRefreshingStateNormal) {
        self.gumView.frame = CGRectMake(0.f, 0.f, self.frame.size.width, 200.f);
        
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
        case ISRefreshingStateNormal:
            self.alpha = 1.f;
            break;
            
        case ISRefreshingStateRefreshing:
            [self.gumView shrink];
            break;
            
        default: break;
    }
}

@end
