//
//  PersonView.h
//  MVCAndKVO
//
//  Created by Alix on 9/30/13.
//  Copyright (c) 2013 Guanglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonView;
@protocol PersonViewDatasource <NSObject>

- (NSString*)telephoneWithPersonView:(PersonView*)personView;

@optional
- (NSString*)nameWithPersonView:(PersonView*)personView;

@optional
- (int)ageWithPersonView:(PersonView*)personView;

@end
#pragma mark - 
@protocol PersonViewDelegate <NSObject>

@optional
- (void)nameLabelWasClickedWithPersonView:(PersonView*)personView;

@end



@interface PersonView : UIView

@property (nonatomic, weak) id<PersonViewDatasource> datasource;
@property (nonatomic, weak) id<PersonViewDelegate> delegate;

/**
 * 刷新显示结果
 */
- (void)updatePersonName:(NSString*)name
                 address:(NSString*)address
                     age:(int)age
                   email:(NSString*)email
               telephone:(NSString*)telephone;
@end
