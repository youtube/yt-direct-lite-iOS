//
//  Utils.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/6/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const DEFAULT_KEYWORD = @"ytdl";
static NSString *const UPLOAD_PLAYLIST = @"Replace me with the playlist ID you want to upload into";

NSString *kClientID = @"Replace me with your project's Client ID";

NSString *kClientSecret = @"Replace me with your project's Client Secret";

@interface Utils : NSObject

+ (UIAlertView*)showWaitIndicator:(NSString *)title;
+ (void)showAlert:(NSString *)title message:(NSString *)message;
+ (NSString *)humanReadableFromYouTubeTime:(NSString *)youTubeTimeFormat;

@end
