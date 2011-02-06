//
//  MainView.h
//  HelloTwitter
//
//  Created by Christopher White on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"

@interface MainView : UIView <UIWebViewDelegate, OACallDelegate> {
	UIWebView *webView;
}

@property(nonatomic, retain)	UIWebView *webView;

@end
