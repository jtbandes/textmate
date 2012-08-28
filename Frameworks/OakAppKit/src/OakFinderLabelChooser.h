#import <oak/debug.h>

PUBLIC @interface OakFinderLabelChooser : NSView
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) NSInteger selectedIndex;
@end
