//
//  ALCalendarCollectionView.m
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import "ALCalendarCollectionView.h"
#import "ALCalendarCollectionViewCell.h"
#import "ALCalendarModel.h"
#import "ALDayUtils.h"

#define __kAlRedColor [UIColor colorWithRed:1 green:0.36 blue:0.32 alpha:1]
#define __kAlBlackColor [UIColor colorWithRed:0.24 green:0.29 blue:0.35 alpha:1]

static NSString *CalendarCellID = @"CalendarCell";

@interface ALCalendarCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>


@end

@implementation ALCalendarCollectionView {
    
    NSUInteger curBeginRow;
    
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.beginDate = nil;
        self.endDate = nil;
        
        [self registerClass:[ALCalendarCollectionViewCell class] forCellWithReuseIdentifier:CalendarCellID];
    }
    return self;
    
}

#pragma mark - public

- (void)updateDataWithSelectedDate {
    
    for (ALCalendarModel *tempModel in _data) {

        if ([tempModel.date compare:_beginDate] == NSOrderedSame && _beginDate != nil) {
            tempModel.isBeginSelect = YES;
        }
        
        if ((([tempModel.date compare:_beginDate] == NSOrderedDescending))
            && ([tempModel.date compare:_endDate] == NSOrderedAscending ||
            ([tempModel.date compare:_endDate] == NSOrderedSame && _endDate != nil)
                )) {
            tempModel.isEndSelect = YES;
        }
        else {
            tempModel.isEndSelect = NO;
        }
        
        //单一end情况
        if (_beginDate == nil && _endDate != nil && ([tempModel.date compare:_endDate] == NSOrderedSame && _endDate != nil)) {
            tempModel.isEndSelect = YES;
        }
        
    }
    [self reloadData];

}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    ALCalendarModel *model = _data[indexPath.row];
    
    ALCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CalendarCellID forIndexPath:indexPath];
    cell.labText.text = [NSString stringWithFormat:@"%ld", model.day];
    cell.backgroundColor = self.backgroundColor;
    
    //周末
    NSUInteger remain = indexPath.row % 7;
    if ((remain == 0 || remain == 6) && (!model.isBeginSelect && !model.isEndSelect)) {
        cell.labText.textColor = __kAlRedColor;
        cell.labText.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    else {
        
        if (model.isBeginSelect) {
            cell.labText.layer.backgroundColor = __kAlRedColor.CGColor;
            cell.labText.textColor = [UIColor whiteColor];
        }
        if (model.isEndSelect) {
            cell.labText.layer.backgroundColor = __kAlBlackColor.CGColor;
            cell.labText.textColor = [UIColor whiteColor];
        }
        if (!model.isBeginSelect && !model.isEndSelect) {
            cell.labText.layer.backgroundColor = [UIColor whiteColor].CGColor;
            cell.labText.textColor = [UIColor blackColor];
        }
        
    }
    
    
    if (!model.isCurMonth) {
        cell.labText.layer.backgroundColor = self.backgroundColor.CGColor;
        cell.labText.textColor = [UIColor lightGrayColor];
    }
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCalendarModel *model = _data[indexPath.row];
    if (!model.isCurMonth) {
        return;
    }
    
    if (_isEndDaySelected && !_isBeginDaySelected
        && ([model.date compare:_endDate] == NSOrderedDescending)) {
        return;
    }
    

    if ([model.date compare:_beginDate] == NSOrderedAscending
        || ((([model.date compare:_beginDate] ==  NSOrderedSame )//&& _beginDate != nil )
        || !_isBeginDaySelected) && !model.isEndSelect)
        ) {

        if (model.isBeginSelect) {
            
            model.isBeginSelect = NO;
            self.beginDate = nil;
            
            for (ALCalendarModel *tempModel in _data) {

                if (([tempModel.date compare:_endDate] != NSOrderedSame)
                    && tempModel.isEndSelect) {
                    tempModel.isEndSelect = NO;
                }

            }

        }
        else {
            model.isBeginSelect = YES;
            for (ALCalendarModel *tempModel in _data) {

                if (([tempModel.date compare:_beginDate] == NSOrderedSame && _beginDate != nil)) {
                    tempModel.isBeginSelect = NO;
                }
                if (([tempModel.date compare:model.date] == NSOrderedDescending)
                    && ([tempModel.date compare:_endDate] == NSOrderedAscending)) {
                    tempModel.isEndSelect = YES;
                }
                
            }

            self.beginDate = model.date;
        }
        
        [self reloadData];
        return;
        
    }
    
    
    if ([model.date compare:_endDate] == NSOrderedSame && _endDate != nil) {
        
        //将选中区间向前移动
        NSDateComponents *cancelEndComponents = [ALDayUtils dateComponentsFromDate:_endDate];
        cancelEndComponents.day = cancelEndComponents.day - 1;
        NSDate *preDate = [ALDayUtils dateFromDateComponents:cancelEndComponents];
        
        if ([_beginDate compare:preDate] == NSOrderedAscending) {
            self.endDate = preDate;
        }
        else {
            self.endDate = nil;
        }
        
        model.isEndSelect = NO;
    }
    else {
        self.endDate = model.date;
        for (ALCalendarModel *tempModel in _data) {
            
            if (([tempModel.date compare:_beginDate] == NSOrderedDescending)
                && ([tempModel.date compare:_endDate] == NSOrderedAscending || [tempModel.date compare:_endDate] == NSOrderedSame)) {
                tempModel.isEndSelect = YES;
            }
            else {
                tempModel.isEndSelect = NO;
            }
        }
    }


    [self reloadData];
    
}

#pragma mark - set & get

- (void)setBeginDate:(NSDate *)beginDate {

    _beginDate = beginDate;
    _isBeginDaySelected = beginDate?YES:NO;

}

- (void)setEndDate:(NSDate *)endDate {
    
    _endDate = endDate;
    _isEndDaySelected = endDate?YES:NO;
    
}

@end
