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
    return [formatter stringFromDate:self].intValue;
}

@end

@implementation PersonModule
- (void)setTelephone:(NSString *)telephone{
    if ([_telephone isEqualToString:telephone]) {
        return;
    }
    // 判断有效性
    NSString* expression = @"[1]{1}[358]{1}[0-9]{9}";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    if (error) {
        return;
    }
    NSTextCheckingResult *match = [regex firstMatchInString:telephone
                                                    options:0
                                                      range:NSMakeRange(0, telephone.length)];
    
    if (match){
        _telephone = telephone;
    }
}
- (void)setEmail:(NSString *)email{
    if ([_email isEqualToString:email]) {
        return;
    }
    // 判断有效性
    NSString *expression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    if (error) {
        return;
    }
    NSTextCheckingResult *match = [regex firstMatchInString:email
                                                    options:0
                                                      range:NSMakeRange(0, email.length)];
    
    if (match){
        _email = email;
    }
}
- (void)setBirthday:(NSDate *)birthday{
    if ([_birthday isEqual:birthday]) {
        return;
    }
    int year = birthday.getYear;
    int yearNow = [NSDate date].getYear;
    yearNow -= year;
    if (year > 0 && year < 125) {
        _birthday = birthday;
    }
}
- (int)age{
    NSDate* now = [NSDate date];
    return [now getYear] - _birthday.getYear;
}
@end
