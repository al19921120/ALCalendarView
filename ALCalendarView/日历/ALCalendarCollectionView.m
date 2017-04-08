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
        
        if (!_beginDate && !_endDate) {
            tempModel.isSelect = NO;
            continue;
        }
        
        if (_beginDate && !_endDate) {
            
            if ([tempModel.date compare:_beginDate] == NSOrderedSame) {
                tempModel.isSelect = YES;
            }
            else {
                tempModel.isSelect = NO;
            }
            continue;

        }

        if (!_beginDate && _endDate) {
            
            if ([tempModel.date compare:_endDate] == NSOrderedSame) {
                tempModel.isSelect = YES;
            }
            else {
                tempModel.isSelect = NO;
            }
            continue;
        }
        
        
        if (_beginDate && _endDate) {
            
            if (([tempModel.date compare:_beginDate] == NSOrderedDescending
                && [tempModel.date compare:_endDate] == NSOrderedAscending)
                || [tempModel.date compare:_beginDate] == NSOrderedSame
                ||  [tempModel.date compare:_endDate] == NSOrderedSame) {
                tempModel.isSelect = YES;
            }
            else {
                tempModel.isSelect = NO;
            }
            
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

    BOOL isToday = [ALDayUtils isDate:model.date equalToAnotherDate:[NSDate date]];
    if (isToday) {
        cell.labText.layer.backgroundColor = __kAlRedColor.CGColor;
        cell.labText.textColor = [UIColor whiteColor];
    }
    
    if ((remain == 0 || remain == 6) && !model.isSelect && !isToday) {
        cell.labText.textColor = __kAlRedColor;
        cell.labText.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    else {

        if (model.isSelect) {
            cell.labText.layer.backgroundColor = __kAlBlackColor.CGColor;
            cell.labText.textColor = [UIColor whiteColor];
        }

        if (!model.isSelect && !isToday) {
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

    if (!_beginDate && !_endDate) {
        _beginDate = model.date;
        model.isSelect = YES;
        [self reloadData];
        return;
    }

    if (_beginDate) {
        
        switch ([model.date compare:_beginDate]) {
                
            case NSOrderedDescending:
                
                if (_endDate) {
                    
                    switch ([model.date compare:_endDate]) {
                            
                        case NSOrderedDescending:
                            _endDate = model.date;
                            break;
                            
                        case NSOrderedSame:
                            _endDate = nil;
                            break;
                            
                        case NSOrderedAscending:
                            _endDate = model.date;
                            break;
                            
                        default:
                            break;
                    }
                }
                else {
                    _endDate = model.date;
                }
                break;
                
            case NSOrderedSame:
                _beginDate = nil;
                break;
                
            case NSOrderedAscending:
                
                if (_endDate) {
                    _beginDate = model.date;
                }
                else {
                    _endDate = _beginDate;
                    _beginDate = model.date;
                }
                
                break;
                
            default:
                break;
        }
        
        [self updateDataWithSelectedDate];
        return;
    }
    
    if (_endDate) {
        
        switch ([model.date compare:_endDate]) {
                
            case NSOrderedDescending:
                _beginDate = _endDate;
                _endDate = model.date;
                break;
                
            case NSOrderedSame:
                _endDate = nil;
                break;
                
            case NSOrderedAscending:
                _beginDate = model.date;
                break;
                
            default:
                break;
        }
        
        
    }
    
    [self updateDataWithSelectedDate];
    
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
