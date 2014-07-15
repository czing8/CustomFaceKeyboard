//
//  MessageCell.h
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-15.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageView.h"
#import "MessageModel.h"

@interface MessageCell : UITableViewCell
@property (strong, nonatomic) MessageModel * model;

@property (strong, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet MessageView *messageView;

@end
