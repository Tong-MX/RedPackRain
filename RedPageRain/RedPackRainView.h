//
//  RedPackRainView.h
//  RedPageRain
//
//  Created by 桐 on 2020/3/28.
//  Copyright © 2020 com.mt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedPackRainView : UIView

/// 是否开始红包雨
@property (nonatomic, assign) BOOL begin;

/// 红包雨速度 默认 4.5
@property (nonatomic, assign) NSTimeInterval redPackRainSpeed;

/// 红包雨数量多少 默认 0.4
@property (nonatomic, assign) NSTimeInterval redPackRainNumber;

/// 是否旋转红包 默认不旋转
@property (nonatomic, assign) BOOL redPackRotate;

/// 红包雨有序 排序还是无序排序 yes 有序 no 无序 默认无序
@property (nonatomic, assign) BOOL redPackRainSequence;

@end

NS_ASSUME_NONNULL_END
