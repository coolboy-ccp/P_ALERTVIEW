//
//  MyDefineAlertView.m
//  P_ALERTVIEW
//
//  Created by liqunfei on 15/12/25.
//  Copyright © 2015年 chuchengpeng. All rights reserved.
//

#import "MyDefineAlertView.h"
#define HIGHLIGHTED_COLOR [UIColor colorWithRed:82.0/255.0 green:172.0/255.0 blue:206.0/255.0 alpha:1.0]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BASE_TAG 100
CGFloat const button_width = 80.0f;
CGFloat const button_height = 40.0f;
CGFloat const title_font = 18.0f;
CGFloat const message_font = 16.0f;
CGFloat const button_font = 16.0f;

@interface MyDefineAlertView()
{
    UIView *logoView;
    UIView *headerView;
    UILabel *titleLabel;
    UILabel *messageLabel;
    UIButton *okButton;
    UIButton *cancleButton;
    UIImageView *logoImageView;
    CAShapeLayer *pathLayer;
    UIView *bgView;
}

@end
@implementation MyDefineAlertView

+ (instancetype)shared {
    static dispatch_once_t once = 0;
    static MyDefineAlertView *alert;
    dispatch_once(&once, ^{
        alert = [[MyDefineAlertView alloc] init];
    });
    return alert;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self setBackgroundColor:[UIColor clearColor]];
        self.hidden = NO;
        self.windowLevel = 100;
        [self controlViewInit];
    }
    return self;
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title cancleButtonTitle:(NSString *)cancleTitle OKbuttonTitle:(NSString *)okTitle messageAttributedString:(NSMutableAttributedString *)attributStr imageName:(NSString *)imageName callBlock:(CallBackBlcok)callBaclBlock {
    [[self shared] addButtonWithOkTitle:okTitle CancleButton:cancleTitle];
    [[self shared] addTitleWithString:title attributeString:attributStr];
    [[self shared] addImageWithImageName:imageName];
    [[self shared] setClickBlock:callBaclBlock];
    [[self shared] setHidden:NO];
    [[self shared] shakeToShow];
    return [self shared];
}

- (void)controlViewInit {
    [self logoViewInit];
    headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, logoView.bounds.size.width, 40.0f);
    headerView.backgroundColor = HIGHLIGHTED_COLOR;

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, headerView.bounds.size.height)];
    [titleLabel setFont:[UIFont systemFontOfSize:title_font]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:button_font];
    cancleButton.frame = CGRectMake(0, logoView.bounds.size.height - button_height, (logoView.bounds.size.width)/2, button_height);
    cancleButton.exclusiveTouch = YES;
    [cancleButton setTitleColor:[UIColor colorWithRed:171.0/255.0 green:171.0/255.0 blue:171.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(cancleButton.bounds.size.width+1.0, logoView.bounds.size.height - button_height, (logoView.bounds.size.width)/2, button_height);
    okButton.titleLabel.font = [UIFont systemFontOfSize:button_font];
    okButton.exclusiveTouch = YES;
    okButton.backgroundColor = HIGHLIGHTED_COLOR;
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 50.0, 40.0, 40.0)];
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 50.0, logoView.bounds.size.width - 80.0, logoView.bounds.size.height - 101.0)];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.font = [UIFont systemFontOfSize:message_font];
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.numberOfLines = 0;
    
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, okButton.frame.origin.y - 1.0, logoView.bounds.size.width, 1.0)];
    aview.backgroundColor = HIGHLIGHTED_COLOR;
    [logoView addSubview:aview];
    [logoView addSubview:okButton];
    [logoView addSubview:logoImageView];
    [logoView addSubview:messageLabel];
    [logoView addSubview:cancleButton];
    [logoView addSubview:headerView];
    cancleButton.hidden = YES;
    okButton.hidden = YES;
    okButton.tag = BASE_TAG;
    cancleButton.tag = BASE_TAG + 1;
    [okButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)shakeToShow{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.35;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    //[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [logoView.layer addAnimation:animation forKey:nil];
}

- (void)clickButton:(UIButton *)btn {
    self.clickBlock(btn.tag - BASE_TAG);
}


- (void)logoViewInit {
    [logoView removeFromSuperview];
    logoView = nil;
    [bgView removeFromSuperview];
    bgView = nil;
    bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.4f;
    logoView = [[UIView alloc] init];
    logoView.center = CGPointMake(self.center.x, self.center.y - 40.0);
    if (SCREEN_HEIGHT > 600) {
        logoView.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.8, 212.0);
    }
    else {
      logoView.bounds = CGRectMake(0, 0, SCREEN_WIDTH * 0.8, 180.0);
    }
    logoView.backgroundColor = [UIColor whiteColor];
    logoView.layer.cornerRadius = 10.f;
    logoView.clipsToBounds = YES;
    [self addSubview:logoView];
    [self insertSubview:bgView belowSubview:logoView];
    
}

- (void)addTitleWithString:(NSString *)title  attributeString:(NSMutableAttributedString *)attributesring {
    CGRect rect = messageLabel.frame;
    if (title) {
        titleLabel.hidden = NO;
        headerView.hidden = NO;
        titleLabel.text = title;
    }
    else {
        headerView.hidden = YES;
        titleLabel.hidden = YES;
        rect.origin.y = 0.0f;
        rect.size.height += 50.0f;
    }
    messageLabel.attributedText = attributesring;
    CGRect rect1 = [messageLabel.text boundingRectWithSize:messageLabel.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:messageLabel.font,NSFontAttributeName, nil] context:nil];
 
    messageLabel.frame = CGRectMake(70.0, 50.0, logoView.bounds.size.width - 90.0, rect1.size.height);
}

- (void)addImageWithImageName:(NSString *)imageName {
    CGRect rect = messageLabel.frame;
    
    if (imageName) {
        logoImageView.hidden = NO;
        logoImageView.image = [UIImage imageNamed:imageName];
    }
    else {
        rect.origin.x = 20.0f;
        rect.size.width += 40.0f;
        logoImageView.hidden = YES;
        messageLabel.frame = rect;
    }
}

- (void)addButtonWithOkTitle:(NSString *)ok CancleButton:(NSString *)cancle  {
    BOOL flag = NO;
    if (!ok && cancle) {
        flag = YES;
    }
    if (flag) {
        cancleButton.frame = CGRectMake(0, logoView.frame.size.height - 40.0f, logoView.frame.size.width, button_height);
        okButton.hidden = YES;
    }
    else {
        okButton.hidden = NO;
        [okButton setTitle:ok forState:UIControlStateNormal];
    }
    cancleButton.hidden = NO;
    [cancleButton setTitle:cancle forState:UIControlStateNormal];
}

@end
