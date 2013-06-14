//
//  ViewController.h
//  Coffee Stain Reader
//
//  Created by Todd Flom on 6/14/13.
//  Copyright (c) 2013 Carmichael Lynch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *mWebView;
    UIToolbar *mToolbar;
    UIBarButtonItem *mBack;
    UIBarButtonItem *mStop;
    UIBarButtonItem *mRefresh;
    UIBarButtonItem *mForward;
}


@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *back;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *stop;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *forward;



@end
