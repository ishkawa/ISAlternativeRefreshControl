#import "ISAppDelegate.h"
#import "ISTabBarController.h"

@implementation ISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ISTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
