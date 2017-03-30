//
//  ALCalendarCollectionView.h
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALCalendarModel;
@interface ALCalendarCollectionView : UICollectionView

@property (nonatomic, strong) NSArray<ALCalendarModel *> *data;


@property (nonatomic, assign) BOOL isBeginDaySelected;
@property (nonatomic, assign) BOOL isEndDaySelected;

@property (nonatomic, strong) NSDate *curDate;
@property (nonatomic, strong) NSDate *beginDate;
@property (nonatomic, strong) NSDate *endDate;

- (void)updateDataWithSelectedDate;

@end
