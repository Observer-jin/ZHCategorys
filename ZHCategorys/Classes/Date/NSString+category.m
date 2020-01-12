//
//  NSString+category.m
//  ios_crm
//
//  Created by jzh on 2018/12/6.
//  Copyright © 2018 jzh. All rights reserved.
//

#import "NSString+category.h"

@implementation NSString (category)
//时间转时间戳 精确到分钟
- (NSDate *)timesStringWithTimeFrom:(NSString *)timeStr{
    //@"1986-03-28 00:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *birthdayDate = [dateFormatter dateFromString:timeStr];
    return birthdayDate;
}


//时间转时间戳  精确到秒
- (NSDate *)timesStringWithTimeSecondFrom:(NSString *)timeStr{
    //@"1986-03-28 00:00:00.000";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *birthdayDate = [dateFormatter dateFromString:timeStr];
    return birthdayDate;
}


+(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}
+(NSString *)dateTimeStamp:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];

    return strDate;
}
    
-(NSString *)convertToJsonData:(NSDictionary *)dict{
        
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}



- (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateA =[self timesStringWithTimeFrom:oneDay];
    NSDate *dateB = [self timesStringWithTimeFrom:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result ==NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
        //NSLog(@"Both dates are the same");
    return 0;
}





//时间戳 --> 时间 （毫秒/秒）
- (NSString *)stringToTimeWithTimeForm:(NSString *)timeForm{
    if (!self || [self isEqualToString:@""]) {
        return @"";
    }
    
    double time = self.length > 10 ? [self doubleValue]/1000 : [self doubleValue];
    
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    //时区设置
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
//    NSTimeInterval timeInterval = [zone secondsFromGMTForDate:myDate];// 以秒为单位返回当前时间与系统格林尼治时间的差
//    myDate = [myDate dateByAddingTimeInterval:timeInterval];// 然后把差的时间加上,就是当前系统准确的时间

    NSDateFormatter *formatter = [NSDateFormatter new];
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:timeForm];
    //将时间转换为字符串
    NSString *timeS = [formatter stringFromDate:myDate];
    return timeS;
}
- (NSString *)stringToTimeWithTimeDateMode:(SCDateMode)timeForm{
    if (!self || [self isEqualToString:@""]) {
        return @"";
    }
    NSString *timeS =[self stringToTimeWithTimeForm:[self dateModeBackForm:timeForm]];
    return timeS;
}

//时间 --> 时间戳 （返回毫秒）
- (NSString *)stringToTimestampWithTimeForm:(NSString *)timeForm{
    if (!self || [self isEqualToString:@""]) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //@"yyyy-MM-dd HH:mm:ss"
    [dateFormatter setDateFormat:timeForm];
    NSDate *birthdayDate = [dateFormatter dateFromString:self];
    
    //时区设置
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
//    NSTimeInterval timeInterval = [zone secondsFromGMTForDate:birthdayDate];// 以秒为单位返回当前时间与系统格林尼治时间的差
//    birthdayDate = [birthdayDate dateByAddingTimeInterval:timeInterval];// 然后把差的时间加上,就是当前系统准确的时间
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[birthdayDate timeIntervalSince1970]*1000];
    if ([timeSp isEqualToString:@"0"]) {
        timeSp = @"";
    }
    return timeSp;
}
- (NSString *)stringToTimestampWithTimeDateMode:(SCDateMode)timeForm{
    if (!self || [self isEqualToString:@""]) {
        return @"";
    }
    NSString *timeS =[self stringToTimestampWithTimeForm:[self dateModeBackForm:timeForm]];
    return timeS;
}

//时间 --> 时间 （改变时间格式）
- (NSString *)stringFromTimeForm:(NSString *)fromForm toTimeForm:(NSString *)toForm{
    NSString * toTimeTampString =[self stringToTimestampWithTimeForm:fromForm];
    NSString * toString = [toTimeTampString stringToTimeWithTimeForm:toForm];
    return toString;
}
- (NSString *)stringFromTimeDateMode:(SCDateMode)fromDateMode toTimeDateMode:(SCDateMode)toDateMode{
    NSString * toTimeTampString = [self stringToTimestampWithTimeDateMode:fromDateMode];
    NSString * toString = [toTimeTampString stringToTimeWithTimeDateMode:toDateMode];
    return toString;
}

- (NSString *)dateModeBackForm:(SCDateMode)dateMode{
    switch (dateMode) {
        case SCDateModeYear:
            return @"yyyy";
            break;
        case SCDateModeYearAndMonth:
            return @"yyyy-MM";
            break;
        case SCDateModeDate:
            return @"yyyy-MM-dd";
            break;
        case SCDateModeDateHour:
            return @"yyyy-MM-dd HH";
            break;
        case SCDateModeDateHourMinute:
            return @"yyyy-MM-dd HH:mm";
            break;
        case SCDateModeDateHourMinuteSecond:
            return @"yyyy-MM-dd HH:mm:ss";
            break;
        case SCDateModeTime:
            return @"HH:mm";
            break;
        case SCDateModeTimeAndSecond:
            return @"HH:mm:ss";
            break;
        case SCDateModeMinuteAndSecond:
            return @"mm:ss";
            break;
        default:
            return @"yyyy-MM-dd HH:mm:ss";
            break;
    }

}



- (NSDateComponents*)compareDate:(NSDate *)oneDate withAnotherDate:(NSDate *)anotherDate{
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:oneDate toDate:anotherDate options:0];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|
                                                   NSCalendarUnitMonth|
                                                   NSCalendarUnitDay|
                                                   NSCalendarUnitHour|
                                                   NSCalendarUnitMinute|
                                                   NSCalendarUnitSecond|
                                                   NSCalendarUnitWeekOfMonth|
                                                   NSCalendarUnitWeekday
                                          fromDate:oneDate toDate:anotherDate options:0];//NSDateComponents可以获取日期的详细信息，所有的信息获取是可配置的

    return comps;
}
@end
