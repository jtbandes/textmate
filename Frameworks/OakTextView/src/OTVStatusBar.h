#import <OakAppKit/OakStatusBar.h>
#import <text/types.h>

@interface OTVStatusBar : OakStatusBar
- (void)setCaretPosition:(std::string const&)range;
@property (nonatomic, copy)   NSString* grammarName;
@property (nonatomic, copy)   NSString* symbolName;
@property (nonatomic, assign) BOOL overwriteMode;
@property (nonatomic, assign) BOOL isMacroRecording;
@property (nonatomic, assign) BOOL freehandedEditing;
@property (nonatomic, assign) BOOL softTabs;
@property (nonatomic, assign) int32_t tabSize;
@property (nonatomic, assign) BOOL showResizeThumb;

@property (nonatomic, assign) id delegate;
@end
