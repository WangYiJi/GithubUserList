//
//  Global.h
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#define AppDelegateEntity ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define DEF_RequestURL @"https://api.github.com/users"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define RGBA(r,g,b,a)                        [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define df_YearMonthDay_DF                  = @"yyyy-MM-dd";
#define df_HourMinuteSecond_DF              = @"HH:mm:ss";

#ifndef Global_h
#define Global_h


#endif /* Global_h */
