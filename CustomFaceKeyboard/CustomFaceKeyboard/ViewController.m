//
//  ViewController.m
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "ViewController.h"
#import "FaceBoardView.h"

@interface ViewController ()

@property (nonatomic, strong) FaceBoardView * faceBoardView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.faceBoardView];
}


#pragma mark - properties

- (FaceBoardView *)faceBoardView{
    if (!_faceBoardView) {
        CGRect frame = CGRectMake(0, kSCREEN_HEIGHT - 44, kSCREEN_WIDTH, 44);
        _faceBoardView = [[FaceBoardView alloc] initWithFrame:frame];
        _faceBoardView.backgroundColor = [UIColor colorWithWhite:0.797 alpha:1.000];
    }
    return _faceBoardView;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_faceBoardView resignFaceboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
