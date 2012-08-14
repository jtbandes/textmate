#import "BundleItemMenuItem.h"
#import <OakFoundation/NSString Additions.h>
#import <OakAppKit/NSColor Additions.h>
#import <ns/ns.h>

@interface BundleItemMenuItem ()
- (BundleItemMenuItem*)initWithBundleItem:(bundles::item_ptr const&)bundleItem alignmentData:(BundleItemMenuItemAlignment&)alignment;
- (void)setAttributedTitleWithTitle:(NSAttributedString*)itemTitle equivLeft:(NSAttributedString*)equivLeft equivRight:(NSAttributedString*)equivRight alignmentData:(BundleItemMenuItemAlignment&)alignment;
@end

@implementation BundleItemMenuItem
+ (BundleItemMenuItem*)menuItemWithBundleItem:(bundles::item_ptr const&)bundleItem alignmentData:(BundleItemMenuItemAlignment&)alignment
{
	return [[[self alloc] initWithBundleItem:bundleItem alignmentData:alignment] autorelease];
}

- (BundleItemMenuItem*)initWithBundleItem:(bundles::item_ptr const&)bundleItem alignmentData:(BundleItemMenuItemAlignment&)alignment
{
	if ((self = [super init]))
	{
		NSDictionary* fontAttrs = @{ NSFontAttributeName : [NSFont menuFontOfSize:14] /* passing 0 should return the default size, but it doesn’t */ };
		NSDictionary* smallFontAttrs = @{ NSFontAttributeName : [NSFont menuFontOfSize:11] };
		NSAttributedString* title = [[NSAttributedString alloc] initWithString:[NSString stringWithCxxString:bundleItem->name()] attributes:fontAttrs];
		NSAttributedString* equivLeft = nil;
		NSAttributedString* equivRight = nil;
	
		std::string const tabTrigger(bundleItem->value_for_field(bundles::kFieldTabTrigger));
		std::string const keyEquiv(bundleItem->value_for_field(bundles::kFieldKeyEquivalent));
	
		if(tabTrigger != NULL_STR)
		{
			equivLeft = [[[NSAttributedString alloc] initWithString:[NSString stringWithCxxString:(" "+tabTrigger+"\u21E5 ")] attributes:smallFontAttrs] autorelease];
			leftSize = [equivLeft size];
			drawsLeftBackground = YES;
		}
		else if(keyEquiv != NULL_STR)
		{
			size_t keyStart = 0;
			std::string const glyphStr(ns::glyphs_for_event_string(keyEquiv, &keyStart));
		
			equivLeft = [[[NSAttributedString alloc] initWithString:[NSString stringWithCxxString:glyphStr.substr(0, keyStart)] attributes:fontAttrs] autorelease];
			equivRight = [[[NSAttributedString alloc] initWithString:[NSString stringWithCxxString:glyphStr.substr(keyStart)] attributes:fontAttrs] autorelease];
		}
	
		[self setAttributedTitleWithTitle:title equivLeft:equivLeft equivRight:equivRight alignmentData:alignment];
	}
	
	return self;
}

- (void)setAttributedTitleWithTitle:(NSAttributedString*)itemTitle equivLeft:(NSAttributedString*)equivLeft equivRight:(NSAttributedString*)equivRight alignmentData:(BundleItemMenuItemAlignment&)alignment
{
	NSMutableAttributedString* title = [[[NSMutableAttributedString alloc] initWithAttributedString:itemTitle] autorelease];
	[title beginEditing];
	
	CGFloat alignmentWidth = [itemTitle size].width;
	CGFloat rightWidth = [equivRight size].width;
	CGFloat leftWidth = [equivLeft size].width;
	
	if(equivLeft)
	{
		[title appendAttributedString:[[[NSAttributedString alloc] initWithString:@"\t"] autorelease]];
		leftStringRange = NSMakeRange([title length], [equivLeft length]);
		[title appendAttributedString:equivLeft];
		
		alignmentWidth += leftWidth + 20;
		
		if(equivRight)
		{
			[title appendAttributedString:[[[NSAttributedString alloc] initWithString:@"\t"] autorelease]];
			[title appendAttributedString:equivRight];
			hasRightPart = YES;
		}
	}
	
	if(alignmentWidth > alignment.maxAlignmentWidth)
		alignment.maxAlignmentWidth = alignmentWidth;
	
	if(rightWidth > alignment.maxRightWidth)
		alignment.maxRightWidth = rightWidth;

	[title endEditing];
	[self setAttributedTitle:title];
}

- (void)updateAlignment:(BundleItemMenuItemAlignment&)alignment
{
	NSMutableParagraphStyle* pStyle = [[NSMutableParagraphStyle new] autorelease];
	if(hasRightPart)
	{
		[pStyle setTabStops:@[
			[[[NSTextTab alloc] initWithType:NSRightTabStopType location:alignment.maxAlignmentWidth] autorelease],
			[[[NSTextTab alloc] initWithType:NSLeftTabStopType location:alignment.maxAlignmentWidth + 0.01] autorelease]
		]];
	}
	else
	{
		[pStyle setTabStops:@[
			[[[NSTextTab alloc] initWithType:NSRightTabStopType location:alignment.maxAlignmentWidth + alignment.maxRightWidth] autorelease]
		]];
	}
	
	NSMutableAttributedString* title = [[self attributedTitle] mutableCopy];
	[title addAttribute:NSParagraphStyleAttributeName value:pStyle range:NSMakeRange(0, [title length])];
	if(drawsLeftBackground)
	{
		NSRect leftRect = NSZeroRect;
		leftRect.size = leftSize;
		leftRect.origin.x = 22 + [[title attributedSubstringFromRange:NSMakeRange(0, leftStringRange.location)] size].width - leftSize.width;
		
		NSColor* color = [NSColor roundedRectPatternColorWithFillColor:[NSColor colorWithCalibratedWhite:0 alpha:0.15]
		                  size:leftRect.size offset:leftRect.origin xRadius:4 yRadius:4];
		
		if(color)
			[title addAttribute:NSBackgroundColorAttributeName value:color range:leftStringRange];
	}
	
	[self setAttributedTitle:title];
}
@end
