//
//  NSLocale+Extension.h
//  PlatformInterface-CodeBuilder
//
//  Created by Majid Hatami on 6/3/20.
//  Copyright © 2020 Majid Hatami. All rights reserved.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN
@class PiLocale;

@interface NSLocale(Extension)

- (NSString *) toJsonString;
- (PiLocale *) toPiLocale;

@end

NS_ASSUME_NONNULL_END
