//
//  ViewController.m
//  Coffee Stain Reader
//
//  Created by Todd Flom on 6/14/13.
//  Copyright (c) 2013 Carmichael Lynch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    

}

@end

@implementation ViewController


@synthesize webView = mWebView;
@synthesize toolbar = mToolbar;
@synthesize back = mBack;
@synthesize stop = mStop;
@synthesize refresh = mRefresh;
@synthesize forward = mForward;



- (void) viewDidLoad
{
    [super viewDidLoad];
    NSAssert(self.back, @"Unconnected IBOutlet 'back'");
    NSAssert(self.forward, @"Unconnected IBOutlet 'forward'");
    NSAssert(self.refresh, @"Unconnected IBOutlet 'refresh'");
    NSAssert(self.stop, @"Unconnected IBOutlet 'stop'");
    NSAssert(self.webView, @"Unconnected IBOutlet 'webView'");
    
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:@"http://iosdeveloperzone.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self updateButtons];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
