#import "OakTextView.h"
#import <document/document.h>
#import <oak/debug.h>

@class OakDocumentView;

@protocol OakDocumentViewDelegate <NSObject>
- (void)documentViewDidUpdateStyle:(OakDocumentView*)documentView;
@end

PUBLIC @interface OakDocumentView : NSView
@property (nonatomic, weak) id<OakDocumentViewDelegate> delegate;
@property (nonatomic, readonly) OakTextView* textView;
@property (nonatomic) document::document_ptr const& document;
@property (nonatomic) BOOL hideStatusBar;
- (IBAction)toggleLineNumbers:(id)sender;
- (IBAction)takeThemeUUIDFrom:(id)sender;

- (void)setThemeWithUUID:(NSString*)themeUUID;

- (void)addAuxiliaryView:(NSView*)aView atEdge:(NSRectEdge)anEdge;
- (void)removeAuxiliaryView:(NSView*)aView;

- (IBAction)showSymbolChooser:(id)sender;

- (NSColor *)documentBackgroundColor;
@end
