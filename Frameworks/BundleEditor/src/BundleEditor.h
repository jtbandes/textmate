#include <document/document.h>
#include <bundles/bundles.h>

@class OakDocumentView;
@class PropertiesViewController;

namespace be { struct entry_t; typedef std::shared_ptr<entry_t> entry_ptr; } /* be */

PUBLIC @interface BundleEditor : NSWindowController <NSBrowserDelegate>
+ (BundleEditor*)sharedInstance;
- (void)revealBundleItem:(bundles::item_ptr const&)anItem;
- (IBAction)browserSelectionDidChange:(id)sender;
@end
