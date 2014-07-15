//
//  MessageManage.m
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-15.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "MessageManage.h"

@implementation MessageManage

+ (instancetype) sharedInstance{
    
    static MessageManage * _sharedInstance;
    static dispatch_once_t once_token;
    
    dispatch_once(&once_token, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [[MessageManage alloc] init];
        }
    });
    
    return _sharedInstance;
}

@end
