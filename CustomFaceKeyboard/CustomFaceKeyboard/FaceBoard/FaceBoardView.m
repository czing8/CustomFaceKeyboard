//
//  FaceBoardView.m
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "FaceBoardView.h"

@implementation FaceBoardView 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.912 alpha:1.000];
        [self addSubview:self.inputView];
        
        [self.inputView addSubview:self.sendButton];
        [self.inputView addSubview:self.inputTextField];
        
        
        // default inputType
        _inputType = FaceboardInputTypeCharacter;
        _isFirstShowKeyboard = YES;
        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(kSCREEN_WIDTH - 40, 7, 28, 28);
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"expression"] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendButton;
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.frame = CGRectMake(10, 10, kSCREEN_WIDTH - 60, 24);
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}


- (UIView *)inputView{
    if (!_inputView) {
        _inputView = [[UIView alloc] init];
        _inputView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 44);
        _inputView.backgroundColor = [UIColor colorWithWhite:0.751 alpha:1.000];
    }
    return _inputView;
}

- (void)sendAction:(UIButton *)button{

    _inputType = FaceboardInputTypeEmotion;
    [_inputTextField resignFirstResponder];
}


#pragma mark keyboardNotification

- (void)keyboardWillShow:(NSNotification*)notification{
    
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (_isFirstShowKeyboard) {
        [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                        self.frame = CGRectMake(0, kSCREEN_HEIGHT - keyboardRect.size.height - 44, kSCREEN_WIDTH, keyboardRect.size.height + 44);
                         
                     } completion:^(BOOL finished) {
                         _isFirstShowKeyboard = NO;
                     }];
    }
}


- (void)keyboardWillHide:(NSNotification*)notification{

    if (_isHideKeyboard) {
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.frame = CGRectMake(0, kSCREEN_HEIGHT - 44, kSCREEN_WIDTH, 44);
                             
                         } completion:^(BOOL finished) {
                             _isHideKeyboard = NO;
                             _isFirstShowKeyboard = YES;
                         }];
    }
}


#pragma mark - textfieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _inputType = FaceboardInputTypeCharacter;
    return YES;
}



- (void)resignFaceboard{
    _isHideKeyboard = YES;
    
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
