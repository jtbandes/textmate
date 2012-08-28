#import "GutterView.h"
#import "OakTextView.h"
#import <document/document.h>
#import <oak/debug.h>

@class OTVStatusBar;

PUBLIC @interface OakDocumentView : NSView <GutterViewDelegate, GutterViewColumnDataSource, GutterViewColumnDelegate>
@property (nonatomic, readonly) OakTextView* textView;
@property (nonatomic, assign) document::document_ptr const& document;
@property (nonatomic, assign) BOOL showResizeThumb;
- (IBAction)toggleLineNumbers:(id)sender;
- (IBAction)takeThemeUUIDFrom:(id)sender;

- (void)setThemeWithUUID:(NSString*)themeUUID;

- (void)addAuxiliaryView:(NSView*)aView atEdge:(NSRectEdge)anEdge;
- (void)removeAuxiliaryView:(NSView*)aView;
@end
