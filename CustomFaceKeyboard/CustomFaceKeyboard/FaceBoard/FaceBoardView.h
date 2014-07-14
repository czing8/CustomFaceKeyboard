//
//  FaceBoardView.h
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FaceboardInputType) {
    FaceboardInputTypeCharacter,
    FaceboardInputTypeEmotion,
};

@interface FaceBoardView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIButton * sendButton;
@property (nonatomic, strong) UITextField * inputTextField;

@property (nonatomic, strong) UIView * inputView;
@property (nonatomic, assign) FaceboardInputType inputType;

@property (nonatomic, assign) BOOL isFirstShowKeyboard;
@property (nonatomic, assign) BOOL isHideKeyboard;

- (void)resignFaceboard;

@end
