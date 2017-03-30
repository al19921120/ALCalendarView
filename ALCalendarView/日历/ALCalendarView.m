//
//  ALCalendarView.m
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import "ALCalendarView.h"
#import "ALCalendarNavView.h"
#import "ALCalendarCollectionView.h"
#import "ALDayUtils.h"
#import "ALCalendarModel.h"

#define __kAlCalendarWidth self.frame.size.width
#define __kAlCalendarHeight self.frame.size.height
#define __kAlCalendarMargin 15
#define __kAlBlackColor [UIColor colorWithRed:0.24 green:0.29 blue:0.35 alpha:1]

@interface ALCalendarView ()

@property (nonatomic, strong) ALCalendarNavView *viewNav;
@property (nonatomic, strong) UIView *viewWeek;
@property (nonatomic, strong) UIButton *btnBottom;
@property (nonatomic, strong) ALCalendarCollectionView *collectionViewDate;

@end

@implementation ALCalendarView {
    
    NSUInteger _curYear;
    NSUInteger _curMonth;
    
    NSDate *_curBeginDate;
    NSDate *_curEndDate;
    
}

#pragma mark - init

- (instancetype)init {

    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    NSDateComponents *components = [ALDayUtils dateComponentsFromDate:[NSDate date]];
    _curYear = components.year;
    _curMonth = components.month;
    
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.alpha = 0;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [self addSubview:self.viewNav];
    [self addSubview:self.viewWeek];
    [self addSubview:self.btnBottom];
    [self addSubview:self.collectionViewDate];
    
    //Nav
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewNav
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewNav
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewNav
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:0]];
    [self.viewNav addConstraint:[NSLayoutConstraint constraintWithItem:self.viewNav
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0
                                                                    constant:40]];
    
    //week
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewWeek
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.viewNav
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewWeek
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:__kAlCalendarMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.viewWeek
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:-__kAlCalendarMargin]];
    [self.viewWeek addConstraint:[NSLayoutConstraint constraintWithItem:self.viewWeek
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:40]];

    
    
    //collection
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionViewDate
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.viewWeek
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionViewDate
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.btnBottom
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:-__kAlCalendarMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionViewDate
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:__kAlCalendarMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionViewDate
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:-__kAlCalendarMargin]];

    
    //bottomBtn
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBottom
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:-__kAlCalendarMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBottom
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:__kAlCalendarMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBottom
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:-__kAlCalendarMargin]];
    [self.btnBottom addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBottom
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:40]];
    
    
    
    CGFloat weekLabWidth = (__kAlCalendarWidth - __kAlCalendarMargin*2) / 7.0;
    NSArray *weekArr = @[@"日", @"一" , @"二", @"三", @"四", @"五", @"六"];
    
    [weekArr enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UILabel *lab = [[UILabel alloc] init];
        lab.translatesAutoresizingMaskIntoConstraints = NO;
        lab.text = title;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = __kAlBlackColor;
        [self.viewWeek addSubview:lab];
        
        [self.viewWeek addConstraint:[NSLayoutConstraint constraintWithItem:lab
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.viewWeek
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:0]];
        [self.viewWeek addConstraint:[NSLayoutConstraint constraintWithItem:lab
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.viewWeek
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0]];
        [self.viewWeek addConstraint:[NSLayoutConstraint constraintWithItem:lab
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.viewWeek
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0
                                                          constant:idx*weekLabWidth]];
        [lab addConstraint:[NSLayoutConstraint constraintWithItem:lab
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:weekLabWidth]];
        
    }];
    
    self.viewNav.labText.text = [NSString stringWithFormat:@"%ld月%ld", _curMonth, _curYear];
    [self updateData];
    
    
}

#pragma mark - public

- (void)showCalendar {

    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];

}

- (void)hideCalendarWithCompletion:(void(^)())completion {

    self.alpha = 1;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (completion) {
            completion();
        }
    }];
    
}

#pragma mark - private

- (void)navPressBtn {
    
    if (self.collectionViewDate.beginDate) {
        _curBeginDate = self.collectionViewDate.beginDate;
    }
    else {
        _curBeginDate = nil;
    }
    if (self.collectionViewDate.endDate) {
        _curEndDate = self.collectionViewDate.endDate;
    }
    else {
        _curEndDate = nil;
    }
    
    switch (_viewNav.lastCommand) {
            
        case ALCalendarNavTypePrev:
            [self prevMonth];
            break;
            
        case ALCalendarNavTypeNext:
            [self nextMonth];
            break;
            
        default:
            return;
            break;
    }
    _viewNav.lastCommand = ALCalendarNavTypeNone;

    self.viewNav.labText.text = [NSString stringWithFormat:@"%ld月%ld", _curMonth, _curYear];
    [self updateData];
    
}

- (void)prevMonth {
    
    if (_curMonth == 1) {
        _curMonth = 12;
        _curYear--;
    }
    else {
        _curMonth--;
    }
    
}

- (void)nextMonth {
    
    if (_curMonth == 12) {
        _curMonth = 1;
        _curYear++;
    }
    else {
        _curMonth++;
    }
}

- (void)updateData {
    
    
    NSUInteger curTotalDays = [ALDayUtils daysInMonth:_curMonth ofYear:_curYear];

    NSUInteger paddingDays = 7 - ([ALDayUtils firstWeekdayInMonth:_curMonth ofYear:_curYear]);
    //周日开始
    paddingDays = (7 - (paddingDays + 1))%7;
    
//    NSUInteger totalDays = [ALDayUtils daysInMonth:_curMonth ofYear:_curYear];
    NSUInteger nextYear = _curYear;
    NSUInteger nextMonth = _curMonth + 1;
    if (nextMonth == 13) {
        nextMonth = 1;
        nextYear++;
    }
    
    NSUInteger prevYear = _curYear;
    NSUInteger prevMonth = _curMonth - 1;
    if (prevMonth == 0) {
        prevMonth = 12;
        prevYear--;
    }

    NSUInteger prevTotalDays = [ALDayUtils daysInMonth:prevMonth ofYear:prevYear];
    
    NSMutableArray *dayModelArr = [NSMutableArray array];
    NSUInteger curDay = prevTotalDays - paddingDays;
    
    NSUInteger totalDays = (7 - (paddingDays + curTotalDays) % 7) + paddingDays + curTotalDays;
    
    for (NSInteger idx = 0; idx < totalDays; idx++) {
        
        ALCalendarModel *model = [[ALCalendarModel alloc] init];
        
        curDay++;
        if (idx < paddingDays) {
            model.date = [ALDayUtils dateWithMonth:prevMonth day:curDay year:prevYear];
        }
        if (idx == paddingDays) {
            curDay = 1;
            model.isCurMonth = YES;
            model.date = [ALDayUtils dateWithMonth:_curMonth day:curDay year:prevYear];
        }
        if (idx > paddingDays && idx <= paddingDays + curTotalDays) {
            model.isCurMonth = YES;

            model.date = [ALDayUtils dateWithMonth:_curMonth day:curDay year:_curYear];
        }
        if (idx == paddingDays + curTotalDays) {
            curDay = 1;
            model.isCurMonth = NO;
            model.date = [ALDayUtils dateWithMonth:nextMonth day:curDay year:nextYear];
        }
        if (idx > paddingDays + curTotalDays) {
            model.isCurMonth = NO;
            model.date = [ALDayUtils dateWithMonth:nextMonth day:curDay year:nextYear];
        }
        
        model.day = curDay;

        [dayModelArr addObject:model];
        
    }

    _collectionViewDate.beginDate = _curBeginDate;
    _collectionViewDate.endDate = _curEndDate;
    _collectionViewDate.curDate = [ALDayUtils dateWithMonth:_curMonth year:_curYear];
    _collectionViewDate.data = dayModelArr;
    [_collectionViewDate updateDataWithSelectedDate];
    [_collectionViewDate reloadData];
    
}


- (void)btnCommitSelectDate {
    
    if ([self.delegate respondsToSelector:@selector(calendarView:didSelectedBeginDate:endDate:)]) {
        [self.delegate calendarView:self didSelectedBeginDate:self.collectionViewDate.beginDate endDate:self.collectionViewDate.endDate];
    }
    
    [self hideCalendarWithCompletion:^{
        
    }];
    
    
}

#pragma mark - set & get

- (ALCalendarNavView *)viewNav {
    
    if (!_viewNav) {
        _viewNav = [[ALCalendarNavView alloc] init];
        _viewNav.translatesAutoresizingMaskIntoConstraints = NO;
        [_viewNav addTarget:self action:@selector(navPressBtn) forControlEvents:UIControlEventAllEvents];
        _viewNav.backgroundColor = __kAlBlackColor;
        
    }
    return _viewNav;
    
}

- (UIView *)viewWeek {
    
    if (!_viewWeek) {
        _viewWeek = [[UIView alloc] init];
        _viewWeek.translatesAutoresizingMaskIntoConstraints = NO;
        _viewWeek.backgroundColor = self.backgroundColor;
    }
    return _viewWeek;
    
}

- (UIButton *)btnBottom {
    
    if (!_btnBottom) {
        
        _btnBottom = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBottom.translatesAutoresizingMaskIntoConstraints = NO;
        [_btnBottom addTarget:self action:@selector(btnCommitSelectDate) forControlEvents:UIControlEventTouchUpInside];
        _btnBottom.backgroundColor = [UIColor colorWithRed:0.92 green:0 blue:0 alpha:1];
        _btnBottom.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnBottom setTitle:@"确定" forState:UIControlStateNormal];
        _btnBottom.layer.cornerRadius = 2;
        [_btnBottom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnBottom;
    
}

- (ALCalendarCollectionView *)collectionViewDate {
    
    if (!_collectionViewDate) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat width = (__kAlCalendarWidth - __kAlCalendarMargin*2) / 7.0;
        layout.itemSize = CGSizeMake(width, width);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionViewDate = [[ALCalendarCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionViewDate.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionViewDate.backgroundColor = self.backgroundColor;
        
    }
    return _collectionViewDate;
    
}


@end
