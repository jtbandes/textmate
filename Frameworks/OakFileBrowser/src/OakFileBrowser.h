#import <oak/debug.h>

PUBLIC extern NSString* const kUserDefaultsFileBrowserWidthKey;

@class OakFileBrowser;
@class OakFileBrowserView;
@class OakHistoryController;
@class FSOutlineViewDelegate;

@protocol OakFileBrowserDelegate
- (void)fileBrowser:(OakFileBrowser*)aFileBrowser openURLs:(NSArray*)someURLs;
- (void)fileBrowser:(OakFileBrowser*)aFileBrowser closeURL:(NSURL*)anURL;
@end

@protocol OFBOutlineViewMenuDelegate // private/internal -- from ui/OFBOutlineView.h
- (NSMenu*)menuForOutlineView:(NSOutlineView*)anOutlineView;
@end

PUBLIC @interface OakFileBrowser : NSResponder <OFBOutlineViewMenuDelegate>
@property (nonatomic, assign) id <OakFileBrowserDelegate> delegate;
@property (nonatomic, retain, readonly) NSView* view;

@property (nonatomic, readonly) NSString*     location;
@property (nonatomic, readonly) NSArray*      selectedURLs;
@property (nonatomic, retain)   NSArray*      openURLs;
@property (nonatomic, retain)   NSArray*      modifiedURLs;
@property (nonatomic, readonly) NSDictionary* sessionState;

- (void)setupViewWithSize:(NSSize)viewSize resizeIndicatorOnRight:(BOOL)flag state:(NSDictionary*)fileBrowserState;
- (void)showURL:(NSURL*)aPath;
- (void)deselectAll:(id)sender;
- (void)updateVariables:(std::map<std::string, std::string>&)env;

- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)goToParentFolder:(id)sender;

- (IBAction)goToComputer:(id)sender;
- (IBAction)goToHome:(id)sender;
- (IBAction)goToDesktop:(id)sender;
- (IBAction)goToFavorites:(id)sender;
- (IBAction)goToSCMDataSource:(id)sender;
- (IBAction)orderFrontGoToFolder:(id)sender;
@end
