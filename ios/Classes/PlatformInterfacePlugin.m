//
//  PlatformInterfacePlugin.m
//  PlatformInterface-CodeBuilder
//
//  Created by Majid Hatami on 6/3/20.
//  Copyright © 2020 Majid Hatami. All rights reserved.
//

#import "PlatformInterfacePlugin.h"


@implementation PlatformInterfacePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"io.marands.flutter/platform_interface"
            binaryMessenger:[registrar messenger]];
  PlatformInterfacePlugin* instance = [[PlatformInterfacePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"preferredLanguages" isEqualToString: call.method]) {
      NSMutableArray<NSString *> *array = [[NSMutableArray<NSString *> alloc] init];
      for(NSString *langId in [NSLocale preferredLanguages]) {
          NSLocale *locale = [NSLocale localeWithLocaleIdentifier: langId];
          if(locale != NULL) {
              NSString *value = [locale toJsonString];
              if(value != NULL)
                  [array addObject: value];
          } else {
              NSLog(@"Unable to parse languageId: %@ to NSLocale", langId);
          }
      }
      result(array);
  } else if([@"currentLocale" isEqualToString: call.method]){
      result([[NSLocale currentLocale] toJsonString]);
  } else {
      result(FlutterMethodNotImplemented);
  }
}

@end
