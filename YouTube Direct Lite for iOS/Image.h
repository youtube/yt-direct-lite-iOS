//
//  Image.h
//  ImageViewer
//
//  Created by Ibrahim Ulukaya on 9/17/13.
//
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property(nonatomic, strong) UIImage *fullImage;

@property(nonatomic, strong) UIImage *thumbnail;

@property(nonatomic, copy) NSString *author;

@property(nonatomic, copy) NSString *title;

- (id)initWithFullImage:(UIImage *)fullImage
thumbnail:(UIImage *)thumbnail
author:(NSString *)author
                  title:(NSString *)title;
@end
