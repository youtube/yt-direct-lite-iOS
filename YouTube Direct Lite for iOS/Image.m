//
//  Image.m
//  ImageViewer
//
//  Created by Ibrahim Ulukaya on 9/17/13.
//
//

#import "Image.h"

@implementation Image : NSObject
- (id)initWithFullImage:(UIImage *)fullImage

              thumbnail:(UIImage *)thumbnail

                 author:(NSString *)author

                  title:(NSString *)title {
    
    self = [super init];
    
    if (self) {
        
        _fullImage = fullImage;
        
        _thumbnail = thumbnail;
        
        _author = author;
        
        _title = title;
        
    }
    
    return self;
    
}
@end
