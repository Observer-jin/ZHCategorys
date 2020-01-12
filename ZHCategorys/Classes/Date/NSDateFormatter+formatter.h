//
//  NSDateFormatter+formatter.h
//  categorys
//
//  Created by 焰炉何 on 16/7/20.
//  Copyright © 2016年 JZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (formatter)
+(id)dateFormatter;
+(id)dateFormatterWithFormat:(NSString *)dateFormat;
+(id)defaultDateFormatter;
@end
