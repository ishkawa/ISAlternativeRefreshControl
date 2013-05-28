#import "ISGumViewController.h"
#import "ISGumRefreshControl.h"

@implementation ISGumViewController

#pragma mark - UIViewController events

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gumRefreshControl = [[ISGumRefreshControl alloc] init];
    self.gumRefreshControl.frame = CGRectMake(0.f, 0.f, 320.f, 50.f);
    [self.gumRefreshControl addTarget:self
                       action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.gumRefreshControl];
}

- (void)viewDidUnload
{
    self.gumRefreshControl = nil;
    
    [super viewDidUnload];
}

#pragma mark -

- (void)refresh
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.gumRefreshControl endRefreshing];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.strings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.strings objectAtIndex:indexPath.row];
    
    return cell;
}

@end
