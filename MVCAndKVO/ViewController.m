//
//  ViewController.m
//  MVCAndKVO
//
//  Created by Alix on 9/30/13.
//  Copyright (c) 2013 Guanglu. All rights reserved.
//

#import "ViewController.h"
#import "PersonModule.h"
#import "PersonView.h"

@interface ViewController () <PersonViewDatasource, PersonViewDelegate>

@property (nonatomic, strong) PersonView* personView;
@property (nonatomic, strong) PersonModule* personModule;
@end

@implementation ViewController

- (void)dealloc{
    [self removeObserver:_personModule forKeyPath:@"birthday"];
    _personModule = nil;
    _personView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (!_personView) _personView = [[PersonView alloc] initWithFrame:CGRectMake(10, 20, 300, 200)];
    _personView.datasource = self;
    _personView.delegate = self;
    
    if (!_personModule) _personModule = [PersonModule new];
    
    [self.view addSubview:_personView];
    self.view.backgroundColor = [UIColor grayColor];
    
    _personView.backgroundColor = [UIColor whiteColor];
    
    [_personView updatePersonName:_personModule.name
                          address:_personModule.address
                              age:_personModule.age
                            email:_personModule.email
                        telephone:_personModule.telephone];
    
    [_personModule addObserver:self forKeyPath:@"birthday" options:NSKeyValueObservingOptionNew context:NULL];
 }

- (NSString*)telephoneWithPersonView:(PersonView*)personView;{
    return @(rand()).description;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSDateFormatter* formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    int year = rand() % 1000 + 1000;
    NSString* dateString = [NSString stringWithFormat:@"%04d1010101010", year];
    _personModule.birthday = [formatter dateFromString:dateString];
    NSLog(@"pAge :%d", _personModule.age);
}
- (void)nameLabelWasClickedWithPersonView:(PersonView*)personView;{
    NSLog(@"%@ %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    _personModule.name = [NSString stringWithFormat:@"NAME:%d", rand() % 10];
}
#pragma mark - 
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    NSLog(@"%@ %@ %@", keyPath, object, change);
    if ([keyPath isEqualToString:@"birthday"] ||
        [object isEqual:_personModule]) {
        [_personView updatePersonName:_personModule.name
                              address:_personModule.address
                                  age:_personModule.age
                                email:_personModule.email
                            telephone:_personModule.telephone];
    }
}
@end
