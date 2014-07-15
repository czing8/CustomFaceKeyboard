//
//  MessageCell.m
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-15.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setModel:(MessageModel *)model{
    if (_model != model) {
        _model = model;
    }
    [self refreshUI];
}

- (void)refreshUI{
    _avaterImgView.image = [UIImage imageNamed:_model.imageStr];
    _nameLabel.text = _model.name;
    
//    [_messageView showMessage:_model.message];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
