#import <oak/misc.h>

PUBLIC @interface OakSubmenuController : NSObject <NSMenuDelegate>
+ (OakSubmenuController*)sharedInstance;
- (NSInteger)tagForSender:(id)aSender;
- (id)representedObjectForSender:(id)aSender;
@end
