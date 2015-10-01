//
//  Utils.m
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/6/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "Utils.h"

@implementation Utils

// Helper for showing a wait indicator in a popup
+ (UIAlertView *)showWaitIndicator:(NSString *)title {
  UIAlertView *progressAlert;
  progressAlert = [[UIAlertView alloc] initWithTitle:title
                                             message:@"Please wait..."
                                            delegate:nil
                                   cancelButtonTitle:nil
                                   otherButtonTitles:nil];
  [progressAlert show];

  UIActivityIndicatorView *activityView;
  activityView = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
  activityView.center =
      CGPointMake(progressAlert.bounds.size.width / 2, progressAlert.bounds.size.height - 45);

  [progressAlert addSubview:activityView];
  [activityView startAnimating];
  return progressAlert;
}

// Helper for showing an alert
+ (void)showAlert:(NSString *)title message:(NSString *)message {
  UIAlertView *alert;
  alert = [[UIAlertView alloc] initWithTitle:title
                                     message:message
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil];
  [alert show];
}

+ (NSString *)humanReadableFromYouTubeTime:(NSString *)youTubeTimeFormat {
    NSRange range = NSMakeRange(0, youTubeTimeFormat.length);
    NSError *error = NULL;

    //    PT(((\d+)H)?(\d+)M)?(\d+)S
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"PT(((\\d+)H)?(\\d+)M)?(\\d+)S"
                                              options:NSRegularExpressionCaseInsensitive
                                                error:&error];
    NSArray *matches = [regex matchesInString:youTubeTimeFormat options:0 range:range];
    NSString *humanReadable = @"(Unknown)";
    for (NSTextCheckingResult *match in matches) {

        NSRange hourRange = [match rangeAtIndex:3];
        NSString *hourString=@"";
        if(hourRange.location!=NSNotFound){
            hourString = [youTubeTimeFormat substringWithRange:hourRange];
        }


        NSRange minuteRange = [match rangeAtIndex:4];
        NSString *minuteString=@"";
        if(minuteRange.location!=NSNotFound){
            minuteString = [youTubeTimeFormat substringWithRange:minuteRange];
        }
        NSRange secRange = [match rangeAtIndex:5];
        NSString *secString = [youTubeTimeFormat substringWithRange:secRange];
        humanReadable =
        [NSString stringWithFormat:@"%d:%02d:%02d",[hourString intValue], [minuteString intValue], [secString intValue]];


    }

    NSLog(@"Translated %@ to %@", youTubeTimeFormat, humanReadable);
    return humanReadable;
    
}

@end
