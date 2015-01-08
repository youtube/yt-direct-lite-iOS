YouTube Direct Lite for iOS
===========

The code is a reference implementation for an iOS application that captures video, uploads it to YouTube, and submits the video to a [YouTube Direct Lite](http://code.google.com/p/youtube-direct-lite/) instance.

For more information, you can read the [Youtube API blog post](http://apiblog.youtube.com/2013/08/heres-my-playlist-so-submit-video-maybe.html).

This application utilizes [YouTube Data API v3](https://developers.google.com/youtube/v3/), [YouTube iFrame Player API](https://developers.google.com/youtube/iframe_api_reference), [YouTube Resumable Uploads](https://developers.google.com/youtube/v3/guides/using_resumable_upload_protocol?hl=en) and [OAuth2](https://developers.google.com/youtube/v3/guides/authentication).

To use this application,

1) Enable the YouTube Data API

  - If you haven't already registered your application with the Google Cloud Console, then [set up a project and application in the Cloud Console](https://cloud.google.com/console#/flows/enableapi?apiid=youtube). The system guides you through the process of choosing or creating a project and registering a new application, and it automatically activates the API for you.

  - If you've already registered your application with the Cloud Console, then follow this procedure instead:

    - Go to the [Google Cloud Console](https://cloud.google.com/console).
    - Select a project.
    - In the sidebar on the left, select APIs & auth. In the displayed list of APIs, make sure the YouTube Data API status is set to ON.
    - In the sidebar on the left, select Registered apps.
    - Select an application.
    - In either case, you end up on the application's credentials page.

  - To find your application's client ID and client secret, and set a redirect URI, expand the OAuth 2.0 Client ID section.

  - Take note of the Client ID as you'll need to add it to your code later.

2) Install the Google Client Library

  - To use the [Google APIs Client Library for Objective-C](http://code.google.com/p/google-api-objectivec-client/) start by [downloading the source with SVN](http://code.google.com/p/google-api-objectivec-client/source/checkout).
```
    svn checkout http://google-api-objectivec-client.googlecode.com/svn/trunk/ google-api-objectivec-client-read-only
```
  - Make sure to keep google-api-objectivec-client-read-only folder at the same level as the yt-direct-lite folder or update Header Search Paths in XCode accourdingly.

3) Run the sample

  - After you have set up your Google API project, installed the Google API client library, and set up the sample source code, the sample is ready to run. You can run the sample using the iPhone simulator or use a configured device.

  - When running the sample on a simulator where no camera is available, the library is used instead. If needed, you can add videos to the library using the following steps:

    - Drag a video from Finder on to the simulator.
    - Click Done on the video in player.
    - Click Save Video to store the image in the library.
    - When the sample runs for the first time, you'll be prompted to log in to your Google account and approve access.      - Once authorized, select a video from your YouTube uploads, the library or record a video to upload it to YouTube.
    
![alt tag](http://2.bp.blogspot.com/-92ku38BbFbk/Ut7DXZ8yQrI/AAAAAAAAAnw/Nngo5lYkS38/s1600/Screen+Shot+2013-12-10+at+5.49.22+PM.png)

![alt tag](http://4.bp.blogspot.com/-yTWFgqRxwF0/Ut7DgbPtSiI/AAAAAAAAAn4/pupwHXQcghY/s1600/Screen+Shot+2014-01-09+at+3.25.52+PM.png)

![alt tag](http://2.bp.blogspot.com/-ZPaPkS_q9dM/Ut7Di6DTQ7I/AAAAAAAAAoA/5l-NhUsvjbE/s1600/Screen+Shot+2014-01-09+at+3.34.26+PM.png)
