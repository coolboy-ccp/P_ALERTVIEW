//
//  ViewController.m
//  P_ALERTVIEW
//
//  Created by liqunfei on 15/12/25.
//  Copyright © 2015年 chuchengpeng. All rights reserved.
//

#import "ViewController.h"
#import "MyDefineAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
   __block MyDefineAlertView *alert;
    
    NSString *str = @"您将进行支付宝收款\n收款金额1000元\n条形码 7788 7788 7788 777888\n";
    NSRange range = [str rangeOfString:@"1000"];
    NSMutableAttributedString *mutableS = [[NSMutableAttributedString alloc] initWithString:str];
    [mutableS addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    alert = [MyDefineAlertView showAlertViewWithTitle:@"温馨提示" cancleButtonTitle:@"取消收款" OKbuttonTitle:@"确认收款" messageAttributedString:mutableS imageName:nil callBlock:^(MyWindowClick buttonIndex) {
        if (buttonIndex) {
            NSLog(@"button");
        }
        else {
            
        }
        alert.hidden = YES;
        alert = nil;
    }];
}

@end
