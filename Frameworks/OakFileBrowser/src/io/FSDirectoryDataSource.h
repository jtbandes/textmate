#import "FSDataSource.h"
#import <io/events.h>
#import <scm/scm.h>
#import <oak/CocoaSTL.h>

@interface FSDirectoryDataSource : FSDataSource
- (id)initWithURL:(NSURL*)anURL options:(NSUInteger)someOptions;
@end
