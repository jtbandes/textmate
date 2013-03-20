#import "OakRunCommandWindowController.h"
#import <OakFoundation/OakHistoryList.h>
#import <OakFoundation/OakFoundation.h>
#import <OakAppKit/OakUIConstructionFunctions.h>
#import <OakTextView/OakTextView.h>

@interface OakRunCommandWindowController () <NSWindowDelegate>
@property (nonatomic) NSTextField*         commandLabel;
@property (nonatomic) NSComboBox*          commandComboBox;
@property (nonatomic) NSTextField*         resultLabel;
@property (nonatomic) NSPopUpButton*       resultPopUpButton;
@property (nonatomic) NSButton*            executeButton;
@property (nonatomic) NSButton*            cancelButton;
@property (nonatomic) NSObjectController*  objectController;
@property (nonatomic) OakHistoryList*      commandHistoryList;
@property (nonatomic) NSMutableArray*      myConstraints;
@end

#ifndef CONSTRAINT
#define CONSTRAINT(str, align) [_myConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:str options:align metrics:nil views:views]]
#endif

@implementation OakRunCommandWindowController
{
	NSDictionary* _outputOptions;
}

+ (OakRunCommandWindowController*)sharedInstance
{
	static OakRunCommandWindowController* instance = [OakRunCommandWindowController new];
	return instance;
}

- (id)init
{
	if((self = [super initWithWindow:[[NSPanel alloc] initWithContentRect:NSZeroRect styleMask:(NSTitledWindowMask|NSClosableWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask) backing:NSBackingStoreBuffered defer:NO]]))
	{
		self.myConstraints        = [NSMutableArray new];

		self.commandLabel         = OakCreateLabel(@"Command:");
		self.commandComboBox      = OakCreateComboBox();
		self.resultLabel          = OakCreateLabel(@"Result:");
		self.resultPopUpButton    = OakCreatePopUpButton();
		self.executeButton        = OakCreateButton(@"Execute");
		self.cancelButton         = OakCreateButton(@"Cancel");
		
		_outputOptions = @{
			@(output::replace_input) : @"Replace Input",
			@(output::after_input)   : @"Insert After Input",
		};

		for(NSNumber* type in _outputOptions)
			[self.resultPopUpButton addItemWithTitle:_outputOptions[type]];

		[self.resultLabel  setAlignment:NSRightTextAlignment];
		[self.commandLabel setAlignment:NSRightTextAlignment];

		self.executeButton.action = @selector(execute:);
		self.cancelButton.action  = @selector(cancel:);

		self.objectController     = [[NSObjectController alloc] initWithContent:self];
		self.commandHistoryList   = [[OakHistoryList alloc] initWithName:@"Filter Through Command History" stackSize:10 defaultItems:@"cat -n", nil];

		self.window.title         = @"Filter Through Command";
		self.window.delegate      = self;

		[self.commandComboBox bind:NSValueBinding         toObject:_objectController withKeyPath:@"content.commandHistoryList.head" options:nil];
		[self.commandComboBox bind:NSContentValuesBinding toObject:_objectController withKeyPath:@"content.commandHistoryList.list" options:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commandChanged:) name:NSControlTextDidChangeNotification object:self.commandComboBox];
		[self commandChanged:nil];

		NSDictionary* views = @{
			@"commandLabel" : self.commandLabel,
			@"command"      : self.commandComboBox,
			@"resultLabel"  : self.resultLabel,
			@"result"       : self.resultPopUpButton,
			@"execute"      : self.executeButton,
			@"cancel"       : self.cancelButton,
		};

		NSView* contentView = self.window.contentView;
		for(NSView* view in [views allValues])
		{
			[view setTranslatesAutoresizingMaskIntoConstraints:NO];
			[contentView addSubview:view];
		}

		CONSTRAINT(@"H:|-[commandLabel]-[command(>=250)]-|", NSLayoutFormatAlignAllBaseline);
		CONSTRAINT(@"H:|-[resultLabel(==commandLabel)]-[result]-(>=20)-|", NSLayoutFormatAlignAllBaseline);
		CONSTRAINT(@"H:|-(>=20)-[cancel]-[execute]-|", NSLayoutFormatAlignAllBaseline);
		CONSTRAINT(@"V:|-[command]-[result]", NSLayoutFormatAlignAllLeft);
		CONSTRAINT(@"V:[result]-[execute]-|", 0);

		[self.window.contentView addConstraints:_myConstraints];

		NSView* keyViewLoop[] = { self.commandComboBox, self.resultPopUpButton, self.cancelButton, self.executeButton };
		for(size_t i = 0; i < sizeofA(keyViewLoop); ++i)
			keyViewLoop[i].nextKeyView = keyViewLoop[(i + 1) % sizeofA(keyViewLoop)];

		self.window.initialFirstResponder = self.commandComboBox;
		self.window.defaultButtonCell     = self.executeButton.cell;
	}
	return self;
}

- (void)commandChanged:(NSNotification*)notification
{
	self.executeButton.enabled = NSNotEmptyString([self.commandComboBox.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
}

- (IBAction)execute:(id)sender
{
	if(![self.objectController commitEditing])
		return;

	NSString* command = self.commandComboBox.stringValue;
	output::type outputType = (output::type)[self.resultPopUpButton indexOfSelectedItem];

	if(id textView = [NSApp targetForAction:@selector(filterDocumentThroughCommand:replacingDocument:)])
		[textView filterDocumentThroughCommand:command replacingDocument:(outputType == output::replace_input)];

	[self close];
}

- (IBAction)cancel:(id)sender
{
	NSLog(@"%s", sel_getName(_cmd));
	[self close];
}
@end
