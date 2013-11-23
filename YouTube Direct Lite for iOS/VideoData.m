//
//  VideoData.m
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 10/21/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "VideoData.h"

@implementation VideoData
-(NSString *)getYouTubeId {
    return _video.identifier;
}
-(NSString *)getTitle {
    return _video.snippet.title;
}
-(NSString *)getThumbUri {
    return _video.snippet.thumbnails.defaultProperty.url;
}
-(NSString *)getWatchUri {
    return [@"http://www.youtube.com/watch?v=" stringByAppendingString:self.getYouTubeId];
}
-(GTLYouTubeVideoSnippet *)addTags:(NSArray *)newTags {
    GTLYouTubeVideoSnippet *snippet = _video.snippet;
    NSArray *tags = snippet.tags;
    if (tags == nil){
        snippet.tags = newTags;
    }
    else {
        NSMutableArray *updateTags = [tags mutableCopy];
        [updateTags addObjectsFromArray:newTags];
        snippet.tags = updateTags;
    }
    return snippet;
}
@end
