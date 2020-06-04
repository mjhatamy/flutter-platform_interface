//
//  NSLocale+Extension.m
//  PlatformInterface-CodeBuilder
//
//  Created by Majid Hatami on 6/3/20.
//  Copyright © 2020 Majid Hatami. All rights reserved.
//

#import "NSLocale+Extension.h"

@implementation NSLocale (Extension)

- (NSString *) toJsonString {
    NSString *countryCode = [self countryCode];//[[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSString *languageCode = [self languageCode];//[[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
    NSString *scriptCode = [self scriptCode];
    NSMutableDictionary *contentDictionary = [[NSMutableDictionary alloc]init];
    
    if(languageCode != nil)
        [contentDictionary setValue: languageCode forKey: @"languageCode"];
    if(countryCode != nil)
        [contentDictionary setValue: countryCode forKey: @"countryCode"];
    if(scriptCode != nil)
        [contentDictionary setValue: scriptCode forKey: @"scriptCode"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: contentDictionary // Here you can pass array or dictionary
                        options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                        error: &error];
    
    if(error != NULL) {
        NSLog(@"NSJSONSerialization Failed error: %@", error.localizedDescription);
        return @"{}";
    }
    
    NSString *jsonString;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
    } else {
        NSLog(@"Got an error: %@", error);
        jsonString = @"{}";
    }
    return jsonString;
}

@end
