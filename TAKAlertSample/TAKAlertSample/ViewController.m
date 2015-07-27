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
    __weak typeof(self) weakSelf = self;
    [TAKAlertUtil showWithTitle:@"Title"
                        message:@"Message Test"
                   buttonTitles:@[@"Cancel",@"OK"]
                  buttonHandler:^(TAKAlertUtil *alertView, NSInteger index) {
                      if (index > 0) {
                          weakSelf.resultLabel.text = @"OK";
                      } else {
                          weakSelf.resultLabel.text = @"Cancel";
                      }
                  }];
}

@end
