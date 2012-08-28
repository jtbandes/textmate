#include <oak/debug.h>

@interface ReleaseNotesWindowController : NSWindowController
+ (void)showPath:(NSString*)aPath;
+ (void)showPathIfUpdated:(NSString*)aPath;
@end
