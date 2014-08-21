#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ISRefreshingState) {
    ISRefreshingStateNormal,
    ISRefreshingStateRefreshing,
    ISRefreshingStateRefreshed,
};

@interface ISAlternativeRefreshControl : UIControl

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;
@property (nonatomic, readonly) ISRefreshingState refreshingState;
@property (nonatomic, readonly) CGFloat progress;
@property (nonatomic) CGFloat threshold;
@property (nonatomic) CGFloat referenceContentInsetTop;
@property (nonatomic) BOOL firesOnRelease;

#pragma mark - actions

- (void)beginRefreshing;
- (void)endRefreshing;

#pragma mark - events

- (void)willChangeProgress:(CGFloat)progress;
- (void)didChangeProgress;

- (void)willChangeRefreshingState:(ISRefreshingState)refreshingState;
- (void)didChangeRefreshingState;

@end
