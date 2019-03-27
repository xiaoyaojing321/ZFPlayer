//
//  ZFVideoGuideView.m
//  ZFPlayer
//
//  Created by tianya on 2019/3/27.
//

#import "ZFVideoGuideView.h"
#import "UIView+ZFFrame.h"
#import "ZFUtilities.h"

@interface ZFVideoGuideView ()

@property (nonatomic, strong) UIButton *guideButton;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *centerImage;
@property (nonatomic, strong) UIImageView *rightImage;

@end

#define KZFVideoGuideViewKey    @"ZFVideoGuideView21"

@implementation ZFVideoGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
  
        [self addSubview:self.leftImage];
        [self addSubview:self.centerImage];
        [self addSubview:self.rightImage];
        [self addSubview:self.guideButton];
        //[self addDeviceOrientationObserver];
        if ([self needShowWelcomeController] == YES) {
            [self hideMySelf];
        }
    }
    return self;
}


- (void)dealloc {
    //[self removeDeviceOrientationObserver];
    
}

- (void)addDeviceOrientationObserver {
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeDeviceOrientationObserver {
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)handleDeviceOrientationChange {

    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (currentOrientation == UIInterfaceOrientationLandscapeLeft || currentOrientation == UIInterfaceOrientationLandscapeRight) {
        
    } else if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];

    //CGFloat margin = 39.0;
    //CGFloat margin = (39.0 / 375.0) * self.width;
    CGFloat margin = 0.1 * self.width;
    
    self.leftImage.centerY = self.centerY;
    self.leftImage.x = margin;
    
    self.centerImage.centerX = self.centerX;
    self.centerImage.centerY = self.centerY;
    
    
    
    self.rightImage.centerY = self.centerY;
    self.rightImage.x = self.width - self.rightImage.width - margin;;
    
    self.guideButton.centerX = self.centerX;
    self.guideButton.centerY = self.centerY;
    self.guideButton.frame = self.frame;
    
    
}

- (UIButton *)guideButton {
    if (!_guideButton) {
        _guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *guideImage = [UIImage imageNamed:@"guideButton"];
//        [_guideButton setImage:guideImage forState:UIControlStateNormal];
        [_guideButton addTarget:self
                         action:@selector(guideButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _guideButton;
}


- (UIImageView *)leftImage {
    if (!_leftImage) {
        //UIImage *guideImage = [UIImage imageNamed:@"new_allPause_44x44_"];
        _leftImage = [[UIImageView alloc] initWithImage:ZFPlayer_Image(@"vb_left_tip")];
    }
    return _leftImage;
}

- (UIImageView *)centerImage {
    if (!_centerImage) {
        //UIImage *guideImage = [UIImage imageNamed:@"new_allPlay_44x44_"];
        _centerImage = [[UIImageView alloc] initWithImage:ZFPlayer_Image(@"vb_center_tip")];
    }
    return _centerImage;
}

- (UIImageView *)rightImage {
    if (!_rightImage) {
        //UIImage *guideImage = [UIImage imageNamed:@"ZFPlayer_back_full"];
        _rightImage = [[UIImageView alloc] initWithImage:ZFPlayer_Image(@"vb_right_tip")];
    }
    return _rightImage;
}

- (void)guideButtonClick:(UIButton *)sender {
    [self hideMySelf];
}

- (void)hideMySelf {
    self.alpha = 0.0;
    self.hidden = YES;
    [self saveShowWelcome];
}



- (BOOL)needShowWelcomeController
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *alreadyRemind = [defaults objectForKey:KZFVideoGuideViewKey];
    
    if ([alreadyRemind length] > 0) {
        return YES;
    }
    return NO;
}

- (void)saveShowWelcome
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"Yes" forKey:KZFVideoGuideViewKey];
    [defaults synchronize];
}


@end
