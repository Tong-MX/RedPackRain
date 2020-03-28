//
//  RedPackRainView.m
//  RedPageRain
//
//  Created by 桐 on 2020/3/28.
//  Copyright © 2020 com.mt. All rights reserved.
//

#import "RedPackRainView.h"
#import "Masonry.h"
#import "RedPackConfig.h"

@interface RedPackRainView ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *redRainView;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIImageView *numberBackGround;
@property (nonatomic, weak) UIImageView *numberOneImageView;

@property (nonatomic, weak) UIView *openRedPackView;
@property (nonatomic, weak) UIImageView *avaterImageView;
@property (nonatomic, weak) UILabel *moneyLable;
@property (nonatomic, weak) UIImageView *redpackImageView;

@property (nonatomic, strong) NSMutableArray *redPacks;
@property (nonatomic, assign) NSInteger recodRedPick;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation RedPackRainView

- (void)dealloc {
    NSLog(@"%@-释放了",self.class);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initDate];
        [self addViews];
        [self addViewsConstraints];
    }
    return self;
}

- (void)initDate {
    self.redPackRainNumber = 0.4;
    self.redPackRainSpeed = 4.5;
    self.redPackRotate = NO;
    self.redPackRainSequence = NO;
}

- (void)addViews {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:kImage_Home_RedPack_Grabredpack_Background];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    _imageView = imageView;
    
    UIImageView *numberBackGround = [[UIImageView alloc] initWithImage:kImage_Home_RedPack_Countdown];
    [self addSubview:numberBackGround];
    _numberBackGround = numberBackGround;
    
    UIImageView *numberOneImageView = [[UIImageView alloc] initWithImage:kImage_Home_RedPack_3];
    numberOneImageView.animationImages = @[kImage_Home_RedPack_3,kImage_Home_RedPack_2,kImage_Home_RedPack_1];
    numberOneImageView.animationDuration = 3;
    numberOneImageView.animationRepeatCount = 1;
    [numberBackGround addSubview:numberOneImageView];
    _numberOneImageView = numberOneImageView;
    
    UIView *redRainView = [UIView new];
    redRainView.userInteractionEnabled = YES;
    redRainView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    redRainView.backgroundColor = [UIColor clearColor];
    [self addSubview:redRainView];
    _redRainView = redRainView;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRed:)];
    [redRainView addGestureRecognizer:tap];
    
    UIView *openRedPackView = [UIView new];
    openRedPackView.hidden = YES;
    openRedPackView.userInteractionEnabled = YES;
    openRedPackView.backgroundColor = [UIColor clearColor];
    [self addSubview:openRedPackView];
    _openRedPackView = openRedPackView;
    
    UIImageView *avaterImageView = [[UIImageView alloc] initWithImage:kImage_Home_RedPack_Began_button];
    [openRedPackView addSubview:avaterImageView];
    _avaterImageView = avaterImageView;
    
    UILabel *moneyLable = [UILabel new];
    moneyLable.text = @"+24.19";
    moneyLable.font = [UIFont systemFontOfSize:13];
    moneyLable.textColor = [UIColor redColor];
    [openRedPackView addSubview:moneyLable];
    _moneyLable = moneyLable;
    
    UIImageView *redpackImageView = [[UIImageView alloc] initWithImage:kImage_Home_RedPack_Open];
    [openRedPackView addSubview:redpackImageView];
    _redpackImageView = redpackImageView;
}

- (void)addViewsConstraints {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_numberBackGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(_imageView);
        make.width.height.mas_equalTo(kViewScale(178));
    }];
    
    [_numberOneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_numberBackGround);
    }];
    
    [_openRedPackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.offset(0);
        make.width.mas_equalTo(kViewScale(kScreenWidth));
        make.height.mas_equalTo(kViewScale(210));
    }];
    
    [_avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_openRedPackView);
        make.top.equalTo(_openRedPackView);
        make.height.width.mas_equalTo(kViewScale(60));
    }];
    
    [_moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avaterImageView.mas_bottom).offset(kViewScale(1));
        make.centerX.equalTo(_avaterImageView);
    }];
    
    [_redpackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLable.mas_bottom);
        make.centerX.equalTo(_moneyLable);
        make.width.mas_equalTo(kViewScale(80));
        make.height.mas_equalTo(kViewScale(93));
    }];
}

- (void)showRedPackRain {
    UIImageView *imageV;
    if (_redPacks.count <= 25) {
        imageV = [UIImageView new];
        [self.redRainView addSubview:imageV];
        [self.redPacks addObject:imageV];
    }else {
        imageV = _redPacks[_recodRedPick];
        imageV.layer.opacity = 1;
    }
    
    NSArray *redPacks = @[kImage_Home_RedPack_Medium
                          ,kImage_Home_RedPack_Small
                          ,kImage_Home_RedPack_Big];
    imageV.image = redPacks[arc4random() % 3];
    imageV.frame = CGRectMake(0, kScreenHeight + imageV.image.size.height, imageV.image.size.width, imageV.image.size.height);
    [self addAnimationWith:imageV.layer];
    
    _recodRedPick++;
    if (_recodRedPick > 25) {
        _recodRedPick = 0;
    }
}

- (void)addAnimationWith:(CALayer *)moveLayer {
    CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    double scrollX = 0.f;
    scrollX = arc4random() % (int)kScreenWidth;
    if (scrollX == 0) {
        scrollX = scrollX + CGRectGetWidth(moveLayer.frame) + 5;
    }else if (scrollX == kScreenWidth) {
        scrollX = kScreenWidth - CGRectGetWidth(moveLayer.frame) - 5;
    }
    
    NSValue *A = [NSValue valueWithCGPoint:CGPointMake(scrollX, 0)];
    NSValue *B = [NSValue valueWithCGPoint:CGPointMake(self.redPackRainSequence ? scrollX : arc4random() % (int)kScreenWidth, kScreenHeight + 100)];
    moveAnimation.values = @[A,B];
    moveAnimation.duration = self.redPackRainSpeed;
    moveAnimation.repeatCount = 1;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [moveLayer addAnimation:moveAnimation forKey:nil];
    
    CAKeyframeAnimation * tranAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D r0 = CATransform3DMakeRotation(M_PI/180 * (arc4random() % 360 ) , 0, 0, -1);
    tranAnimation.values = @[[NSValue valueWithCATransform3D:r0]];
    tranAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tranAnimation.duration = arc4random() % 200 / 100.0 + 3.5;
//    为了避免旋转动画完成后再次回到初始状态。
    [tranAnimation setFillMode:kCAFillModeForwards];
    [tranAnimation setRemovedOnCompletion:NO];
    if (self.redPackRotate) {
        [moveLayer addAnimation:tranAnimation forKey:nil];
    }
}

- (void)endAnimation {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeAllAnimations];
    }];
}

- (void)clickRed:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.redRainView];
    [self.redRainView.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *layer = obj;
        if ([[layer presentationLayer] hitTest:point] || [[layer modelLayer] hitTest:point]) {
            NSLog(@"%ld",idx);
            self.openRedPackView.hidden = NO;
            self.openRedPackView.alpha = 1;
            self.openRedPackView.center = point;
            layer.opacity = 0;
            [UIView animateWithDuration:0.6 animations:^{
                self.openRedPackView.alpha = 0;
                self.openRedPackView.center = CGPointMake(point.x, point.y - 100);
            } completion:^(BOOL finished) {
                self.openRedPackView.hidden = YES;
            }];
            *stop = YES;
        }
    }];
}

- (void)onTimer {
    [UIView animateWithDuration:.3 animations:^{
        self.numberOneImageView.alpha = 0;
        self.numberBackGround.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        kWeakSelf
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.redPackRainNumber repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf showRedPackRain];
        }];
    }];
}
#pragma mark - Getter & Setter
- (void)setBegin:(BOOL)begin {
    _begin = begin;
    if (begin) {
        [_numberOneImageView startAnimating];
        kWeakSelf
        if (@available(iOS 10.0, *)) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:2.7 repeats:YES block:^(NSTimer * _Nonnull timer) {
                [weakSelf onTimer];
            }];
        } else {
            // Fallback on earlier versions
        }
    }else {
        [self endAnimation];
    }
}

- (NSMutableArray *)redPacks {
    if (!_redPacks) {
        _redPacks = [NSMutableArray array];
    }
    return _redPacks;
}

@end
