//
//  ALDayUtils.h
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALDayUtils : NSObject

+ (NSCalendar *)localCalendar;

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year;

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year;

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components;

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

//年月日
+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date;
//年月日时分秒
+ (NSDateComponents *)detailDateComponentsFromDate:(NSDate *)date;

//是否同一天
+ (BOOL)isDate:(NSDate *)date equalToAnotherDate:(NSDate *)anotherDate;

@end
