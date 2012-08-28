#import "GutterView.h"
#import <OakAppKit/OakView.h>
#import <editor/editor.h>
#import <buffer/buffer.h>
#import <theme/theme.h>
#import <document/document.h>

extern int32_t const NSWrapColumnWindowWidth;
extern int32_t const NSWrapColumnAskUser;
extern NSString* const kUserDefaultsDisableAntiAliasKey;

namespace bundles { struct item_t; typedef std::shared_ptr<item_t> item_ptr; }
namespace ng      { struct layout_t; }

@class OakTextView;
@class OakTimer;
@class OakChoiceMenu;

struct buffer_refresh_callback_t;

enum folding_state_t { kFoldingNone, kFoldingTop, kFoldingCollapsed, kFoldingBottom };

PUBLIC @interface OakTextView : OakView <NSTextInput, NSTextFieldDelegate>
@property (nonatomic, assign) document::document_ptr const& document;
@property (nonatomic, assign) theme_ptr const&              theme;
@property (nonatomic, retain) NSFont*                       font;
@property (nonatomic, assign) BOOL                          antiAlias;
@property (nonatomic, assign) size_t                        tabSize;
@property (nonatomic, assign) BOOL                          showInvisibles;
@property (nonatomic, assign) BOOL                          softWrap;
@property (nonatomic, assign) BOOL                          softTabs;

@property (nonatomic, readonly) BOOL                        hasMultiLineSelection;
@property (nonatomic, retain) NSString*                     selectionString;

@property (nonatomic, assign) BOOL                          isMacroRecording;

- (GVLineRecord const&)lineRecordForPosition:(CGFloat)yPos;
- (GVLineRecord const&)lineFragmentForLine:(NSUInteger)aLine column:(NSUInteger)aColumn;

- (NSPoint)positionForWindowUnderCaret;
- (scope::context_t const&)scope;
- (folding_state_t)foldingStateForLine:(NSUInteger)lineNumber;

- (IBAction)toggleMacroRecording:(id)sender;
- (IBAction)toggleFoldingAtLine:(NSUInteger)lineNumber recursive:(BOOL)flag;
- (IBAction)toggleShowInvisibles:(id)sender;

- (void)performBundleItem:(bundles::item_ptr const&)anItem;
@end
