# TAKAlertUtil
UIAlertViewとUIAlertControllerを、OS判別した上で分岐する

##Installation with CocoaPods
###Podfile
```ruby
pod 'TAKAlertUtil'
```

###Requirements
This is in need of ReactiveCocoa

##Get Started

```objective-c
#import "TAKAlertUtil.h"
```

```objective-c
[[TAKAlertUtil showWithTitle:@"Title"
                     message:@"Alert message"
                buttonTitles:@[@"Cancel",@"OK"]] subscribeNext:^(id x) {
        if ([x intValue] == 0) {
            NSLog(@"Cancel button tapped.");
        } else {
            NSLog(@"OK button tapped.");
        }
    }];
```


License
---

TAKAlertUtil is released under the MIT license. See LICENSE for details.
