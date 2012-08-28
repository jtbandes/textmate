@class OakKeyEquivalentView;

@interface PropertiesViewController : NSViewController
- (id)initWithName:(NSString*)aName;
@property (nonatomic, retain) NSMutableDictionary* properties;
@property (nonatomic, readonly) CGFloat indent;
@end
