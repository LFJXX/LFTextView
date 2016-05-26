//
//  ViewController.m
//  LFTextView
//
//  Created by FFFF on 16/5/16.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import "ViewController.h"
#import "LFTextView.h"
@interface ViewController ()
@property (nonatomic,weak) LFTextView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LFTextView *titleView = [[LFTextView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 40)];
    titleView.titleLable.text = @"联系人电话号码:";
    titleView.textFeild.placeholder = @"请输入电话号码";
    titleView.inputType = LFInputTypeAreaPicker;
//    titleView.inputType = LFInputTypeDefaultPicker;
    self.titleView = titleView;
    [self.view addSubview:titleView];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<10; i++) {
        LFPicker *picker = [[LFPicker alloc] init];
        picker.value = [NSString stringWithFormat:@"%d",i];
        picker.text = [NSString stringWithFormat:@"测试---%d",i];
        [array addObject:picker];
    }
    titleView.dataSource = array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
