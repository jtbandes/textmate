#import <oak/debug.h>

@class HOStatusBar;

@interface HOBrowserView : NSView
{
	WebView* webView;
	HOStatusBar* statusBar;
}

@property (nonatomic, readonly) WebView* webView;
@property (nonatomic, retain) NSString* projectUUID;
- (void)setUpdatesProgress:(BOOL)flag;
@end
