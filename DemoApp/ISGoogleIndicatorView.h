#import <UIKit/UIKit.h>

@interface ISGoogleIndicatorView : UIView

@property (nonatomic) NSInteger colorIndex;
@property (nonatomic) NSTimer *timer;

- (void)startAnimating;
- (void)stopAnimating;

@end
