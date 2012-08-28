#include <file/encoding.h>
#import <oak/misc.h>

PUBLIC @interface OakSavePanel : NSObject
+ (void)showWithPath:(NSString*)aPathSuggestion directory:(NSString*)aDirectorySuggestion fowWindow:(NSWindow*)aWindow delegate:(id)aDelegate encoding:(encoding::type const&)encoding;
@end

@interface NSObject (OakSavePanelDelegate)
- (void)savePanelDidEnd:(OakSavePanel*)sheet path:(NSString*)aPath encoding:(encoding::type const&)encoding;
@end
