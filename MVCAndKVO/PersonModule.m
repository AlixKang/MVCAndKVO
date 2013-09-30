//
//  PersonModule.m
//  MVCAndKVO
//
//  Created by Alix on 9/30/13.
//  Copyright (c) 2013 Guanglu. All rights reserved.
//

#import "PersonModule.h"

@interface NSDate (Year)
- (int)getYear;
@end
@implementation NSDate (Year)

- (int)getYear{
    NSDateFormatter* formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy";
    return [formatter stringFromDate:self].integerValue;
}

@end

@implementation PersonModule
- (void)setTelephone:(NSString *)telephone{
    // 判断有效性
    
    
}
- (void)setEmail:(NSString *)email{
    // 判断有效性
}
- (void)setAge:(int)age{
    
}

- (int)age{
    NSDate* now = [NSDate date];
    return [now getYear] - _birthday.getYear;
}
@end
