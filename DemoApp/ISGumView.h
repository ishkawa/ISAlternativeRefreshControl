#import <UIKit/UIKit.h>

@interface ISGumView : UIView

@property (nonatomic, readonly) CGFloat maxDistance;
@property (nonatomic) CGFloat distance;

- (void)shrink;

@end
