//
//  SGKSettings.h
//  DemoStruts
//
//  Created by 丁治文 on 15/1/2.
//  Copyright (c) 2015年 SumRise. All rights reserved.
//

#ifndef DemoStruts_SGKSettings_h
#define DemoStruts_SGKSettings_h

#undef	__ON__
#define __ON__		(1)

#undef	__OFF__
#define __OFF__		(0)

// log开关
#define __SP_SWITCH_LOG__ ( __ON__ )

// log
#if __SP_SWITCH_LOG__
#define SpLog(a...) NSLog (a)
#else
#define SpLog(a...)
#endif

#define NoWarningPerformSelector(target, action, object) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[target performSelector:action withObject:object]; \
_Pragma("clang diagnostic pop") \

#endif
