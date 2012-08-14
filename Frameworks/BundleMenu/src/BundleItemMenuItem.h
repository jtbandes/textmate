#import <bundles/bundles.h>

struct BundleItemMenuItemAlignment
{
	BundleItemMenuItemAlignment () : maxAlignmentWidth(0), maxRightWidth(0) {}
	CGFloat maxAlignmentWidth;
	CGFloat maxRightWidth;
};

@interface BundleItemMenuItem : NSMenuItem
{
	BOOL hasRightPart;
	BOOL drawsLeftBackground;
	NSSize leftSize;
	NSRange leftStringRange;
}
+ (BundleItemMenuItem*)menuItemWithBundleItem:(bundles::item_ptr const&)bundleItem alignmentData:(BundleItemMenuItemAlignment&)alignment;
- (void)updateAlignment:(BundleItemMenuItemAlignment&)alignment;
@end
