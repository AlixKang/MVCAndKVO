//
//  PersonModule.h
//  MVCAndKVO
//
//  Created by Alix on 9/30/13.
//  Copyright (c) 2013 Guanglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModule : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* telephone;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSDate*   birthday;
@property (nonatomic, assign, readonly) int age;
@end
