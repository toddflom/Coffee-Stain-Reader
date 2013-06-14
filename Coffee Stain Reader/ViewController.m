//
//  ViewController.m
//  Coffee Stain Reader
//
//  Created by Todd Flom on 6/14/13.
//  Copyright (c) 2013 Carmichael Lynch. All rights reserved.
//

static const CGFloat kNavBarHeight = 52.0f;
static const CGFloat kLabelHeight = 14.0f;
static const CGFloat kMargin = 10.0f;
static const CGFloat kSpacer = 2.0f;
static const CGFloat kLabelFontSize = 12.0f;
static const CGFloat kAddressHeight = 26.0f;



#import "ViewController.h"

@interface ViewController () {

    CGRect navBarFrame;
}

- (void) loadAddress:(id)sender event:(UIEvent *)event;
- (void) updateTitle:(UIWebView *)aWebView;

@end





@implementation ViewController


@synthesize webView = mWebView;
@synthesize toolbar = mToolbar;
@synthesize back = mBack;
@synthesize stop = mStop;
@synthesize refresh = mRefresh;
@synthesize forward = mForward;
@synthesize pageTitle = mPageTitle;
@synthesize addressField = mAddressField;



- (void) viewDidLoad
{
    [super viewDidLoad];
    
    navBarFrame = self.view.bounds;
    navBarFrame.size.height = kNavBarHeight;
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:navBarFrame];
    //The autoresizing mask UIViewAutoresizingFlexibleWidth ensures that if the user rotates the device the navigation bar will expand or contract to fill the width of the screen.
    navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    CGRect labelFrame = CGRectMake(kMargin, kSpacer, navBar.bounds.size.width - 2 * kMargin, kLabelHeight);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = UITextAlignmentCenter;
    [navBar addSubview:label];
//    NSLog(@"label.frame = %@", NSStringFromCGRect(label.frame) );
    self.pageTitle = label;
    
    CGRect addressFrame = CGRectMake(kMargin, kSpacer * 2.0 + kLabelHeight, labelFrame.size.width, kAddressHeight);
    UITextField *address = [[UITextField alloc] initWithFrame:addressFrame];
    address.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    address.borderStyle = UITextBorderStyleRoundedRect;
    address.font = [UIFont systemFontOfSize:17];
    address.keyboardType = UIKeyboardTypeURL;
    address.autocapitalizationType = UITextAutocapitalizationTypeNone;
    address.clearButtonMode = UITextFieldViewModeWhileEditing;
    [address addTarget:self action:@selector(loadAddress:event:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [navBar addSubview:address];
//    NSLog(@"address.frame = %@", NSStringFromCGRect(address.frame) );
   self.addressField = address;
    
    [self.view addSubview:navBar];
    
    
    /* bullshit to check whether outlets are hooked up
     NSAssert(self.back, @"Unconnected IBOutlet 'back'");
     NSAssert(self.forward, @"Unconnected IBOutlet 'forward'");
     NSAssert(self.refresh, @"Unconnected IBOutlet 'refresh'");
     NSAssert(self.stop, @"Unconnected IBOutlet 'stop'");
     NSAssert(self.webView, @"Unconnected IBOutlet 'webView'");
     */
    
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
   
    NSURL *url = [NSURL URLWithString:@"http://iosdeveloperzone.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self updateButtons];

}


- (void) viewDidLayoutSubviews
{
    
    // viewDidLoad cant' get the size of any Outlets in IB
    
    CGRect webViewFrame = self.webView.frame;
    webViewFrame.origin.y = navBarFrame.origin.y + navBarFrame.size.height;
    webViewFrame.size.height = self.toolbar.frame.origin.y - webViewFrame.origin.y;
    [self.webView setFrame:webViewFrame];
  //  NSLog(@"webview frame = %@", NSStringFromCGRect(webViewFrame) );
    
    
}


- (void) loadAddress:(id)sender event:(UIEvent *)event
{
    NSString *urlString = self.addressField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url.scheme) {
        NSString *modifiedURLString = [NSString stringWithFormat:@"http://%@", urlString];
        url = [NSURL URLWithString:modifiedURLString];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (void) updateTitle:(UIWebView *)aWebView
{
    // The JavaScript expression document.title can be used to get the page title.
    NSString *pageTitle = [aWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    NSLog(@"pageTitle = %@", pageTitle);
    self.pageTitle.text = pageTitle;
}


#pragma mark -
#pragma mark UIWebViewDelegate protocol

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
    [self updateTitle:webView];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}


- (void) updateButtons
{
    self.forward.enabled = self.webView.canGoForward;
    self.back.enabled = self.webView.canGoBack;
    self.stop.enabled = self.webView.loading;
}










- (void)viewDidUnload
{
    [super viewDidUnload];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.webView = nil;
    self.toolbar = nil;
    self.back = nil;
    self.forward = nil;
    self.refresh = nil;
    self.stop = nil;
    self.pageTitle = nil;
    self.addressField = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
