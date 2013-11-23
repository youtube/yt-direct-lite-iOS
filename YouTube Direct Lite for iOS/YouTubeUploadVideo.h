//
//  YouTubeUploadVideo.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/6/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTLYouTube.h"

@protocol YouTubeUploadVideoDelegate;

@interface YouTubeUploadVideo : NSObject

@property(nonatomic, weak) id<YouTubeUploadVideoDelegate> delegate;

// Performs a G+ image search with the given query, will return
// by calling googlePlusImageSearch:didFinishWithResults: when completed.
- (void)uploadYouTubeVideoWithService:(GTLServiceYouTube *)service
                             fileData:(NSData*)fileData
                                title:(NSString*)title
                          description:(NSString*)description;

@end


// Delegate protocol for returning results from the Image Search API.
@protocol YouTubeUploadVideoDelegate<NSObject>

// Called when an image search completes. |results| will contain
// an array of NSDictionary containing keys for @"fullImage", @"thumbnail",
// @"author" and @"title".
- (void)uploadYouTubeVideo:(YouTubeUploadVideo *)uploadVideo
     didFinishWithResults:(GTLYouTubeVideo *)video;

@end

