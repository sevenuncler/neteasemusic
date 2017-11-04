//
//  Utils.h
//  DreamOneByOne
//
//  Created by netease on 16/11/11.
//  Copyright © 2016年 Sevenuncle. All rights reserved.
//

#ifndef Utils_h
#define Utils_h
#define SCREEN_FRAME    ([[UIScreen mainScreen] bounds])                        //屏幕Frame
#define SCREEN_SIZE     (SCREEN_FRAME.size)                                     //屏幕大小
#define SCREEN_HEIGHT   (SCREEN_SIZE.height)                                    //屏幕高度
#define SCREEN_WIDTH    (SCREEN_SIZE.width)                                     //屏幕宽度
#define APP_FRAME       ([[UIScreen mainScreen] applicationFrame])              //AppFrame
#define APP_SIZE        (APP_FRAME.size)
#define APP_WIDTH       (APP_SIZE.width)
#define APP_HEIGHT      (APP_SIZE.height)
#define we(src,dst)     __weak __typeof(src) dst = src
#define COLOR           ([UIColor colorWithRed:arc4random_uniform(255)/255.f green:arc4random_uniform(255)/255.f  blue:arc4random_uniform(255)/255.f  alpha:0.9])

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

//日志
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#endif /* Utils_h */
