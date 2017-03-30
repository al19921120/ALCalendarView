//
//  ViewController.m
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import "ViewController.h"
#import "ALCalendarView.h"

@interface ViewController () <ALCalendarDelegate>

@property (nonatomic, strong) ALCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _calendarView = [[ALCalendarView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _calendarView.delegate = self;
    [self.view addSubview:_calendarView];
}

- (IBAction)btnAction:(id)sender {
    
    [_calendarView showCalendar];
}

- (void)calendarView:(ALCalendarView *)calendarView didSelectedBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate {
    
    NSLog(@"\n begin=%@  ,end=%@", beginDate, endDate);
    
}

@end
