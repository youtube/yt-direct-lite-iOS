//
//  VideoPlayerViewController.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/5/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoData.h"
#import "YouTubeDirectTag.h"

@interface VideoPlayerViewController : UIViewController<YouTubeDirectTagDelegate, UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) VideoData *videoData;
@property(nonatomic, retain) GTLServiceYouTube *youtubeService;
@property(nonatomic, strong) YouTubeDirectTag *directTag;
@end