#import <OakAppKit/OakTabBarView.h>
#import <OakTextView/OakDocumentView.h>

@interface ProjectLayoutView : NSView
@property (nonatomic) OakTabBarView* tabBarView;
@property (nonatomic) OakDocumentView* documentView;
@property (nonatomic) NSView* fileBrowserView;
@property (nonatomic) NSView* fileBrowserHeaderView;
@property (nonatomic) NSView* htmlOutputView;

@property (nonatomic) CGFloat fileBrowserWidth;
@property (nonatomic) BOOL fileBrowserOnRight;

@property (nonatomic) NSSize htmlOutputSize;
@property (nonatomic) BOOL htmlOutputOnRight;
@property (nonatomic) BOOL tabsAboveDocument;
@end
