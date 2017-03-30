//
//  ALCalendarCollectionViewCell.m
//  ALCalendarView
//
//  Created by hwt on 17/3/30.
//  Copyright © 2017年 hwt. All rights reserved.
//

#import "ALCalendarCollectionViewCell.h"

@implementation ALCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    _labText = [[UILabel alloc] init];
    _labText.translatesAutoresizingMaskIntoConstraints = NO;
    _labText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_labText];
    
    CGFloat margin = 1;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labText
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:margin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labText
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:-margin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labText
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:margin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_labText
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:-margin]];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _labText.layer.cornerRadius = _labText.frame.size.width / 2.0;
    
}

@end
