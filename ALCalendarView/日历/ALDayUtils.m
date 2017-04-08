//
//  ALDayUtils.m
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import "ALDayUtils.h"

#define __kUpIOS8 [[[UIDevice currentDevice]systemVersion]doubleValue] >= 8.0

@implementation ALDayUtils


+ (NSCalendar *)localCalendar {
    
    static NSCalendar *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    });
    return instance;
    
}

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year {
    return [self dateWithMonth:month day:1 year:year];
}

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    
    return [self dateFromDateComponents:comps];
}

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components {
    return [[self localCalendar] dateFromComponents:components];
}

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    
    NSDate *date = [self dateWithMonth:month year:year];
    if (__kUpIOS8) {
        return [[self localCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    }
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
    

    
}

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    
    NSDate *date = [self dateWithMonth:month year:year];
    if (__kUpIOS8) {
        return [[self localCalendar] component:NSCalendarUnitWeekday fromDate:date];
    }
    return [[self localCalendar] component:NSWeekdayCalendarUnit fromDate:date];
}

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date {
    
    if (__kUpIOS8) {
        return [[self localCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    }
    return [[self localCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
}

+ (NSDateComponents *)detailDateComponentsFromDate:(NSDate *)date {
    
    if (__kUpIOS8) {
        return [[self localCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate:date];
    }
    return [[self localCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate:date];
}

+ (BOOL)isDate:(NSDate *)date equalToAnotherDate:(NSDate *)anotherDate {
    
    NSDateComponents *dateComponents = [self dateComponentsFromDate:date];
    NSDateComponents *anotherDateComponents = [self dateComponentsFromDate:anotherDate];
    return dateComponents.year == anotherDateComponents.year && dateComponents.month == anotherDateComponents.month && dateComponents.day == anotherDateComponents.day;
}


@end
