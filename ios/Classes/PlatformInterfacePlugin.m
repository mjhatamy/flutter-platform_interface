//
//  PlatformInterfacePlugin.m
//  PlatformInterface-CodeBuilder
//
//  Created by Majid Hatami on 6/3/20.
//  Copyright © 2020 Majid Hatami. All rights reserved.
//

#import "PlatformInterfacePlugin.h"
#import "pigeon_platform_locale.h"

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
      NSMutableArray<NSDictionary *> *array = [[NSMutableArray<NSDictionary *> alloc] init];
      for(NSString *langId in [NSLocale preferredLanguages]) {
          NSLocale *locale = [NSLocale localeWithLocaleIdentifier: langId];
          if(locale != NULL) {
              PiLocale *value = [locale toPiLocale];
              if(value != NULL)
                  [array addObject: [value toMap]];
          } else {
              NSLog(@"Unable to parse languageId: %@ to NSLocale", langId);
          }
      }
      FlutterError *error;
      result(wrapResult2(array, error));
      //result(wrapResult([array toMap], error));
      //result(array);
  } else if([@"currentLocale" isEqualToString: call.method]){
      FlutterError *error;
      result(wrapResult( [[[NSLocale currentLocale] toPiLocale] toMap], error));
  } else {
      result(FlutterMethodNotImplemented);
  }
}

@end
