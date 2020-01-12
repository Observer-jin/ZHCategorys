//
//  NSDateFormatter+formatter.m
//  categorys
//
//  Created by 焰炉何 on 16/7/20.
//  Copyright © 2016年 JZH. All rights reserved.
//

#import "NSDateFormatter+formatter.h"

@implementation NSDateFormatter (formatter)
+(id)dateFormatter{
    return [[self alloc] init];
}
+(id)dateFormatterWithFormat:(NSString *)dateFormat{
    NSDateFormatter * dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}
+(id)defaultDateFormatter{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end
