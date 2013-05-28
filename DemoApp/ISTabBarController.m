#import "ISTabBarController.h"
#import "ISEmptyViewController.h"

@implementation ISTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        self.viewControllers = @[[self emptyViewController]];
    }
    return self;
}

#pragma mark - tabs

- (UIViewController *)emptyViewController
{
    ISEmptyViewController *viewController = [[ISEmptyViewController alloc] init];
    viewController.tabBarItem.title = @"Empty";
    
    return viewController;
}

@end
