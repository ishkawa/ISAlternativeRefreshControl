#import "ISAlternativeRefreshControl.h"

@class ISScalingActivityIndicatorView;
@class ISGumView;

@interface ISGumRefreshControl : ISAlternativeRefreshControl

@property (nonatomic, strong) ISScalingActivityIndicatorView *indicatorView;
@property (nonatomic, strong) ISGumView *gumView;

@end
