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
    titleView.titleLable.text = @"测试一:";
    titleView.textFeild.placeholder = @"测试结果";
    titleView.inputType = LFInputTypeDefaultPicker;
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
    
    
    LFTextView *titleView1 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 40)];
    titleView1.titleLable.text = @"身份证号:";
    titleView1.textFeild.placeholder = @"联系人姓名";
    titleView1.inputType = LFInputTypeCardTextFeild;
    titleView1.required = YES;
    self.titleView = titleView1;
    [self.view addSubview:titleView1];
//    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:0];
//    for (int i = 0; i<10; i++) {
//        LFPicker *picker = [[LFPicker alloc] init];
//        picker.value = [NSString stringWithFormat:@"%d",i];
//        picker.text = [NSString stringWithFormat:@"测试---%d",i];
//        [array1 addObject:picker];
//    }
//    titleView1.dataSource = array1;

    
    LFTextView *titleView2 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 40)];
    titleView2.titleLable.text = @"联系人姓名:";
    titleView2.textFeild.placeholder = @"请输入联系人姓名";
    titleView2.inputType = LFInputTypeTextFeild;
    self.titleView = titleView2;
    titleView2.required = NO;
    [self.view addSubview:titleView2];
   
    
    LFTextView *titleView3 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 250, self.view.bounds.size.width, 40)];
    titleView3.titleLable.text = @"联系人电话号码:";
    titleView3.textFeild.placeholder = @"请输入联系人电话号码";
    titleView3.inputType = LFInputTypePhoneTextFeild;
    self.titleView = titleView3;
    [self.view addSubview:titleView3];
   
    LFTextView *titleView4 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 40)];
    titleView4.titleLable.text = @"家庭住址:";
    titleView4.textFeild.placeholder = @"请选择联系人家庭住址";
    titleView4.inputType = LFInputTypeAreaPicker;
    self.titleView = titleView4;
    [self.view addSubview:titleView4];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
