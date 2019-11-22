//
//  ViewController.m
//  IOP_PolymorphismDemo
//
//  Created by luozhiwei on 2019/11/22.
//  Copyright © 2019 Lizhi. All rights reserved.
//

#import "ViewController.h"
#import "IOPPolymorphismProtocol.h"
#import "PlayerBannedStateHandler.h"
#import "PlayerDeleteStateHandler.h"
#import "PlayerLocalStateHandler.h"
#import "PlayerNoNetworkStateHandler.h"

#import <UIView+Toast.h>
#import <Masonry.h>

typedef NS_ENUM(NSUInteger, BussinessState) {
    BussinessStateNormal,           // 常规状态
    BussinessStateBanned,           // 封禁状态
    BussinessStateDelete,           // 删除状态
    BussinessStateNoNetwork,        // 无网络状态
    BussinessStateLocal,            // 本地状态
};

@interface ViewController ()<IOPPolymorphismProtocol, UIPickerViewDataSource, UIPickerViewDelegate>

//
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *laudBtn;
@property (nonatomic, strong) UIButton *playBtn;

//
@property (nonatomic, strong) NSArray *pickerDataArray;

// iop poly
@property (nonatomic, assign) BussinessState state;
@property (nonatomic, strong) PlayerBannedStateHandler *bannedStateHandler;
@property (nonatomic, strong) PlayerDeleteStateHandler *deleteStateHandler;
@property (nonatomic, strong) PlayerLocalStateHandler *localStateHandler;
@property (nonatomic, strong) PlayerNoNetworkStateHandler *noNetworkStateHandler;

@end

@implementation ViewController

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.state = BussinessStateNormal;
    }
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.playBtn];
    [self.view addSubview:self.laudBtn];
    [self addLayoutConstraints];
}

- (void)addLayoutConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(100.f);
        make.left.mas_equalTo(self.view).with.offset(16.f);
        make.width.mas_equalTo(self.view).dividedBy(2.0);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(self.titleLabel);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(100.f);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pickerView.mas_bottom);
        make.left.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(50, 100));
    }];
    
    [self.laudBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pickerView.mas_bottom);
        make.left.mas_equalTo(self.playBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 100));
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}


#pragma mark - UIPickerViewDelegate


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerDataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.state = row;
}

#pragma mark - event action

- (void)playAction
{
    // 因为是拦截器方法，所以会根据返回的BOOL来决定是否需要继续执行主流程的逻辑
    if ([self.interceptor respondsToSelector:@selector(playActionWithToastView:)]) {
        BOOL shouldContinue = [self.interceptor playActionWithToastView:self.view];
        if (shouldContinue == NO) {
            return;
        }
    }
    
    [self.view makeToast:@"正在播放"];
}

- (void)laudAction
{
    // 因为复重型的方法，所以会直接return，旁路掉主流程的逻辑
    if ([self.child respondsToSelector:@selector(laudActionWithToastView:)]) {
        [self.child laudActionWithToastView:self.view];
        return;
    }
    
    
    [self.view makeToast:@"点赞成功"];
}

#pragma mark - IOPPolymorphismProtocol

@synthesize interceptor;
@synthesize child;

- (id<ChildHandlerProtocol>)child
{
    return [self getCurrentStateHandler];
}

- (id<InterceptorHandlerProtocol>)interceptor
{
    return [self getCurrentStateHandler];
}

- (id<ChildHandlerProtocol, InterceptorHandlerProtocol>)getCurrentStateHandler
{
    id result = nil;
    
    switch (self.state) {
        case BussinessStateBanned:{
            result = self.bannedStateHandler;
            break;
        }
        case BussinessStateDelete:{
            result = self.deleteStateHandler;
            break;
        }
        case BussinessStateNoNetwork:{
            result = self.noNetworkStateHandler;
            break;
        }
        case BussinessStateLocal:{
            result = self.localStateHandler;
            break;
        }
            
        default:result=nil;
    }
    
    return result;
}

#pragma mark - getters

- (PlayerBannedStateHandler *)bannedStateHandler
{
    if (_bannedStateHandler == nil) {
        _bannedStateHandler = [[PlayerBannedStateHandler alloc] init];
    }
    return _bannedStateHandler;
}

- (PlayerDeleteStateHandler *)deleteStateHandler
{
    if (_deleteStateHandler == nil) {
        _deleteStateHandler = [[PlayerDeleteStateHandler alloc] init];
    }
    return _deleteStateHandler;
}

- (PlayerLocalStateHandler *)localStateHandler
{
    if (_localStateHandler == nil) {
        _localStateHandler = [[PlayerLocalStateHandler alloc] init];
    }
    return _localStateHandler;
}

- (PlayerNoNetworkStateHandler *)noNetworkStateHandler
{
    if (_noNetworkStateHandler == nil) {
        _noNetworkStateHandler = [[PlayerNoNetworkStateHandler alloc] init];
    }
    return _noNetworkStateHandler;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"选择当前状态";
    }
    return _titleLabel;
}

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)laudBtn
{
    if (_laudBtn == nil) {
        _laudBtn = [[UIButton alloc] init];
        [_laudBtn setTitle:@"点赞" forState:UIControlStateNormal];
        [_laudBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_laudBtn addTarget:self action:@selector(laudAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _laudBtn;
}

- (UIButton *)playBtn
{
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] init];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_playBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (NSArray *)pickerDataArray
{
    if (_pickerDataArray == nil) {
        _pickerDataArray = @[@"StateNormal", @"StateBanned", @"StateDelete", @"StateNoNetwork", @"StateLocal"];
    }
    return _pickerDataArray;
}



@end
