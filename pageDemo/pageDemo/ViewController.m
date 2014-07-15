//
//  ViewController.m
//  pageDemo
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//
#import "ViewController.h"
#import "GrayPageControl.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView * faceView;
@property (nonatomic, strong) GrayPageControl * pageControl;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.faceView];
    [self.view addSubview:self.pageControl];

}

- (UIScrollView *)faceView{
    if (!_faceView) {
        _faceView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, 216)];
        _faceView.pagingEnabled = YES;
        _faceView.contentSize = CGSizeMake((85/28+1)*320, 216);
        _faceView.showsHorizontalScrollIndicator = NO;
        _faceView.showsVerticalScrollIndicator = NO;
        _faceView.delegate = self;
    }
    return _faceView;
}


- (GrayPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[GrayPageControl alloc]initWithFrame:CGRectMake(110, 190, 100, 20)];
        [_pageControl addTarget:self
                         action:@selector(pageChange:)
               forControlEvents:UIControlEventValueChanged];
        
        _pageControl.numberOfPages = 85/28+1;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
