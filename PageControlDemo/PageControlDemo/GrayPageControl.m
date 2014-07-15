//
//  GrayPageControl.m
//  PageControlDemo
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    _activeImage = [UIImage imageNamed:@"inactive_page_image"];
    _inactiveImage = [UIImage imageNamed:@"active_page_image"];
    [self setCurrentPage:1];
    return self;
}

- (id)initWithFrame:(CGRect)aFrame {
    
	if (self = [super initWithFrame:aFrame]) {
        _activeImage = [UIImage imageNamed:@"inactive_page_image"];
        _inactiveImage = [UIImage imageNamed:@"active_page_image"];
        [self setCurrentPage:1];
	}
	
	return self;
}

-(void) updateDots
{
    CGFloat xOffset = 0;

    for (int i = 0; i < self.numberOfPages; i++)
    {
        UIImageView *dot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inactive_page_image"] highlightedImage:[UIImage imageNamed:@"active_page_image"]];
        
        CGRect frame = dot.frame;
        NSLog(@"%@", NSStringFromCGRect(frame));
        
        frame.origin.x = xOffset;
        dot.frame = frame;
        
        NSLog(@"%@", NSStringFromCGRect(frame));
        
        dot.highlighted = (i == self.currentPage);


//        UIImageView* dot = (UIImageView *)(self.subviews[i]);
//        UIImageView * dot = [[UIImageView alloc] init];
//        dot.image = [UIImage imageNamed:@"inactive_page_image"];
//
//        if (i == self.currentPage)
//            dot.image = _activeImage;
//        else
//            dot.image = _inactiveImage;
        [self addSubview:dot];

        xOffset = xOffset + frame.size.width;

    }
 
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}


-(void)dealloc{
//    _activeImage = nil;
//    _inactiveImage = nil;
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
