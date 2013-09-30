//
//  PersonView.m
//  MVCAndKVO
//
//  Created by Alix on 9/30/13.
//  Copyright (c) 2013 Guanglu. All rights reserved.
//

#import "PersonView.h"




@interface PersonView ()

@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* addressLabel;
@property (nonatomic, strong) UILabel* ageLabel;
@property (nonatomic, strong) UILabel* emialLabel;
@property (nonatomic, strong) UILabel* telephoneLabel;

@end

@implementation PersonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        if (!_nameLabel) _nameLabel = [UILabel new];
        if (!_ageLabel) _ageLabel = [UILabel new];
        if (!_addressLabel) _addressLabel = [UILabel new];
        if (!_emialLabel) _emialLabel = [UILabel new];
        if (!_telephoneLabel) _telephoneLabel = [UILabel new];
        
        _nameLabel.backgroundColor = [UIColor orangeColor];
        
        [self addSubview:_nameLabel];
        [self addSubview:_addressLabel];
        [self addSubview:_emialLabel];
        [self addSubview:_telephoneLabel];
        [self addSubview:_ageLabel];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)updatePersonName:(NSString*)name
                 address:(NSString*)address
                     age:(int)age
                   email:(NSString*)email
               telephone:(NSString*)telephone;{
    
    _nameLabel.text = name;
    _addressLabel.text = address;
    _emialLabel.text = email;
    _telephoneLabel.text = telephone;
    _ageLabel.text = [NSString stringWithFormat:@"%d", age];
    
    [_nameLabel sizeToFit];
    [_addressLabel sizeToFit];
    [_emialLabel sizeToFit];
    [_telephoneLabel sizeToFit];
    [_ageLabel sizeToFit];
    
    
    _nameLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.2);
    _addressLabel.frame = CGRectMake(0, self.frame.size.height*0.2, self.frame.size.width, self.frame.size.height*0.2);
    _emialLabel.frame = CGRectMake(0, self.frame.size.height*0.4, self.frame.size.width, self.frame.size.height*0.2);
    _telephoneLabel.frame = CGRectMake(0, self.frame.size.height*0.6, self.frame.size.width, self.frame.size.height*0.2);
    _ageLabel.frame = CGRectMake(0, self.frame.size.height*0.8, self.frame.size.width, self.frame.size.height*0.2);
}
#pragma mark - 
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(_nameLabel.frame, touchLocation)) {
        if (_delegate && [_delegate respondsToSelector:@selector(nameLabelWasClickedWithPersonView:)]) {
            [_delegate nameLabelWasClickedWithPersonView:self];
        }
    }
    
    // 更新
    if (_datasource && [_datasource respondsToSelector:@selector(nameWithPersonView:)]) {
        _nameLabel.text = [_datasource nameWithPersonView:self];
    }
    
    _telephoneLabel.text = [_datasource telephoneWithPersonView:self];
    
}


@end
