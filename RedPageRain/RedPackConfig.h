//
//  RedPackConfig.h
//  RedPageRain
//
//  Created by 桐 on 2020/3/28.
//  Copyright © 2020 com.mt. All rights reserved.
//

#ifndef RedPackConfig_h
#define RedPackConfig_h

#define kWeakSelf   typeof(self) __weak weakSelf = self;

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kViewScale(num)  kIPhoneViewScale(num)
#define kIPhoneViewScale(num) ((kScreenWidth > kScreenHeight) ? iPhoneViewLandscapeScale(num) : iPhoneViewPortraitScale(num))

/// 通常 用于iPhone 竖版适配
#ifndef iPhoneViewPortraitScale
#define iPhoneViewPortraitScale(num) (((kScreenWidth < kScreenHeight) ? kScreenWidth : kScreenHeight)/375.0f * num)
#endif

/// 通常 用于iPhone 横版适配
#ifndef iPhoneViewLandscapeScale
#define iPhoneViewLandscapeScale(num) (((kScreenWidth > kScreenHeight) ? kScreenWidth : kScreenHeight)/667.0f * num)
#endif

#define  kImage_Home_RedPack_Grabredpack_Background                [UIImage imageNamed:@"icon_black_home_grabredpack_background"]

#define  kImage_Home_RedPack_Countdown [UIImage imageNamed:@"icon_yellow_home_redpack_countdown"]

#define  kImage_Home_RedPack_1 [UIImage imageNamed:@"icon_red_home_redpack1"]

#define  kImage_Home_RedPack_2 [UIImage imageNamed:@"icon_red_home_redpack2"]
#define  kImage_Home_RedPack_3 [UIImage imageNamed:@"icon_red_home_redpack3"]

#define  kImage_Home_RedPack_Grab [UIImage imageNamed:@"icon_red_home_grab_redpack"]

#define  kImage_Home_RedPack_Began_button  [UIImage imageNamed:@"icon_yellow_home_began_button"]

#define  kImage_Home_RedPack_Open  [UIImage imageNamed:@"icon_red_home_open_redpack"]

#define  kImage_Home_RedPack_Medium [UIImage imageNamed:@"icon_red_home_redpack_medium"]
#define  kImage_Home_RedPack_Small  [UIImage imageNamed:@"icon_red_home_redpack_small"]
#define  kImage_Home_RedPack_Big   [UIImage imageNamed:@"icon_red_home_redpack_big"]

#endif /* RedPackConfig_h */
