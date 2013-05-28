#import <UIKit/UIKit.h>

@interface ISGumView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) CGFloat maxDistance;
@property (nonatomic) CGFloat distance;
@property (nonatomic) CGFloat mainRadius;
@property (nonatomic) CGFloat subRadius;
@property (nonatomic) BOOL shrinking;

- (void)shrink;

@end
