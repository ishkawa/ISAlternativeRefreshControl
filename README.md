a template for creating custom UIRefreshControl.

NOTE: If you would like to use the clone of UIRefreshControl on iOS 5, use [ISRefreshControl](https://github.com/ishkawa/ISRefreshControl).

## Requirements

iOS 4.3 or later

## Installing

Add files under `ISAlternativeRefreshControl/` to your project.

## Usage 

-  make a subclass of ISAlternativeRefreshControl.
- override following methods to express custom behavior of your UIRefreshControl.

```objectivec
- (void)willChangeProgress:(CGFloat)progress;
- (void)didChangeProgress;
- (void)willChangeRefreshingState:(ISRefreshingState)refreshingState;
- (void)didChangeRefreshingState;
```

for example,

```objectivec
- (void)didChangeProgress
{
    if (self.refreshingState == ISRefreshingStateNormal) {
        // rotate image using the progress of pullToRefresh.
        self.imageView.transform = CGAffineTransformMakeRotation(-M_PI * self.progress);
    }
}

- (void)willChangeRefreshingState:(ISRefreshingState)refreshingState
{
    switch (refreshingState) {
        case ISRefreshingStateRefreshing:
            [self.indicatorView startAnimating];
            break;
            
        case ISRefreshingStateRefreshed:
            [self.indicatorView stopAnimating];
            break;
            
        default: break;
    }
}
```

- configure target and action. (typically, is the UIViewController.)

```objectivec
self.arrowRefreshControl = [[ISArrowRefreshControl alloc] init];
self.arrowRefreshControl.frame = CGRectMake(0.f, 0.f, 320.f, 50.f);
[self.arrowRefreshControl addTarget:self
                   action:@selector(refresh)
         forControlEvents:UIControlEventValueChanged];
```

- add your custom UIRefreshControl to UIScrollView.

```objectivec
[self.tableView addSubview:self.arrowRefreshControl];
```


## Example

see classes below. The demo app contains them.

- [ISArrowRefreshControl](https://github.com/ishkawa/ISAlternativeRefreshControl/blob/master/DemoApp/ISArrowRefreshControl.m)(custom UIRefreshControl)
- [ISArrowViewConroller](https://github.com/ishkawa/ISAlternativeRefreshControl/blob/master/DemoApp/ISArrowViewController.m)(demo UIViewController).

## License

Copyright (c) 2013 Yosuke Ishikawa

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
