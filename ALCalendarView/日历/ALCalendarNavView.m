//
//  ALCalendarTopView.m
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import "ALCalendarNavView.h"

@interface ALCalendarNavView ()

@property (nonatomic, strong) UIButton *btnPrev;
@property (nonatomic, strong) UIButton *btnNext;

@end

@implementation ALCalendarNavView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.labText];
    [self addSubview:self.btnNext];
    [self addSubview:self.btnPrev];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labText
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labText
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    
    

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPrev
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPrev
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:16]];
    [self.btnPrev addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPrev
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:30]];
    [self.btnPrev addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPrev
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:30]];
    

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnNext
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnNext
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:-16]];
    [self.btnNext addConstraint:[NSLayoutConstraint constraintWithItem:self.btnNext
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:30]];
    [self.btnNext addConstraint:[NSLayoutConstraint constraintWithItem:self.btnNext
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:30]];
}


#pragma mark - private

- (void)btnPrevDidTap:(id)sender {
    self.lastCommand = ALCalendarNavTypePrev;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)btnNextDidTap:(id)sender {
    self.lastCommand = ALCalendarNavTypeNext;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - set & get

- (UILabel *)labText {
  
    if (!_labText) {
        _labText = [[UILabel alloc] init];
        _labText.translatesAutoresizingMaskIntoConstraints = NO;
        _labText.textColor = [UIColor whiteColor];
        _labText.font = [UIFont systemFontOfSize:16];
    }
    return _labText;
}

- (UIButton *)btnPrev {
    
    if (!_btnPrev) {
        _btnPrev = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPrev.translatesAutoresizingMaskIntoConstraints = NO;
        _btnPrev.tintColor = [UIColor whiteColor];
        [_btnPrev setBackgroundImage:[[UIImage imageNamed:@"icon_Prev"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [_btnPrev addTarget:self action:@selector(btnPrevDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPrev;

}

- (UIButton *)btnNext {
    
    if (!_btnNext) {
        _btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnNext.translatesAutoresizingMaskIntoConstraints = NO;
        _btnNext.tintColor = [UIColor whiteColor];
        [_btnNext setBackgroundImage:[[UIImage imageNamed:@"icon_Next"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [_btnNext addTarget:self action:@selector(btnNextDidTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNext;
    
}


@end
