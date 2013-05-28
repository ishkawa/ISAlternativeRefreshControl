#import <UIKit/UIKit.h>

@class ISGumRefreshControl;

@interface ISGumViewController : UITableViewController

@property (nonatomic, strong) ISGumRefreshControl *gumRefreshControl;
@property (nonatomic, strong) NSArray *strings;

@end
