#import <oak/debug.h>

@protocol OFBOutlineViewMenuDelegate;

@interface OFBOutlineView : NSOutlineView
@property (nonatomic, assign) id <OFBOutlineViewMenuDelegate> menuDelegate;
- (void)performEditSelectedRow:(id)sender;
@end
