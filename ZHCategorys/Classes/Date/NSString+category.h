//
//  NSString+category.h
//  ios_crm
//
//  Created by jzh on 2018/12/6.
//  Copyright © 2018 jzh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SCDateMode) {
    SCDateModeYear = 0,              //年
    SCDateModeYearAndMonth,          //年月
    SCDateModeDate,                  //年月日
    SCDateModeDateHour,              //年月日时
    SCDateModeDateHourMinute,        //年月日时分
    SCDateModeDateHourMinuteSecond,  //年月日时分秒
    SCDateModeTime,                  //时分
    SCDateModeTimeAndSecond,         //时分秒
    SCDateModeMinuteAndSecond,       //分秒
};

@interface NSString (category)
//时间转时间戳  精确到分钟
- (NSDate *)timesStringWithTimeFrom:(NSString *)timeStr;

//时间转时间戳  精确到秒
- (NSDate *)timesStringWithTimeSecondFrom:(NSString *)timeStr;


//时间转时间戳
+ (NSString *)dateConversionTimeStamp:(NSDate *)date;
//时间转时间戳
+ (NSString *)dateTimeStamp:(NSDate *)date;

//字典转json文本
- (NSString *)convertToJsonData:(NSDictionary *)dict;

//精确到分钟的时间字符串比较
- (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;






//时间戳 --> 时间 （毫秒/秒）
- (NSString *)stringToTimeWithTimeForm:(NSString *)timeForm;
- (NSString *)stringToTimeWithTimeDateMode:(SCDateMode)timeForm;

//时间 --> 时间戳 （返回毫秒）
- (NSString *)stringToTimestampWithTimeForm:(NSString *)timeForm;
- (NSString *)stringToTimestampWithTimeDateMode:(SCDateMode)timeForm;
//时间 --> 时间 （改变时间格式）
- (NSString *)stringFromTimeForm:(NSString *)fromForm toTimeForm:(NSString *)toForm;
- (NSString *)stringFromTimeDateMode:(SCDateMode)fromDateMode toTimeDateMode:(SCDateMode)toDateMode;


- (NSDateComponents*)compareDate:(NSDate *)oneDay withAnotherDate:(NSDate *)anotherDay;
@end

NS_ASSUME_NONNULL_END
