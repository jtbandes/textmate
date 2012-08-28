#import <HTMLOutput/HTMLOutput.h>
#import <command/runner.h>
#import <oak/debug.h>

PUBLIC @interface HTMLOutputWindowController : NSObject <NSWindowDelegate>
+ (HTMLOutputWindowController*)HTMLOutputWindowWithRunner:(command::runner_ptr const&)aRunner;
@end
