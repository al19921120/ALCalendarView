//
//  ALCalendarModel.h
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALCalendarModel : NSObject

@property (nonatomic, assign) BOOL isCurMonth;
//@property (nonatomic, assign) BOOL isToday;
//@property (nonatomic, assign) BOOL isBeginSelect;
//@property (nonatomic, assign) BOOL isEndSelect;
@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, assign) NSUInteger day;
@property (nonatomic, strong) NSDate *date;

@end
