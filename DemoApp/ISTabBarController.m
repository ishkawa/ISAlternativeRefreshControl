#import "ISTabBarController.h"
#import "ISGumViewController.h"
#import "ISArrowViewController.h"
#import "ISGoogleViewController.h"

@implementation ISTabBarController

- (id)init
{
    self = [super init];
    if (self) {
        self.viewControllers = @[[self gumViewController],
                                 [self arrowViewController],
                                 [self googleViewController], ];
    }
    return self;
}

#pragma mark - tabs

- (UIViewController *)gumViewController
{
    ISGumViewController *viewController = [[ISGumViewController alloc] init];
    viewController.tabBarItem.title = @"Gum";
    
    return viewController;
}

- (UIViewController *)arrowViewController
{
    ISArrowViewController *viewController = [[ISArrowViewController alloc] init];
    viewController.tabBarItem.title = @"Arrow";
    
    return viewController;
}

- (UIViewController *)googleViewController
{
    ISGoogleViewController *viewController = [[ISGoogleViewController alloc] init];
    viewController.tabBarItem.title = @"Google";
    
    return viewController;
}

@end
