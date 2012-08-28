#import <bundles/bundles.h>
#import <oak/debug.h>

PUBLIC @interface BundleMenuDelegate : NSObject <NSMenuDelegate>
- (id)initWithBundleItem:(bundles::item_ptr const&)aBundleItem;
@end
