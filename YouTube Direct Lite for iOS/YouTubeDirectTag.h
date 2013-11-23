//
//  YouTubeDirectTag.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/6/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTLYouTube.h"
#import "VideoData.h"

@protocol YouTubeDirectTagDelegate;

@interface YouTubeDirectTag : NSObject

@property(nonatomic, weak) id<YouTubeDirectTagDelegate> delegate;

// Performs a G+ image search with the given query, will return
// by calling googlePlusImageSearch:didFinishWithResults: when completed.
- (void)directTagWithService:(GTLServiceYouTube *)service
                            videoData:(VideoData*)videoData;

@end


// Delegate protocol for returning results from the Image Search API.
@protocol YouTubeDirectTagDelegate<NSObject>

// Called when an image search completes. |results| will contain
// an array of NSDictionary containing keys for @"fullImage", @"thumbnail",
// @"author" and @"title".
- (void)directTag:(YouTubeDirectTag *)directTag
      didFinishWithResults:(GTLYouTubeVideo *)video;

@end

