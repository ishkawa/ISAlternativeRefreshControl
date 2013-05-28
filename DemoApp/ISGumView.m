#import "ISGumView.h"

static CGFloat const ISMainCircleMaxRadius = 16.f;
static CGFloat const ISMainCircleMinRadius = 10.f;
static CGFloat const ISSubCircleMaxRadius  = 16.f;
static CGFloat const ISSubCircleMinRadius  = 2.f;

@implementation ISGumView

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
    self.backgroundColor = [UIColor clearColor];
    
    self.mainRadius = ISMainCircleMaxRadius;
    self.subRadius  = ISMainCircleMaxRadius;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"ISRefresgControlIcon"];
    [self addSubview:self.imageView];
}

#pragma mark -

- (void)shrink
{
    self.shrinking = YES;
    
    [self shrinkWithDistanceDiff:5.f interval:0.01];
}

- (void)shrinkWithDistanceDiff:(CGFloat)distanceDiff interval:(NSTimeInterval)interval
{
    if (self.distance < 0.f) {
        self.shrinking = NO;
        self.hidden = YES;
        
        return;
    }
    
    self.distance -= distanceDiff;
    [self setNeedsDisplay];
    
    double delayInSeconds = interval;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self shrinkWithDistanceDiff:distanceDiff interval:interval];
    });
}

#pragma mark -

- (void)drawRect:(CGRect)rect
{
    if (self.distance <= 0.f) {
        return;
    }
    self.hidden = NO;
    
    if (self.shrinking) {
        self.mainRadius = ISMainCircleMinRadius*pow((self.distance/self.maxDistance), 0.1);
        if (self.distance > self.mainRadius) {
            CGFloat diff = fabsf(ISSubCircleMinRadius-self.mainRadius);
            self.subRadius = ISSubCircleMinRadius+diff*(1-(self.distance-self.mainRadius)/(self.maxDistance-self.mainRadius));
        } else {
            self.subRadius  = self.mainRadius;
        }
    } else {
        self.mainRadius = ISMainCircleMaxRadius-pow(((self.distance)/self.maxDistance), 1.1)*(ISMainCircleMaxRadius-ISMainCircleMinRadius);
        self.subRadius  = ISSubCircleMaxRadius-pow(((self.distance)/self.maxDistance), 1.3)*(ISSubCircleMaxRadius-ISSubCircleMinRadius);
    }
    
    self.imageView.frame = CGRectMake(0, 0, self.mainRadius*2-5, self.mainRadius*2-5);
    self.imageView.center = CGPointMake(self.frame.size.width/2.f, self.mainRadius-2.f + self.distance * 0.03 + 3.25f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0.f, 25.f);
    CGPathAddArcToPoint(path, NULL,
                        0.f, 0.f,
                        self.mainRadius, 0.f,
                        self.mainRadius);
    
    CGPathAddArcToPoint(path, NULL,
                        self.mainRadius*2.f, 0.f,
                        self.mainRadius*2.f, self.mainRadius,
                        self.mainRadius);

    CGPathAddCurveToPoint(path, NULL,
                          self.mainRadius*2.f,            self.mainRadius*2.f,
                          self.mainRadius+self.subRadius, self.mainRadius*2.f,
                          self.mainRadius+self.subRadius, self.distance+self.mainRadius);
    
    CGPathAddArcToPoint(path, NULL,
                        self.mainRadius+self.subRadius, self.distance+self.mainRadius+self.subRadius,
                        self.mainRadius,                self.distance+self.mainRadius+self.subRadius,
                        self.subRadius);
    
    CGPathAddArcToPoint(path, NULL,
                        self.mainRadius-self.subRadius, self.distance+self.mainRadius+self.subRadius,
                        self.mainRadius-self.subRadius, self.distance+self.mainRadius,
                        self.subRadius);
    
    CGPathAddCurveToPoint(path, NULL,
                          self.mainRadius-self.subRadius, self.mainRadius*2.f,
                          0.f, self.mainRadius*2.f,
                          0.f, self.mainRadius);

    CGPathCloseSubpath(path);
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(self.frame.size.width/2.f - self.mainRadius,
                                                                   3.f);
    CGMutablePathRef offsetPath = CGPathCreateMutable();
    CGPathAddPath(offsetPath, &transform, path);
    
    CGContextAddPath(context, offsetPath);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:.607f green:.635f blue:.670f alpha:1.f].CGColor);
    CGContextSetShadow(context, CGSizeMake(0.f, .5f), 1.f);
    CGContextFillPath(context);
    CGPathRelease(path);
    CGPathRelease(offsetPath);
}

@end
