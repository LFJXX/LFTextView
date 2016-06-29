//
//  LFTextView.m
//  LFTextView
//
//  Created by FFFF on 16/5/17.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import "LFTextView.h"

#define LFTitleLableMaxWidth   80 //titlelable的宽度
@interface LFTextView ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>



@end

@implementation LFTextView

- (instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        [self setUpUI];
        [self initData];
       
    }
    return self;
}

+ (instancetype)textViewWithInputType:(LFInputType)type frame:(CGRect)frame required:(BOOL)isRequired{

    LFTextView *textV = [[LFTextView alloc] initWithFrame:frame];
    textV.inputType = type;
    textV.required = isRequired;
    return textV;
}
- (void)setUpUI{

    UITextField *textView = [[UITextField alloc] init];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.textAlignment = NSTextAlignmentCenter;
    self.textFeild = textView;
    [self addSubview:textView];
    
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.numberOfLines = 0;
    titleLable.textColor = [UIColor grayColor];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable = titleLable;
//    titleLable.backgroundColor = [UIColor yellowColor];
    [self addSubview:titleLable];

    UIImageView *tipView = [[UIImageView alloc] init];
    self.tipView = tipView;
    tipView.image = [UIImage imageNamed:@"tip"];
    [self addSubview:tipView];
    
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    UIImageView *arrowView = [[UIImageView alloc] init];
    arrowView.image = [UIImage imageNamed:@"pickArrow"];
    self.arrowView = arrowView;
    self.arrowView.hidden = YES;
    [self addSubview:arrowView];
    

    
}


- (void)setInputType:(LFInputType)inputType{

    _inputType = inputType;
 
    if (self.inputType == LFInputTypeDefaultPicker ) {
        [self initPicker];
        self.arrowView.hidden = NO;
        
    }else if(self.inputType == LFInputTypeAreaPicker){
        
        [self initPicker];
        [self initData];
        self.arrowView.hidden = NO;
    }else if(self.inputType == LFInputTypePhoneTextFeild){
        
        self.textFeild.delegate = self;
    }else if(self.inputType == LFInputTypeCardTextFeild){
        
        self.textFeild.delegate = self;
    }else if(self.inputType == LFInputTypeDatePicker){
        
        [self initDatePicker];
        self.arrowView.hidden = NO;
        
    }else if (self.inputType == LFInputTypeBankCardTextFeild){
        self.textFeild.delegate = self;
    }else{
        
    }
}

- (void)setRequired:(BOOL)required{

    _required = required;
    if (_required) {
        self.tipView.hidden = NO;
    }else{
    
        self.tipView.hidden = YES;
    }
}
#pragma mark 初始化选择器
- (void)initPicker{
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    self.pickerView = pickerView;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.textFeild.inputView = pickerView;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

- (void)initDatePicker{
    UIDatePicker *pickerView = [[UIDatePicker alloc] init];
    self.datePickerView = pickerView;
    self.datePickerView.backgroundColor = [UIColor whiteColor];
    self.textFeild.inputView = pickerView;
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
    [pickerView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [pickerView setTimeZone:[NSTimeZone localTimeZone]];
    [pickerView setDate:[NSDate date] animated:YES];
    [pickerView addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [pickerView setMaximumDate:[NSDate date]];
    
    
    
    
}


#pragma Mark 初始化地区选择器
- (void)initData{
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citya.plist" ofType:nil]];
    if (provinces.count > 0) {
        
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        counties = [[cities objectAtIndex:0] objectForKey:@"countries"];
        //初始化默认数据
        self.area = [[LFArea alloc] init];
        
        self.area.state = [[provinces objectAtIndex:0] objectForKey:@"stateName"];
        self.area.stateCode = [[provinces objectAtIndex:0] objectForKey:@"stateCode"];
        
        self.area.city = [[cities objectAtIndex:0] objectForKey:@"cityName"];
        self.area.cityCode = [[cities objectAtIndex:0] objectForKey:@"cityCode"];
        
        self.area.country = [[counties objectAtIndex:0] objectForKey:@"cityName"];
        self.area.countryCode = [[counties objectAtIndex:0] objectForKey:@"cityCode"];
    }
}
- (void)layoutSubviews{

    [super layoutSubviews];
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height;
    CGFloat tipViewWH = 5;
    CGFloat tipviewY = (H - tipViewWH)*0.5;
    CGFloat marginX = 10;
    self.tipView.frame = CGRectMake(marginX*0.5, tipviewY, tipViewWH, tipViewWH);
    
    self.titleLable.frame = CGRectMake(CGRectGetMaxX(self.tipView.frame)+marginX*0.5, 0, LFTitleLableMaxWidth, H);
    self.textFeild.frame = CGRectMake(CGRectGetMaxX(self.titleLable.frame)+marginX, 0, W-marginX-CGRectGetMaxX(self.titleLable.frame)- marginX, H);
    self.lineView.frame = CGRectMake(marginX*1.5, H-1, W - 2.5*marginX, 1);
}

#pragma mark UIPickerViewDelegate,UIPickerViewDataSource

- (UIToolbar *)inputAccessoryView
{
    if (self.inputType == LFInputTypeDefaultPicker || self.inputType == LFInputTypeAreaPicker || self.inputType == LFInputTypeDatePicker){
        
        if(!_inputAccessoryView)
        {
            NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:7];
            UIToolbar *toolBar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
            
            UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(backPickViewconfirm)];
            [buttons addObject:left];
            
            for (int i = 0; i < 5; i++) {
                
                UIBarButtonItem *SpaceButton = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                [buttons addObject:SpaceButton];
            }
            
            UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backPickView)];
            [buttons addObject:right];
            toolBar1.items = buttons;
            return toolBar1;
        }
    }
    
    return _inputAccessoryView;
}

#pragma mark 确定和取消时间
- (void)backPickViewconfirm{
    switch (self.inputType) {
        case LFInputTypeDefaultPicker:
        {
            LFPicker *picker = [_dataSource objectAtIndex:[_pickerView selectedRowInComponent:0]];
            self.picker = picker;
            self.textFeild.text = picker.text;
            
            if ( self.delegate && [self.delegate respondsToSelector:@selector(ptPassPicker:With:)]) {
                [self.delegate ptPassPicker:self.picker With:self];
            }

            
            [self.textFeild resignFirstResponder];
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
        
        }
            
            break;
         case LFInputTypeAreaPicker:
        {
        
            self.textFeild.text = [NSString stringWithFormat:@"%@%@%@",self.area.state,self.area.city,self.area.country];
            
            if ( self.delegate && [self.delegate respondsToSelector:@selector(ptPassArea:With:)]) {
                [self.delegate ptPassArea:self.area With:self];
            }
            
            [self.textFeild resignFirstResponder];
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
            [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
            [self pickerView:self.pickerView didSelectRow:0 inComponent:1];
          
            
        }
            break;
            case LFInputTypeDatePicker:
        {
            NSDate *date = self.datePickerView.date;
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            formater.dateFormat = @"yyyy-MM-dd";
            self.textFeild.text = [formater stringFromDate:date];
  
            [self endEditing:NO];
            
        }
            break;

        default:
            break;
    }
    
}
- (void)backPickView
{
    switch (self.inputType) {
        case LFInputTypeDefaultPicker:
        {
            [self.textFeild resignFirstResponder];
            self.textFeild.text = @"";
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
            
        }
            
            break;
        case LFInputTypeAreaPicker:
        {
            
            [self.textFeild resignFirstResponder];
            self.textFeild.text = @"";
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
            [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
            [self pickerView:self.pickerView didSelectRow:0 inComponent:1];
            
            
        }
            break;
        case LFInputTypeDatePicker:
        {
            
            [self.textFeild resignFirstResponder];
            self.textFeild.text = @"";
            
            
            
        }
            break;
        default:
            break;
    }

    
}

- (void)datePickerValueChanged:(UIDatePicker *)datepicker{
    
    NSDate *date = datepicker.date;
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy/MM/dd";
    self.textFeild.text = [formater stringFromDate:date];
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    switch (self.inputType) {
        case LFInputTypeDefaultPicker:
        {
        
            return 1;
        }
            break;
         case LFInputTypeAreaPicker:
        {
        
            return 3;
        }
        default:
            break;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.inputType == LFInputTypeDefaultPicker) {
        
        return _dataSource == nil? 0 : [_dataSource count];
    }else{
    
        switch (component) {
            case 0:
                return [provinces count];
                break;
            case 1:
                return [cities count];
                break;
            case 2:
                return [counties count];
                break;
            default:
                return 0;
                break;
        }
 
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.inputType == LFInputTypeDefaultPicker) {
        
        if (_dataSource == nil) {
            
            return @"";
        }
        
        LFPicker *picker = [_dataSource objectAtIndex:row];
        return picker.text;
    }else{
    
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"stateName"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"cityName"];
                break;
                
            case 2:
                return [[counties objectAtIndex:row] objectForKey:@"cityName"] ;
                break;
            default:
                return nil;
                break;
        }


        
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.inputType == LFInputTypeDefaultPicker) {
    
        if (_dataSource == nil) {
            
            return;
        }
        
        LFPicker *picker = [_dataSource objectAtIndex:row];
        self.picker = picker;
        self.textFeild.text = picker.text;
        
    }else{
    
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                counties = [[cities objectAtIndex:0] objectForKey:@"countries"];
                [self.pickerView selectRow:0 inComponent:1 animated:NO];
                [self.pickerView reloadComponent:1];
                [self.pickerView reloadComponent:2];
                
                self.area.state = [[provinces objectAtIndex:row] objectForKey:@"stateName"];
                self.area.stateCode = [[provinces objectAtIndex:row] objectForKey:@"stateCode"];
                self.area.city = [[cities objectAtIndex:0] objectForKey:@"cityName"];
                self.area.cityCode = [[cities objectAtIndex:0] objectForKey:@"cityCode"];
                self.area.country = [[counties objectAtIndex:0] objectForKey:@"cityName"];
                self.area.countryCode = [[counties objectAtIndex:0] objectForKey:@"cityCode"];
                break;
            case 1:
                counties = [[cities objectAtIndex:row] objectForKey:@"countries"];
                [self.pickerView selectRow:0 inComponent:2 animated:NO];
                [self.pickerView reloadComponent:2];
                self.area.city = [[cities objectAtIndex:row] objectForKey:@"cityName"] ;
                self.area.cityCode = [[cities objectAtIndex:row] objectForKey:@"cityCode"] ;
                self.area.country = [[counties objectAtIndex:0] objectForKey:@"cityName"] ;
                self.area.countryCode = [[counties objectAtIndex:0] objectForKey:@"cityCode"];
                break;
            case 2:
                self.area.country = [[counties objectAtIndex:row] objectForKey:@"cityName"];
                self.area.countryCode = [[counties objectAtIndex:row] objectForKey:@"cityCode"];
                break;
            default:
                break;
        }

    }
  
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(ptTextField:shouldChangeCharactersInRange:replacementString:)]) {
        [self.delegate ptTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return [self validateString:string textField:textField CharactersInRange:range];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.textFeild resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(ptTextFieldShouldReturn:)]) {
        [self.delegate ptTextFieldShouldReturn:textField];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.textFeild resignFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(ptTextFieldDidEndEditing:)]) {
        [self.delegate ptTextFieldDidEndEditing:textField];
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if ([self.delegate respondsToSelector:@selector(ptTextFieldDidBeginEditing:)]) {
        [self.delegate ptTextFieldDidBeginEditing:textField];
    }
}




- (BOOL)validateString:(NSString*)string textField:(UITextField *)textField CharactersInRange:(NSRange)range
{
    NSUInteger lengthOfString = string.length;
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
        unichar character = [string characterAtIndex:loopIndex];
        if (self.inputType == LFInputTypePhoneTextFeild) {
            
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
            
            NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
            if (proposedNewLength > 11) return NO;//限制长度
        }else if(self.inputType == LFInputTypeCardTextFeild){
            
            NSLog(@"-----%hu",character);
            if (character < 48) return NO;
            if (character > 57 && character != 88 && character != 120) return NO; // x X unichar for 120  88
            NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
            if (proposedNewLength > 18) return NO;//限制长度
        }else if (self.inputType == LFInputTypeBankCardTextFeild){
            
            NSString *text = textField.text;
            
            NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([string rangeOfCharacterFromSet:[ characterSet invertedSet]].location != NSNotFound) {
                return NO;
            }
            
            text = [text stringByReplacingCharactersInRange:range withString:string];
            text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSString *newString = @"";
            while (text.length > 0) {
                NSString *subString = [text substringToIndex:MIN(text.length, 4)];
                newString = [newString stringByAppendingString:subString];
                if (subString.length == 4) {
                    newString = [newString stringByAppendingString:@" "];
                }
                text = [text substringFromIndex:MIN(text.length, 4)];
            }
            
            newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
            
            if (newString.length >= 24) {
                return NO;
            }
            
            [textField setText:newString];
            return NO;
            
        }
       
        
    }
    
    return YES;
}
@end
