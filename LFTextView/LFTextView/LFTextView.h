//
//  LFTextView.h
//  LFTextView
//
//  Created by FFFF on 16/5/17.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFPicker.h"
#import "LFArea.h"
#import "LFCityModel.h"
@class LFTextView;
typedef NS_ENUM(NSInteger, LFInputType) {
    LFInputTypeTextFeild = 0, //普通文字输入
    LFInputTypePhoneTextFeild = 1, // 手机号输入
    LFInputTypeBankCardTextFeild = 2, // 银行卡输入
    LFInputTypeCardTextFeild = 3, // 身份证号输入
    LFInputTypeDefaultPicker = 4, // 普通选择框
    LFInputTypeDatePicker = 5, // 日期选择期
    LFInputTypeAreaPicker = 6 // 区域选择器
};

@protocol LFTextViewDelegate <NSObject>

@optional

- (BOOL)ptTextFieldShouldReturn:(UITextField *)textField;
- (BOOL)ptTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)ptTextFieldDidEndEditing:(UITextField *)textField;
- (void)ptTextFieldDidBeginEditing:(UITextField *)textField;
- (void)ptPassArea:(LFArea *)area With:(LFTextView*)textView;
- (void)ptPassPicker:(LFPicker *)Picker With:(LFTextView*)textView;
@end
@interface LFTextView : UIView{
@private
    NSArray *provinces;
    NSArray	*cities;
    NSArray	*counties;
}

@property (nonatomic,weak) id <LFTextViewDelegate>delegate;
@property(strong,nonatomic,readwrite) UIToolbar *inputAccessoryView;
@property (nonatomic,weak) UITextField *textFeild;
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UIImageView *tipView;
@property (nonatomic,weak) UIImageView *arrowView;
@property (nonatomic,weak) UIPickerView *pickerView;
@property (nonatomic,weak) UIDatePicker *datePickerView;
@property (nonatomic,assign) BOOL required;
@property (nonatomic,strong) NSArray *dataSource; // 普通选择器
@property (nonatomic,assign) LFInputType inputType;
@property (nonatomic,strong) LFPicker *picker;
@property (nonatomic,strong) LFArea *area;
@property (nonatomic,weak) UIView *lineView;

+ (instancetype)textViewWithInputType:(LFInputType )type frame:(CGRect)frame required:(BOOL)isRequired;


@end
