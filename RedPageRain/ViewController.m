//
//  ViewController.m
//  RedPageRain
//
//  Created by 桐 on 2020/3/28.
//  Copyright © 2020 com.mt. All rights reserved.
//

#import "ViewController.h"
#import "RedPackRainView.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, strong) RedPackRainView *redPackViewRain;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RedPackRainView *redPackViewRain = [[RedPackRainView alloc] init];
    [self.view addSubview:redPackViewRain];
    _redPackViewRain = redPackViewRain;
    
    [redPackViewRain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"标题" message:@"点击屏幕任意位置开始" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alertview show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _redPackViewRain.begin = YES;
    });
}
@end
