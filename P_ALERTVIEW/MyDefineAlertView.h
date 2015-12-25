//
//  MyDefineAlertView.h
//  P_ALERTVIEW
//
//  Created by liqunfei on 15/12/25.
//  Copyright © 2015年 chuchengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MyWindowClick) {
    MyWindowClickForOk,
    MyWindowClickForCancle
};

typedef NS_ENUM(NSInteger,MyAlertViewStyle) {
    MyAlertViewStyleDefault,
    MyAlertViewStyleSuccess,
    MyAlertViewStyleFaile,
    MyAlertViewStyleWaring
};

typedef void (^CallBackBlcok)(MyWindowClick buttonIndex);
@interface MyDefineAlertView : UIWindow
@property (nonatomic,strong)CallBackBlcok clickBlock;

+ (instancetype)shared;

+ (instancetype)showAlertViewWithTitle:(NSString *)title cancleButtonTitle:(NSString *)cancleTitle OKbuttonTitle:(NSString *)okTitle messageAttributedString:(NSMutableAttributedString *)attributStr imageName:(NSString *)imageName callBlock:(CallBackBlcok)callBaclBlock;
@end
