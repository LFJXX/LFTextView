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

typedef NS_ENUM(NSInteger, LFInputType) {
     LFInputTypeDefault,
     LFInputTypeTextFeild,
     LFInputTypePhoneTextFeild,
    LFInputTypeCardTextFeild,
     LFInputTypeDefaultPicker,
     LFInputTypeAreaPicker,
};
@interface LFTextView : UIView{
@private
    NSArray *provinces;
    NSArray	*cities;
    NSArray	*counties;
}
@property(strong,nonatomic,readwrite) UIToolbar *inputAccessoryView;
@property (nonatomic,weak) UITextField *textFeild;
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UIImageView *tipView;
@property (nonatomic,weak) UIPickerView *pickerView;
@property (nonatomic,assign) BOOL required;
@property (nonatomic,strong) NSArray *dataSource; // 普通选择器
@property (nonatomic,assign) LFInputType inputType;
@property (nonatomic,strong) LFPicker *picker;
@property (nonatomic,strong) LFArea *area;

+ (instancetype)textViewWithInputType:(LFInputType )type frame:(CGRect)frame required:(BOOL)isRequired;
@end
