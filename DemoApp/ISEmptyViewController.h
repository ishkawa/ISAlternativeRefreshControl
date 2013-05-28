#import <UIKit/UIKit.h>
#import <ISAlternativeRefreshControl/ISAlternativeRefreshControl.h>

@interface ISEmptyViewController : UITableViewController

@property (nonatomic, strong) ISAlternativeRefreshControl *alternativeRefreshControl;
@property (nonatomic, strong) NSArray *strings;

@end
