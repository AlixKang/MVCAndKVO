//
//  UITextField+DisablePaste.m
//  MVCAndKVO
//
//  Created by Alix.Kang on 5/6/15.
//  Copyright (c) 2015 Guanglu. All rights reserved.
//

#import "UITextField+DisablePaste.h"
#import <objc/runtime.h>

@implementation UITextField (DisablePaste)
static char *kTextFieldPasteDiabled;

+(void) load{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(canPerformAction:withSender:)),
                                   class_getInstanceMethod(self, @selector(canPerformMAction:withSender:)));
}

- (BOOL)pasteDisabled{
    return [objc_getAssociatedObject(self, kTextFieldPasteDiabled) boolValue];
}
- (void)setPasteDisabled:(BOOL)pasteDisabled{
    objc_setAssociatedObject(self, kTextFieldPasteDiabled, @(pasteDisabled), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)canPerformMAction:(SEL)action withSender:(id)sender{
    if (self.pasteDisabled && (action == @selector(paste:) || action == @selector(cut:))) {
        return NO;
    }
    return [self canPerformMAction:action withSender:sender];
}
@end
