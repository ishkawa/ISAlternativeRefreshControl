#import <UIKit/UIKit.h>

@class ISAlternativeRefreshControl;

@interface ISEmptyViewController : UITableViewController

@property (nonatomic, strong) ISAlternativeRefreshControl *alternativeRefreshControl;
@property (nonatomic, strong) NSArray *strings;

@end
