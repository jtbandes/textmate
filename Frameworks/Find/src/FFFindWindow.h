@interface FFFindWindow : NSPanel
{
	IBOutlet NSView* collapsibleView;
	IBOutlet NSView* collapsibleViewPlaceholder;

	// Window resizing state
	NSSize shrinkedFindPanelSize;
	NSSize expandedFindPanelSize;
	CGFloat maxContentHeight;
}
@property (nonatomic, assign) BOOL isExpanded;
@end
