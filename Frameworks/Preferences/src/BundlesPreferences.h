#import <MASPreferences/MASPreferencesViewController.h>
#import <MGScopeBar/MGScopeBarDelegateProtocol.h>
#import <updater/updater.h>

@class BundlesManager;

@interface BundlesPreferences : NSViewController <MASPreferencesViewController, MGScopeBarDelegate>
@property (nonatomic, readonly) NSString* identifier;
@property (nonatomic, readonly) NSImage*  toolbarItemImage;
@property (nonatomic, readonly) NSString* toolbarItemLabel;
@end
