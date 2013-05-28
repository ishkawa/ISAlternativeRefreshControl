#import <UIKit/UIKit.h>

@class ISGoogleRefreshControl;

@interface ISGoogleViewController : UITableViewController

@property (nonatomic, strong) ISGoogleRefreshControl *googleRefreshControl;
@property (nonatomic, strong) NSArray *strings;

@end
