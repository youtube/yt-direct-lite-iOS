#import <UIKit/UIKit.h>
#import "YouTubeGetUploads.h"
#import "YouTubeUploadVideo.h"
#import "GTLYouTube.h"
#import "VideoData.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface VideoListViewController : UITableViewController<
    YouTubeGetUploadsDelegate,
    UISearchBarDelegate,
    UITableViewDataSource,
    UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *images;
@property(nonatomic, strong) NSArray *videos;
@property(nonatomic, strong) YouTubeGetUploads *getUploads;
@property (nonatomic, retain) GTLServiceYouTube *youtubeService;

@end
