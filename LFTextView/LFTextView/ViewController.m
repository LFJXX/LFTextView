//
//  ViewController.m
//  LFTextView
//
//  Created by FFFF on 16/5/16.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import "ViewController.h"
#import "LFTextView.h"
@interface ViewController ()<LFTextViewDelegate>
@property (nonatomic,weak) LFTextView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LFTextView *titleView2 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 40)];
    titleView2.caption = @"联系人姓名:";
    titleView2.placeholder = @"请输入联系人姓名";
    titleView2.inputType = LFInputTypeTextFeild;
    self.titleView = titleView2;
    titleView2.required = NO;
    [self.view addSubview:titleView2];
   
    
    LFTextView *titleView3 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 40)];
    titleView3.caption = @"联系人电话号码:";
    titleView3.placeholder = @"请输入联系人电话号码";
    titleView3.inputType = LFInputTypePhoneTextFeild;
    self.titleView = titleView3;
    [self.view addSubview:titleView3];
   
    LFTextView *titleView4 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 40)];
    titleView4.caption = @"家庭住址:";
    titleView4.caption_font = [UIFont systemFontOfSize:18];
    titleView4.inputText_font = [UIFont systemFontOfSize:18];
    titleView4.placeholder = @"请选择联系人家庭住址";
    titleView4.delegate = self;
    titleView4.inputType = LFInputTypeAreaPicker;
    self.titleView = titleView4;
    [self.view addSubview:titleView4];
    
    LFTextView *titleView5 = [LFTextView textViewWithInputType:LFInputTypeCardTextFeild  frame:CGRectMake(0, 200, self.view.bounds.size.width, 40) required:NO];
    titleView5.caption = @"身份证号码:";
    titleView5.placeholder = @"请输入身份证号码";
    titleView5.captionColor = [UIColor redColor];
    titleView5.inputTextColor_disable = [UIColor greenColor];
    titleView5.isEnable = NO;
    titleView5.inputText = @"4444444";
    self.titleView = titleView5;
    [self.view addSubview:titleView5];
    
    LFTextView *titleView6 = [LFTextView textViewWithInputType:LFInputTypeBankCardTextFeild  frame:CGRectMake(0, 250, self.view.bounds.size.width, 40) required:NO];
    titleView6.caption = @"银行卡号码:";
    titleView6.placeholder = @"请输入银行卡号码号码";
    titleView6.inputTextColor_normal = [UIColor yellowColor];
    self.titleView = titleView6;
    [self.view addSubview:titleView6];
    
    LFTextView *titleView = [[LFTextView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 40)];
    titleView.caption = @"测试一:";
    titleView.placeholder = @"测试结果";
    titleView.delegate = self;
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
    
    
    LFTextView *titleView1 = [[LFTextView alloc] initWithFrame:CGRectMake(0, 350, self.view.bounds.size.width, 40)];
    titleView1.caption = @"日期:";
    titleView1.placeholder = @"点击选择";
    titleView1.inputType = LFInputTypeDatePicker;
    titleView1.required = YES;
    self.titleView = titleView1;
    [self.view addSubview:titleView1];
    
}

- (void)ptPassArea:(LFArea *)area With:(LFTextView *)textView{

    NSLog(@"区域%@--%@--%@",area.state,area.city,area.country);
}

- (void)ptPassPicker:(LFPicker *)Picker With:(LFTextView *)textView{

    NSLog(@"普通选择%@--%@",Picker.value,Picker.text);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
