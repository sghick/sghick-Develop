//
//  WpCommon.h
//  WisdomPark
//
//  Created by 丁治文 on 15/3/11.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

// 共通方法
#ifndef WisdomPark_WpCommon_h
#define WisdomPark_WpCommon_h

// 无警告sendMessage
#define NoWarningPerformSelector(target, action, object) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[target performSelector:action withObject:object]; \
_Pragma("clang diagnostic pop") \

// 系统版本
#define WPSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
// 设备类型
#define WPDeviceType [UIDevice currentDevice].model

// 是否4x屏幕尺寸
#define is4x ([[UIDevice currentDevice] wps_isIPhone4x])

// 屏幕尺寸
#define WPWindowBounds                  ([[UIScreen mainScreen] bounds])
#define WPWindowOrigin                  (WPWindowBounds.origin)
#define WPWindowSize                    (WPWindowBounds.size)
#define WPWindowPortraitWidth           ((MIN(WPWindowBounds.size.width,WPWindowBounds.size.height))
#define WPPortraitWidthScale            ((CGFloat)WPWindowPortraitWidth/(CGFloat)320)

//获取屏幕高比例(curScale = 568.0f 相对iPhone5s的)
#define WPHeightScale ({\
CGFloat heightScale = 1.0; \
CGFloat curScale = 568.0f;\
if([[UIDevice currentDevice] wps_isIphone6Plus]){ \
heightScale = 736/curScale;\
}else if([[UIDevice currentDevice] wps_isIPhone6]){ \
heightScale = 667/curScale;\
}else if([[UIDevice currentDevice] wps_isIPhone5x]){ \
heightScale = 568/curScale;\
}else if([[UIDevice currentDevice] wps_isIPhone4x]){ \
heightScale = 480/curScale;\
}\
heightScale;\
})

//获取屏幕宽比例(curScale = 568.0f 相对iPhone5s的)
#define WPWidthScale ({\
CGFloat widthScale = 1.0; \
CGFloat curScale = 320.0f;\
if([[UIDevice currentDevice] wps_isIphone6Plus]){ \
widthScale = 414/curScale;\
}else if([[UIDevice currentDevice] wps_isIPhone6]){ \
widthScale = 375/curScale;\
}else if([[UIDevice currentDevice] wps_isIPhone5x]){ \
widthScale = 320/curScale;\
}else if([[UIDevice currentDevice] wps_isIPhone4x]){ \
widthScale = 320/curScale;\
}\
widthScale;\
})

//16进制转成color 带alpha
#define WPHexColorWithAlpha(hexColor,a)  (WPRGBColorWithAlpha(((hexColor & 0xFF0000) >> 16), ((hexColor & 0xFF00) >> 8), (hexColor & 0xFF), a))
//([UIColor colorWithRed:((hexColor & 0xFF0000) >> 16))/255.0 green:((hexColor & 0xFF00) >> 8))/255.0 blue:(hexColor & 0xFF)/255.0 alpha:a])
//16进制转成color
#define WPHexColor(hexColor) (WPHexColorWithAlpha(hexColor, 1.0))


// 忽视4x高的比例
#define WPWPHeightScale_Ignore4x ([[UIDevice currentDevice] wps_isIPhone4x]?1.0f:WPHeightScale)

// RGB颜色
#define WPRGBColorWithAlpha(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
// RGB颜色
#define WPRGBColor(r,g,b)  (WPRGBColorWithAlpha(r,g,b,1.0))

// 字符串转日期
#define WpStringToDate(dateString,formatString) ({NSDate * date = nil; NSDateFormatter * formatter = [[NSDateFormatter alloc] init];[formatter setDateFormat:(formatString)];date = [formatter dateFromString:(dateString)];date;})
// 日期转字符串
#define WpDateToString(date,formatString) ({NSString * dateString = nil; NSDateFormatter * formatter = [[NSDateFormatter alloc] init];[formatter setDateFormat:(formatString)];dateString = [formatter stringFromDate:(date)]; dateString;})
// 字符串日期格式化字符串
#define WpDateStringToString(dateString,formatString) WpDateToString(WpStringToDate(dateString, formatString), formatString)

// 判断是否为闰年
#define WpIsLeapYear(year) (wp_isLeapYear(year))

// 一天的时间戳
#define WpIntervalOfOneDay (60*60*24)

// 周
#define WpWeeks (@[@"星期", @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"])
// 阴历—月
#define WpLunarMonths (@[@"月份", @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月"])
// 阴历-日
#define WpLunarDays (@[@"日子", @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", \
                         @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", \
                         @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"])

// 顶点位置
#define WPTop (WPSystemVersion>7.0?0.0f:64.0f)
#define WPExtra (WPSystemVersion>7.0?64.0f:0.0f)

// 顶点不变，view按比例放大
#define WPAffineTransformMakeScaleWithTopfix(scale, view) (CGAffineTransformTranslate(CGAffineTransformMakeScale(scale, scale), 0, view.frame.size.height/2*(scale - 1)))

// 解决block里self循环引用
#define strongify(...) \
rac_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
metamacro_foreach(rac_strongify_,, __VA_ARGS__) \
_Pragma("clang diagnostic pop")

#define weakify(...) \
rac_keywordify \
metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)

#define WEAK_DECLEARE(name, object)  __weak __typeof__(object) name = object
#define STRONG_DECLEARE(name, object)  __strong __typeof__(object) name = object

#endif
