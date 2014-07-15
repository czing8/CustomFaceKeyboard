//
//  FaceBoardView.h
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrayPageControl.h"

typedef NS_ENUM(NSUInteger, FaceboardInputType) {
    FaceboardInputTypeCharacter,
    FaceboardInputTypeEmotion,
};

@interface FaceBoardView : UIView <UITextViewDelegate>

@property (nonatomic, strong) UIButton * emotionButton;

/**
 *  输入控件，可用UITextField、UITextView， the better is UITextView, 分行。
 */
//@property (nonatomic, strong) UITextField * inputTextField;

@property (nonatomic, strong) UITextView * inputTextView;

@property (nonatomic, strong) UIView * inputView;
@property (nonatomic, assign) FaceboardInputType inputType;

@property (nonatomic, strong) UIScrollView * faceView;
@property (nonatomic, strong) GrayPageControl * pageControl;

@property (nonatomic, strong) NSDictionary * faceMap;

@property (nonatomic, assign) BOOL isFirstShowKeyboard;
@property (nonatomic, assign) BOOL isHideKeyboard;


- (void)resignFaceboard;

@end
