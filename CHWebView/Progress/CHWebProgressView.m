//
//  CHWebProgressView.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/7/20.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "CHWebProgressView.h"

@implementation CHWebProgressView{
    CAShapeLayer *_shapeLayer;
    UIView *_progressBarView;
    float _fadeOutDelay;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _springSpeed = 0.4;
        _duration = 0.5;
        _springVelocity = 0.5;
        _fadeOutDelay = 0.5f;
        self.userInteractionEnabled = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
        _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        UIColor *tintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]; // iOS7 Safari bar color
        if ([UIApplication.sharedApplication.delegate.window respondsToSelector:@selector(setTintColor:)] && UIApplication.sharedApplication.delegate.window.tintColor) {
            tintColor = UIApplication.sharedApplication.delegate.window.tintColor;
        }
        _progressBarView.backgroundColor = tintColor;
        _progressBarView.alpha = 0;
        [self addSubview:_progressBarView];
    }
    return self;
}
- (void)setColor:(UIColor *)color{
    _color = color;
    _progressBarView.backgroundColor = color;
}
- (void)setProgress:(NSProgress *)progress{
    _progress = progress;
    float fProgress = (float)progress.completedUnitCount/(float)progress.totalUnitCount;
    if (fProgress >= 1.0) {
        [UIView animateWithDuration:_duration delay:_fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = _progressBarView.frame;
            frame.size.width = fProgress * self.bounds.size.width;
            _progressBarView.frame = frame;
        } completion:^(BOOL finished) {
            _progressBarView.alpha = 0.0;
            CGRect frame = _progressBarView.frame;
            frame.size.width = 0;
            _progressBarView.frame = frame;
        }];
    }
    else {
        _progressBarView.alpha = 1;
        [UIView animateWithDuration:_duration delay:0 usingSpringWithDamping:_springSpeed initialSpringVelocity:_springVelocity options:0 animations:^{
            CGRect frame = _progressBarView.frame;
            frame.size.width = fProgress * self.bounds.size.width;
            _progressBarView.frame = frame;
        } completion:NULL];
    }
}

@end
