//
//  YouTubeGetUploads.m
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 10/29/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "YouTubeGetUploads.h"
#import "VideoData.h"
#import "MainViewController.h"

// Thumbnail image size.
static const CGFloat kCropDimension = 70;

@implementation YouTubeGetUploads


- (void)getYouTubeUploadsWithService:(GTLServiceYouTube *)service {
    // Construct query
    GTLQueryYouTube *channelsListQuery = [GTLQueryYouTube
                                          
                                          queryForChannelsListWithPart:@"contentDetails"];
    
    channelsListQuery.mine = YES;
    
    // This callback uses the block syntax
    
    [service executeQuery:channelsListQuery
     
        completionHandler:^(GTLServiceTicket *ticket, GTLYouTubeChannelListResponse
                            
                            *response, NSError *error) {
            
            if (error) {
                [self.delegate getYouTubeUploads:self didFinishWithResults:nil];
                return;
            }
            
            NSLog(@"Finished API call");
            
            if ([[response items] count] > 0) {
                
                GTLYouTubeChannel *channel = response[0];
                
                NSString *uploadsPlaylistId =
                
                channel.contentDetails.relatedPlaylists.uploads;
                
                GTLQueryYouTube *playlistItemsListQuery = [GTLQueryYouTube queryForPlaylistItemsListWithPart:@"contentDetails"];
                playlistItemsListQuery.maxResults = 20l;
                playlistItemsListQuery.playlistId = uploadsPlaylistId;
                
                // This callback uses the block syntax
                
                [service executeQuery:playlistItemsListQuery
                 
                    completionHandler:^(GTLServiceTicket *ticket, GTLYouTubePlaylistItemListResponse
                                        
                                        *response, NSError *error) {
                        
                        if (error) {
                            [self.delegate getYouTubeUploads:self didFinishWithResults:nil];
                            return;
                        }
                        
                        NSLog(@"Finished API call");
                        
                        NSMutableArray *videoIds = [NSMutableArray arrayWithCapacity:response.items.count];
                        
                        for (GTLYouTubePlaylistItem *playlistItem in response.items) {
                            
                            [videoIds addObject:playlistItem.contentDetails.videoId];
                            
                        }
                        
                        GTLQueryYouTube *videosListQuery = [GTLQueryYouTube queryForVideosListWithPart:@"id,contentDetails,snippet,status,statistics"];
                        videosListQuery.identifier = [videoIds componentsJoinedByString: @","];
                        
                        
                        [service executeQuery:videosListQuery
                         
                            completionHandler:^(GTLServiceTicket *ticket, GTLYouTubeVideoListResponse
                                                
                                                *response, NSError *error) {
                                if (error) {
                                    [self.delegate getYouTubeUploads:self didFinishWithResults:nil];
                                    return;
                                }
                                
                                NSLog(@"Finished API call");
                                NSMutableArray *videos = [NSMutableArray arrayWithCapacity:response.items.count];
                                VideoData *vData;
                                
                                for (GTLYouTubeVideo *video in response.items){
                                    if ([@"public" isEqualToString:video.status.privacyStatus]){
                                        vData = [VideoData alloc];
                                        vData.video = video;
                                        [videos addObject:vData];
                                    }
                                }
                                
                                // Schedule an async job to fetch the image data for each result and
                                // resize the large image in to a smaller thumbnail.
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                                    NSMutableArray *removeThese = [NSMutableArray array];
                                    
                                    for (VideoData *vData in videos) {
                                        // Fetch synchronously the full sized image.
                                        NSURL *url = [NSURL URLWithString:vData.getThumbUri];
                                        NSData *imageData = [NSData dataWithContentsOfURL:url];
                                        UIImage *image = [UIImage imageWithData:imageData];
                                        if (!image) {
                                            [removeThese addObject:vData];
                                            continue;
                                        }
                                        vData.fullImage = image;
                                        // Create a thumbnail from the fullsized image.
                                        UIGraphicsBeginImageContext(CGSizeMake(kCropDimension,
                                                                               kCropDimension));
                                        [image drawInRect:
                                         CGRectMake(0, 0, kCropDimension, kCropDimension)];
                                        vData.thumbnail = UIGraphicsGetImageFromCurrentImageContext();
                                        UIGraphicsEndImageContext();
                                    }
                                    
                                    // Remove images that has no image data.
                                    [videos removeObjectsInArray:removeThese];
                                    
                                    // Once all the images have been fetched and cached, call
                                    // our delegate on the main thread.
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self.delegate getYouTubeUploads:self
                                                        didFinishWithResults:videos];
                                    });
                                });
                                
                            }];
                    }];
            }
            }];
}

@end
