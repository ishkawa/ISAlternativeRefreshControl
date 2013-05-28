#import "ISGoogleIndicatorView.h"

@implementation ISGoogleIndicatorView

- (void)startAnimating
{
    self.hidden = NO;
    self.backgroundColor = [UIColor clearColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.2
                                                  target:self
                                                selector:@selector(updateColor)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopAnimating
{
    self.hidden = YES;
    [self.timer invalidate];
}

- (void)updateColor
{
    self.colorIndex = (self.colorIndex + 1) % 4;
    
    UIColor *color;
    switch (self.colorIndex) {
        case 0: color = [UIColor redColor];    break;
        case 1: color = [UIColor yellowColor]; break;
        case 2: color = [UIColor greenColor];  break;
        case 3: color = [UIColor blueColor];   break;
    }
    
    self.backgroundColor = color;
}

@end
