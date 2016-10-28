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
/** 普通输入框 */
- (BOOL)ptTextFieldShouldReturn:(UITextField *)textField;
- (BOOL)ptTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)ptTextFieldDidEndEditing:(UITextField *)textField;
- (void)ptTextFieldDidBeginEditing:(UITextField *)textField;

/** 区域选择器选择 */
- (void)ptPassArea:(LFArea *)area With:(LFTextView*)textView;

/** 普通选择器选择 */
- (void)ptPassPicker:(LFPicker *)Picker With:(LFTextView*)textView;
@end

@interface LFTextView : UIView
@property (nonatomic,weak) id <LFTextViewDelegate>delegate;

@property (nonatomic,weak) UITextField *textFeild;


/** 是否必填 */
@property (nonatomic,assign) BOOL required;

/** 普通选择器数据源 */
@property (nonatomic,strong) NSArray *dataSource;


/** 输入类型 */
@property (nonatomic,assign) LFInputType inputType;

/** 是否有底部分割线 */
@property (nonatomic,assign) BOOL hasBottomLine;


/** 标题 */
@property (nonatomic,copy) NSString *caption;


/** 输入框文字 */
@property (nonatomic,copy) NSString *inputText;

/** 是否可编辑 */
@property (nonatomic,assign) BOOL isEnable;

/** 标题颜色 */
@property (nonatomic,strong) UIColor *captionColor;

/** 输入框文字颜色,可编辑状态下 */
@property (nonatomic,strong) UIColor *inputTextColor_normal;


/** 输入框文字颜色,不可编辑状态下 */
@property (nonatomic,strong) UIColor *inputTextColor_disable;

/** 占位符 */
@property (nonatomic,copy) NSString *placeholder;

/** 标题字体  */
@property (nonatomic,strong) UIFont *caption_font;

/** 输入框字体 */
@property (nonatomic,strong) UIFont *inputText_font;

+ (instancetype)textViewWithInputType:(LFInputType )type frame:(CGRect)frame required:(BOOL)isRequired;


@end
