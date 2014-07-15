//
//  GrayPageControl.m
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    [self setCurrentPage:1];
    
    self.backgroundColor = [UIColor redColor];
    return self;
}

- (id)initWithFrame:(CGRect)aFrame {
    
	if (self = [super initWithFrame:aFrame]) {
        
        [self setCurrentPage:1];
	}
	
	return self;
}

-(void) updateDots
{
    for (int i = 0; i < self.numberOfPages; i++)
    {
        UIImageView * dot = self.subviews[i];
        
        if (i == self.currentPage){
            dot.backgroundColor = [UIColor colorWithWhite:0.304 alpha:1.000];

        }
        else{
            dot.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
        }
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
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
