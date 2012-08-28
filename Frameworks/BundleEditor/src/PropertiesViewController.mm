#import "PropertiesViewController.h"

@implementation PropertiesViewController
{
	IBOutlet NSObjectController* objectController;
	IBOutlet NSView* alignmentView;
	IBOutlet OakKeyEquivalentView* keyEquivalentView;
	NSMutableDictionary* properties;
}

@synthesize properties;

- (id)initWithName:(NSString*)aName
{
	if((self = [super initWithNibName:aName bundle:[NSBundle bundleForClass:[self class]]]))
	{
		properties = [NSMutableDictionary new];
	}
	return self;
}

- (CGFloat)indent
{
	return alignmentView ? NSMaxX([alignmentView frame]) + 5 : 20;
}

- (NSDictionary*)properties
{
	[objectController commitEditing];
	return properties;
}

- (void)loadView
{
	[super loadView];
	[keyEquivalentView bind:@"value" toObject:objectController withKeyPath:@"selection.keyEquivalent" options:nil];
}
@end
