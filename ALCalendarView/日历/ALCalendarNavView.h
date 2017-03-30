//
//  ALCalendarTopView.h
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ALCalendarNavType) {
    ALCalendarNavTypeNone,
    ALCalendarNavTypePrev,
    ALCalendarNavTypeNext,
};

@interface ALCalendarNavView : UIControl

@property (nonatomic, assign) ALCalendarNavType lastCommand;
@property (nonatomic, strong) UILabel *labText;

@end
