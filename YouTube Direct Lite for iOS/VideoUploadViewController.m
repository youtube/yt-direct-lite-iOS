//
//  VideoUploadViewController.m
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/13/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "VideoUploadViewController.h"
#import "Utils.h"

UITextField *titleField;
UITextField *descField;

@interface VideoUploadViewController ()

@end

@implementation VideoUploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    _uploadVideo = [[YouTubeUploadVideo alloc] init];
    _uploadVideo.delegate = self;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 350, 520)];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    _player = [[MPMoviePlayerController alloc] initWithContentURL:_videoUrl];
    _player.view.frame = CGRectMake(0, 0, 350, 350);
    [_scrollView addSubview:_player.view];
    [_player play];
    
    titleField = [[UITextField alloc] initWithFrame:CGRectMake(0, 360, 200, 30)];
    titleField.borderStyle = UITextBorderStyleRoundedRect;
    titleField.placeholder = @"Title";
    titleField.autocorrectionType = UITextAutocorrectionTypeYes;
    titleField.keyboardType = UIKeyboardTypeDefault;
    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    titleField.delegate = self;
    [titleField setReturnKeyType:UIReturnKeyDone];
    
    descField = [[UITextField alloc] initWithFrame:CGRectMake(0, 400, 310, 30)];
    descField.borderStyle = UITextBorderStyleRoundedRect;
    descField.placeholder = @"Description";
    descField.autocorrectionType = UITextAutocorrectionTypeYes;
    descField.keyboardType = UIKeyboardTypeDefault;
    descField.clearButtonMode = UITextFieldViewModeWhileEditing;
    descField.delegate = self;
    [descField setReturnKeyType:UIReturnKeyDone];
    [descField resignFirstResponder];
    
    [_scrollView addSubview:titleField];
    
    [_scrollView addSubview:descField];
    
    UIBarButtonItem* uploadItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(uploadYTDL:)];
    uploadItem.title = @"Upload";
    self.toolbarItems = [ NSArray arrayWithObjects: uploadItem, nil ];
    
    [self registerForKeyboardNotifications];
    self.view = self.scrollView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)uploadYTDL:(id)sender{
    NSData *fileData = [NSData dataWithContentsOfURL:_videoUrl];
    NSString *title = titleField.text;
    NSString *description = descField.text;
    
    if ([title isEqualToString:@""])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"'Direct Lite Uploaded File ('EEEE MMMM d, YYYY h:mm a, zzz')"];
        title = [dateFormat stringFromDate:[NSDate date]];
    }
    if ([description isEqualToString:@""])
    {
        description = @"Uploaded from YouTube Direct Lite iOS";
    }

    [_uploadVideo uploadYouTubeVideoWithService:_youtubeService
                                       fileData:fileData
                                          title:title
                                    description:description];
}

#pragma mark - uploadYouTubeVideo

- (void)uploadYouTubeVideo:(YouTubeUploadVideo *)uploadVideo
      didFinishWithResults:(GTLYouTubeVideo *)video {
    [Utils showAlert:@"Video Uploaded" message:video.identifier];
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    _scrollView.contentInset = contentInsets;
//    _scrollView.scrollIndicatorInsets = contentInsets;
    [_scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = _activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [_activeField.superview setFrame:bkgndRect];
    [_scrollView setContentOffset:CGPointMake(0.0, _activeField.frame.origin.y-kbSize.height) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
