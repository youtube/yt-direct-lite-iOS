/*
 * Copyright (c) 2013 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */

#import "MainViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "VideoData.h"
#import "UploadController.h"
#import "VideoListViewController.h"
#import "Utils.h"


@implementation MainViewController

@synthesize youtubeService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Initialize the youtube service & load existing credentials from the keychain if available
  self.youtubeService = [[GTLServiceYouTube alloc] init];
  self.youtubeService.authorizer =
      [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                            clientID:kClientID
                                                        clientSecret:kClientSecret];
  if (![self isAuthorized]) {
    // Not yet authorized, request authorization and push the login UI onto the navigation stack.
    [[self navigationController] pushViewController:[self createAuthController] animated:YES];
  }
}


// Helper to check if user is authorized
- (BOOL)isAuthorized {
  return [((GTMOAuth2Authentication *)self.youtubeService.authorizer) canAuthorize];
}

// Creates the auth controller for authorizing access to YouTube.
- (GTMOAuth2ViewControllerTouch *)createAuthController
{
  GTMOAuth2ViewControllerTouch *authController;

  authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeYouTube
                                                              clientID:kClientID
                                                          clientSecret:kClientSecret
                                                      keychainItemName:kKeychainItemName
                                                              delegate:self
                                                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
  return authController;
}

// Handle completion of the authorization process, and updates the YouTube service
// with the new credentials.
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error {
  if (error != nil) {
    [Utils showAlert:@"Authentication Error" message:error.localizedDescription];
    self.youtubeService.authorizer = nil;
  } else {
    self.youtubeService.authorizer = authResult;
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  // Always display the camera UI.
  [self showList];
}

- (void)showList {
  VideoListViewController *listUI = [[VideoListViewController alloc] init];
  listUI.youtubeService = self.youtubeService;
  [[self navigationController] pushViewController:listUI animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)startOAuthFlow:(id)sender {
  GTMOAuth2ViewControllerTouch *viewController;

  viewController = [[GTMOAuth2ViewControllerTouch alloc]
      initWithScope:kGTLAuthScopeYouTube
           clientID:kClientID
       clientSecret:kClientSecret
   keychainItemName:kKeychainItemName
           delegate:self
   finishedSelector:@selector(viewController:finishedWithAuth:error:)];

  [[self navigationController] pushViewController:viewController animated:YES];
}

@end
