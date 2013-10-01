//
//  CTBlurredView.m
//
//  Created by David Fumberger on 27/09/2013.
//
//

#import "CTBlurredView.h"

@interface CTBlurredView()
@property (nonatomic, retain) UIToolbar *_blurredToolbar;
@property (nonatomic, retain) UIView *_blurredBackgroundColorView;
@property (nonatomic, strong) UIColor *blurTintColor;
@end

@implementation CTBlurredView

+ (BOOL)supported {
    return ([UIToolbar instancesRespondToSelector: @selector(barTintColor)]);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([CTBlurredView supported]) {
            self._blurredToolbar = [[UIToolbar alloc] initWithFrame: self.bounds];
            self._blurredToolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self insertSubview:self._blurredToolbar atIndex:0];
        }
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview: newSuperview];
    [self sendSubviewToBack: self._blurredToolbar];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self sendSubviewToBack: self._blurredToolbar];
}

- (void)setBlurStrength:(float)strength {
    _blurStrength = strength;
    self._blurredToolbar.alpha = _blurStrength;
}

- (void)setBlurTintColor:(UIColor *)blurredTintColor {
    _blurTintColor = [blurredTintColor colorWithAlphaComponent: 1.0f];
    self._blurredToolbar.barTintColor = _blurTintColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    if ([CTBlurredView supported]) {
        self.blurTintColor = backgroundColor;
    } else {
        [super setBackgroundColor: backgroundColor];
    }
}

- (UIColor*)backgroundColor {
    if ([CTBlurredView supported]) {
        return self.blurTintColor;
    } else {
        return [super backgroundColor];
    }
}

@end
