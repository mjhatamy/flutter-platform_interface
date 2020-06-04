//
//  ViewController.m
//  PlatformInterface-CodeBuilder
//
//  Created by Majid Hatami on 6/3/20.
//  Copyright © 2020 Majid Hatami. All rights reserved.
//

#import "ViewController.h"
#import "PlatformInterfacePlugin.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    FlutterMethodCall *call = [FlutterMethodCall methodCallWithMethodName:@"currentLocale" arguments:@""];
    [[PlatformInterfacePlugin alloc] handleMethodCall:call result:^(id  _Nullable result) {
        NSLog(@"Result: %@", result);
    }];
    
    
    FlutterMethodCall *call1 = [FlutterMethodCall methodCallWithMethodName:@"preferredLanguages" arguments:@""];
    [[PlatformInterfacePlugin alloc] handleMethodCall:call1 result:^(id  _Nullable result) {
        NSLog(@"preferredLanguages: %@", result);
    }];
}


@end
