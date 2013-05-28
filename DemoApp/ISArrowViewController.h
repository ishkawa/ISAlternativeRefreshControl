#import <UIKit/UIKit.h>

@class ISArrowRefreshControl;

@interface ISArrowViewController : UITableViewController

@property (nonatomic, strong) ISArrowRefreshControl *arrowRefreshControl;
@property (nonatomic, strong) NSArray *strings;

@end
