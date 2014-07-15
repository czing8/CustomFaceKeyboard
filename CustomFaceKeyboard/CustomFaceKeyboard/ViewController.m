//
//  ViewController.m
//  CustomFaceKeyboard
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "ViewController.h"
#import "FaceBoardView.h"
#import "MessageCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FaceBoardView * faceBoardView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = [self array];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.faceBoardView];
}


#pragma mark - test

- (NSMutableArray *)array {
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i ++) {
        MessageModel * model = [[MessageModel alloc] init];
        model.name = @"Tom";
        model.imageStr = @"3";
        model.message = @"gjoehgo";
        [array addObject:model];
    }
    return array;
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


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSArray alloc] init];
    }
    return _dataSource;
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString * identifier = @"MessageCell";
    
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:self options:nil] lastObject];
    }
    
    cell.model = _dataSource[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.2f];
}

- (void)deselect:(UITableView *)tableView
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
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
