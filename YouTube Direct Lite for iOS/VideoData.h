//
//  VideoData.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 10/21/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTLYouTube.h"

@interface VideoData : NSObject
    @property(nonatomic, strong) GTLYouTubeVideo *video;
    @property(nonatomic, strong) UIImage *thumbnail;
    @property(nonatomic, strong) UIImage *fullImage;

-(NSString *)getYouTubeId;
-(NSString *)getTitle;
-(NSString *)getThumbUri;
-(NSString *)getWatchUri;
-(NSString *)getDuration;
-(NSString *)getViews;
-(GTLYouTubeVideoSnippet *)addTags:(NSArray *)tags;
@end
