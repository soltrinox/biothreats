//
//  RMViewController.m
//  RMLoaderDisplay
//
//  Created by Mahesh on 1/30/14.
//  Copyright (c) 2014 Mahesh Shanbhag. All rights reserved.
//

#import "RMViewController.h"
#import "RMDownloadIndicator.h"

@interface RMViewController ()
@property (weak, nonatomic) IBOutlet UILabel *settings;
@property (weak, nonatomic) IBOutlet UISwitch *settingSwitch;

@property (weak, nonatomic) RMDownloadIndicator *closedIndicator;
@property (weak, nonatomic) RMDownloadIndicator *filledIndicator;
@property (weak, nonatomic) RMDownloadIndicator *mixedIndicator;

@property (assign, nonatomic)CGFloat downloadedBytes;

@end

@implementation RMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self settingChanged:self.settingSwitch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDownloadIndicators
{

    [_mixedIndicator removeFromSuperview];
    _mixedIndicator = nil;
    
    

    
    RMDownloadIndicator *mixedIndicator = [[RMDownloadIndicator alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds) - 80)/2, CGRectGetMaxY(self.filledIndicator.frame) + 40.0f, 80, 80) type:kRMMixedIndictor];
    [mixedIndicator setBackgroundColor:[UIColor whiteColor]];
    [mixedIndicator setFillColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [mixedIndicator setStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    [mixedIndicator setClosedIndicatorBackgroundStrokeColor:[UIColor colorWithRed:16./255 green:119./255 blue:234./255 alpha:1.0f]];
    mixedIndicator.radiusPercent = 0.45;
    [self.view addSubview:mixedIndicator];
    [mixedIndicator loadIndicator];
    _mixedIndicator = mixedIndicator;
}


#pragma mark - Update Views
- (void)startAnimation
{
    [self addDownloadIndicators];
    
    if(!self.settingSwitch.isOn)
    {
        [self updateViewOneTime];
        return;
    }
    
    self.downloadedBytes = 0;
    
    
    self.settingSwitch.userInteractionEnabled = NO;
    typeof(self) __weak weakself = self;
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakself updateView:10.0f];
    });
    
    double delayInSeconds1 = delayInSeconds + 1;
    dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds1 * NSEC_PER_SEC));
    dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
        [weakself updateView:30.0f];
    });
    
    double delayInSeconds2 = delayInSeconds1 + 1;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        [weakself updateView:10.0f];
    });
    
    double delayInSeconds3 = delayInSeconds2 + 1;
    dispatch_time_t popTime3 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds3 * NSEC_PER_SEC));
    dispatch_after(popTime3, dispatch_get_main_queue(), ^(void){
        [weakself updateView:50.0f];
        self.settingSwitch.userInteractionEnabled = YES;
    });
}

- (void)updateView:(CGFloat)val
{
    self.downloadedBytes+=val;

    [_mixedIndicator updateWithTotalBytes:100 downloadedBytes:self.downloadedBytes];
}

- (void)updateViewOneTime
{

    [_mixedIndicator setIndicatorAnimationDuration:1.0];

    [_mixedIndicator updateWithTotalBytes:100 downloadedBytes:self.downloadedBytes];
}

#pragma mark - Switch Change
- (IBAction)settingChanged:(UISwitch *)sender
{
    if(self.settingSwitch.isOn)
    {
        [self.settings setText:@"Multi Time Animation"];
        [self startAnimation];
    }
    else
    {
        [self.settings setText:@"One Time Animation"];
        [self startAnimation];
    }
}

@end
