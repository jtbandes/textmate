#import <oak/misc.h>

@class OakPasteboardSelectorTableViewHelper;

PUBLIC @interface OakPasteboardSelector : NSWindowController
+ (OakPasteboardSelector*)sharedInstance;
- (void)setIndex:(unsigned)index;
- (void)setEntries:(NSArray*)entries;

- (unsigned)showAtLocation:(NSPoint)aLocation;
- (void)setWidth:(CGFloat)width;
- (void)setPerformsActionOnSingleClick;
- (BOOL)shouldSendAction;
- (NSArray*)entries;
@end
