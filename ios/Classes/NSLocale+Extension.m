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
    NSString *countryCode;//[[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    if (@available(iOS 10.0, *)) {
        countryCode = [self countryCode];
    } else {
        countryCode = [self objectForKey: NSLocaleCountryCode];
    }
    NSString *languageCode;//[[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
    if (@available(iOS 10.0, *)) {
        languageCode = [self languageCode];
    } else {
        languageCode = [self objectForKey: NSLocaleLanguageCode];
    }
    NSString *scriptCode;
    if (@available(iOS 10.0, *)) {
        scriptCode = [self scriptCode];
    } else {
        languageCode = [self objectForKey: NSLocaleScriptCode];
    }
    NSMutableDictionary *contentDictionary = [[NSMutableDictionary alloc]init];
    
    if(languageCode != nil)
        [contentDictionary setValue: languageCode forKey: @"languageCode"];
    if(countryCode != nil)
        [contentDictionary setValue: countryCode forKey: @"countryCode"];
    if(scriptCode != nil)
        [contentDictionary setValue: scriptCode forKey: @"scriptCode"];
    
    if(contentDictionary.count <= 0 ) {
        NSLog(@"contentDictionary has no value.... NSLocale returned no valid value for languageCode and countryCode and scriptCode\n");
        return @"{}";
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: contentDictionary // Here you can pass array or dictionary
                        options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                        error: &error];
    
    if(error != NULL) {
        NSLog(@"\nNSJSONSerialization Failed error: %@\n", error.localizedDescription);
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
