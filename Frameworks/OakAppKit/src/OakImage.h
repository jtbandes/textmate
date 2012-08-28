#import <oak/misc.h>

PUBLIC @interface OakImage : NSImage
@property (nonatomic, retain) NSImage* base;
@property (nonatomic, retain) NSImage* badge;
@property (nonatomic, assign) CGRectEdge edge;

+ (OakImage*)imageWithBase:(NSImage*)imageBase;
+ (OakImage*)imageWithBase:(NSImage*)imageBase badge:(NSImage*)badgeImage;
+ (OakImage*)imageWithBase:(NSImage*)imageBase badge:(NSImage*)badgeImage edge:(CGRectEdge)badgeEdge;
@end
