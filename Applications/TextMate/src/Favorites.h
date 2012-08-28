#import <OakFilterList/OakFilterList.h>
#import <text/ctype.h>

@class FavoritesViewController;

@interface FavoritesDataSource : NSObject <FilterListDataSource>
+ (FavoritesDataSource*)favoritesDataSource;
@property (nonatomic, readonly) NSString* filterString;
@end
