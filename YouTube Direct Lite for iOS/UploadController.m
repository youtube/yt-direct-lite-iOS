//
//  UploadController.m
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 10/18/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "UploadController.h"
#import "Utils.h"


static int const MAX_KEYWORD_LENGTH = 30;

@implementation UploadController

+ (NSString *)generateKeywordFromPlaylistId:(NSString *)playlistId {
  if (playlistId == nil)
    playlistId = @"";

  if ([playlistId hasPrefix:@"PL"])
    playlistId = [playlistId substringFromIndex:2];

  NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
  playlistId = [[playlistId componentsSeparatedByCharactersInSet:charactersToRemove]
      componentsJoinedByString:@""];
  playlistId = [DEFAULT_KEYWORD stringByAppendingString:playlistId];
  if ([playlistId length] > MAX_KEYWORD_LENGTH)
    playlistId = [playlistId substringToIndex:MAX_KEYWORD_LENGTH];

  return playlistId;
}
@end
