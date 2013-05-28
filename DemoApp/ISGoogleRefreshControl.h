#import "ISAlternativeRefreshControl.h"

@class ISGoogleIndicatorView;

@interface ISGoogleRefreshControl : ISAlternativeRefreshControl

@property (nonatomic, strong) ISGoogleIndicatorView *indicatorView;
@property (nonatomic, strong) UIImageView *imageView;

@end
