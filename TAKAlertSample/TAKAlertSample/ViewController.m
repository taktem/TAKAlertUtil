//
//  ViewController.m
//  TAKAlertSample
//
//  Created by 西村 拓 on 2015/07/27.
//  Copyright (c) 2015年 TakuNishimura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) int selectedIndex;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showButtonTapped:(UIButton *)sender {
    @weakify(self)
    [[TAKAlertUtil showWithTitle:@"Title"
                        message:@"Message Test"
                   buttonTitles:@[@"Cancel",@"OK"]] subscribeNext:^(id x) {
        @strongify(self)
        
        if ([x intValue] > 0) {
            self.resultLabel.text = @"OK";
        } else {
            self.resultLabel.text = @"Cancel";
        }
    }];
}

@end
