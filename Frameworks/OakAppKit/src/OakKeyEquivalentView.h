#import "OakView.h"
#import <oak/misc.h>

PUBLIC @interface OakKeyEquivalentView : OakView
@property (nonatomic, retain) NSString* eventString;
@property (nonatomic, assign) BOOL disableGlobalHotkeys;
@property (nonatomic, assign) BOOL recording;
@end
