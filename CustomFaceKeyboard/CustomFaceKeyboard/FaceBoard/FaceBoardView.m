//
//  FaceBoardView.m
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "FaceBoardView.h"
#import "EmotionButton.h"

#define KEYBOARD_HEIGHT  216

@implementation FaceBoardView 

- (void)dealloc{
    _faceMap = nil;
    _inputTextView = nil;
    _faceView = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.912 alpha:1.000];
        [self addSubview:self.inputView];
        
        [self.inputView addSubview:self.emotionButton];
        [self.inputView addSubview:self.inputTextView];
        
        
        // default inputType
        _inputType = FaceboardInputTypeCharacter;
        _isFirstShowKeyboard = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        if ([[languages objectAtIndex:0] hasPrefix:@"zh"]) {
            _faceMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_ch" ofType:@"plist"]];
        } else {
            _faceMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"faceMap_en" ofType:@"plist"]];
        }

    }
    return self;
}

- (UIView *)inputView{
    if (!_inputView) {
        _inputView = [[UIView alloc] init];
        _inputView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 44);
        _inputView.backgroundColor = [UIColor colorWithWhite:0.751 alpha:1.000];
    }
    return _inputView;
}

- (UIButton *)emotionButton{
    if (!_emotionButton) {
        _emotionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emotionButton.frame = CGRectMake(kSCREEN_WIDTH - 40, 7, 28, 28);
        [_emotionButton setBackgroundImage:[UIImage imageNamed:@"expression"] forState:UIControlStateNormal];
        [_emotionButton addTarget:self action:@selector(pressEmotionAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _emotionButton;
}

- (UITextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.frame = CGRectMake(10, 7, kSCREEN_WIDTH - 60, 30);
        _inputTextView.backgroundColor = [UIColor whiteColor];
        _inputTextView.delegate = self;
        
        _inputTextView.layer.cornerRadius = 6;
        _inputTextView.layer.masksToBounds = YES;
    }
    return _inputTextView;
}

- (UIScrollView *)faceView{
    if (!_faceView) {
        _faceView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, 216)];
        _faceView.pagingEnabled = YES;
        _faceView.contentSize = CGSizeMake((85/28+1)*320, 216);
        _faceView.showsHorizontalScrollIndicator = NO;
        _faceView.showsVerticalScrollIndicator = NO;
        _faceView.delegate = self;
//        _faceView.backgroundColor = [UIColor orangeColor];
        [self displayFaceView];
    }
    
    return _faceView;
}

- (GrayPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[GrayPageControl alloc]initWithFrame:CGRectMake(110, 220, 100, 20)];
        [_pageControl addTarget:self
                            action:@selector(pageChange:)
                  forControlEvents:UIControlEventValueChanged];
        
        _pageControl.numberOfPages = 85/28+1;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (void)displayFaceView{
    for (int i = 0; i< 85; i++) {
        EmotionButton *faceButton = [EmotionButton buttonWithType:UIButtonTypeCustom];
        faceButton.buttonIndex = i+1;
        
        [faceButton addTarget:self
                       action:@selector(pressFaceButton:)
             forControlEvents:UIControlEventTouchUpInside];
        
        //计算每一个表情按钮的坐标和在哪一屏
        faceButton.frame = CGRectMake(((i%27)%7)*44+6+(i/27*320), ((i%27)/7)*44+8, 44, 44);
        
        [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%03d",i+1]] forState:UIControlStateNormal];
        [_faceView addSubview:faceButton];
    
        if (i%27 == 0) {
            UIButton * delButton = [self buttonWithFrame:CGRectMake(270 + (i/27*320), 150, 38, 27)];
            [_faceView addSubview:delButton];
        }
    }
}

- (UIButton *)buttonWithFrame:(CGRect)frame{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:@"del_emoji_normal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"del_emoji_select"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(deleteEmotion:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


#pragma mark - actions

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_pageControl setCurrentPage:_faceView.contentOffset.x/320];
    [_pageControl updateCurrentPageDisplay];
}


- (void)pageChange:(id)sender {
    [_faceView setContentOffset:CGPointMake(_pageControl.currentPage*320, 0) animated:YES];
    [_pageControl setCurrentPage:_pageControl.currentPage];
}

- (void)pressEmotionAction:(UIButton *)button{
    _inputType = FaceboardInputTypeEmotion;
    [_inputTextView resignFirstResponder];
    
    if (_isFirstShowKeyboard) {
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.frame = CGRectMake(0, kSCREEN_HEIGHT - KEYBOARD_HEIGHT - 44, kSCREEN_WIDTH, KEYBOARD_HEIGHT + 44);
                             
                         } completion:^(BOOL finished) {
                             _isFirstShowKeyboard = NO;
                         }];
    }
    
    [self addSubview:self.faceView];
    [self addSubview:self.pageControl];
}

- (void)pressFaceButton:(UIButton *)button{
    int i = ((EmotionButton*)button).buttonIndex;
    
    if (self.inputTextView) {
        NSMutableString *faceString = [[NSMutableString alloc]initWithString:self.inputTextView.text];
        [faceString appendString:[_faceMap objectForKey:[NSString stringWithFormat:@"%03d",i]]];
        self.inputTextView.text = faceString;
    }
}


- (void)deleteEmotion:(UIButton *)button{
    NSString *inputString;
    if (self.inputTextView) {
        inputString = self.inputTextView.text;
    }
    
    NSString *string = nil;
    NSInteger stringLength = inputString.length;
    if (stringLength > 0) {
        if ([@"]" isEqualToString:[inputString substringFromIndex:stringLength-1]]) {
            if ([inputString rangeOfString:@"["].location == NSNotFound){
                string = [inputString substringToIndex:stringLength - 1];
            } else {
                string = [inputString substringToIndex:[inputString rangeOfString:@"[" options:NSBackwardsSearch].location];
            }
        } else {
            string = [inputString substringToIndex:stringLength - 1];
        }
    }
    self.inputTextView.text = string;
}

#pragma mark keyboardNotification

- (void)keyboardWillShow:(NSNotification*)notification{
    if (_isFirstShowKeyboard) {
        [self animationWithShowKeyboard];
    }
}


- (void)keyboardWillHide:(NSNotification*)notification{

    if (_isHideKeyboard) {
        [self animationWithHideKeyboard];
    }
}


#pragma mark - animation
- (void)animationWithShowKeyboard{
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = CGRectMake(0, kSCREEN_HEIGHT - KEYBOARD_HEIGHT - 44, kSCREEN_WIDTH, KEYBOARD_HEIGHT + 44);
                         
                     } completion:^(BOOL finished) {
                         _isFirstShowKeyboard = NO;
                     }];

}

- (void)animationWithHideKeyboard{
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


#pragma mark - textViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _inputType = FaceboardInputTypeCharacter;
    return YES;
}


- (void)resignFaceboard{
    _isHideKeyboard = YES;
    
    if (_inputType == FaceboardInputTypeEmotion) {
        [self animationWithHideKeyboard];
    }
    else
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
