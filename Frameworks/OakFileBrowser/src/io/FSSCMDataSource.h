#import "FSDataSource.h"
#import <scm/scm.h>

@interface FSSCMDataSource : FSDataSource
+ (NSURL*)scmURLWithPath:(NSString*)aPath;
- (id)initWithURL:(NSURL*)anURL options:(NSUInteger)someOptions;
@end
