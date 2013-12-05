//
//  VideoPlayerViewController.m
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/5/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "UploadController.h"
#import "Utils.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  _directTag = [[YouTubeDirectTag alloc] init];
  _directTag.delegate = self;
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  NSError *error = nil;
  NSString *path = [[NSBundle mainBundle] pathForResource:@"iframe-player" ofType:@"html"];
  NSString *embedHTML =
      [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
  NSString *embedHTMLWithId = [NSString stringWithFormat:embedHTML, _videoData.getYouTubeId];

  self.webView = [[UIWebView alloc]
      initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  [self.webView loadHTMLString:embedHTMLWithId baseURL:[[NSBundle mainBundle] resourceURL]];
  [self.webView setDelegate:self];
  self.webView.allowsInlineMediaPlayback = YES;
  self.webView.mediaPlaybackRequiresUserAction = NO;

  [self.view addSubview:_webView];

  UIBarButtonItem *submitItem =
      [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                    target:self
                                                    action:@selector(submitYTDL:)];
  submitItem.title = @"Submit";
  self.toolbarItems = [NSArray arrayWithObjects:submitItem, nil];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  CGRect f = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
  self.webView.frame = f;
}

- (IBAction)submitYTDL:(id)sender {
  [self.directTag directTagWithService:_youtubeService videoData:_videoData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uploadYouTubeVideo

- (void)directTag:(YouTubeDirectTag *)directTag didFinishWithResults:(GTLYouTubeVideo *)video {
  [Utils showAlert:@"Tags Updates" message:[video.snippet.tags componentsJoinedByString:@""]];
}
@end
