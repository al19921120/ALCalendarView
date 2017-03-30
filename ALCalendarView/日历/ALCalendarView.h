//
//  ALCalendarView.h
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALCalendarView;
@protocol ALCalendarDelegate <NSObject>

- (void)calendarView:(ALCalendarView *)calendarView didSelectedBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate;

@end


@interface ALCalendarView : UIView

@property (nonatomic, weak) id<ALCalendarDelegate> delegate;

- (void)showCalendar;
- (void)hideCalendarWithCompletion:(void(^)())completion;

@end
