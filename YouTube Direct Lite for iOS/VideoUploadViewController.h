//
//  VideoUploadViewController.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/5/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import "VideoData.h"
#import "YouTubeUploadVideo.h"

@interface VideoUploadViewController :
    UIViewController<YouTubeUploadVideoDelegate, UITextFieldDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSURL *videoUrl;
@property(nonatomic, retain) GTLServiceYouTube *youtubeService;
@property(nonatomic, retain) MPMoviePlayerController *player;
@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) UITextField *activeField;
@property(nonatomic, strong) YouTubeUploadVideo *uploadVideo;
@end