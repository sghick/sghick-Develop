//
//  UIHeader.h
//  game
//
//  Created by 丁治文 on 15/7/12.
//  Copyright (c) 2015年 sumrise.com. All rights reserved.
//

#ifndef game_UIHeader_h
#define game_UIHeader_h

// 屏幕
#define SMScreen        [UIScreen mainScreen]
#define SMScreenBounds  SMScreen.bounds
#define SMScreenSize    SMScreenBounds.size
#define SMScreenWidth   SMScreenSize.width
#define SMScreenHeight  SMScreenSize.height

// 系统版本
#define SMSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
// 设备类型
#define SMDeviceType [UIDevice currentDevice].model
// 通知中心
#define SMNotiCenter [NSNotificationCenter defaultCenter]
// 沙盒
#define SMUserDefaults [NSUserDefaults standardUserDefaults]
// 是否4x屏幕尺寸
#define is4x ([[UIDevice currentDevice] sms_isIPhone4x])

//获取屏幕高比例(curScale = 568.0f 相对iPhone5s的)
#define SMHeightScale ({\
CGFloat heightScale = 1.0; \
CGFloat curScale = 568.0f;\
if([[UIDevice currentDevice] sms_isIphone6Plus]){ \
heightScale = 736/curScale;\
}else if([[UIDevice currentDevice] sms_isIPhone6]){ \
heightScale = 667/curScale;\
}else if([[UIDevice currentDevice] sms_isIPhone5x]){ \
heightScale = 568/curScale;\
}else if([[UIDevice currentDevice] sms_isIPhone4x]){ \
heightScale = 480/curScale;\
}\
heightScale;\
})

//获取屏幕宽比例(curScale = 568.0f 相对iPhone5s的)
#define SMWidthScale ({\
CGFloat widthScale = 1.0; \
CGFloat curScale = 320.0f;\
if([[UIDevice currentDevice] sms_isIphone6Plus]){ \
widthScale = 414/curScale;\
}else if([[UIDevice currentDevice] sms_isIPhone6]){ \
widthScale = 375/curScale;\
}else if([[UIDevice currentDevice] sms_isIPhone5x]){ \
widthScale = 320/curScale;\
}else if([[UIDevice currentDevice] sms_isIPhone4x]){ \
widthScale = 320/curScale;\
}\
widthScale;\
})

// 顶点不变，view按比例放大
#define SMAffineTransformMakeScaleWithTopfix(scale, view) (CGAffineTransformTranslate(CGAffineTransformMakeScale(scale, scale), 0, view.frame.size.height/2*(scale - 1)))

// 解决block里self循环引用
#define SMStrongify(...) \
rac_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")

#define SMWeakify(...) \
rac_keywordify \
metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)

#define SMWEAK_DECLEARE(name, object)  __weak __typeof__(object) name = object
#define SMSTRONG_DECLEARE(name, object)  __strong __typeof__(object) name = object


#endif
