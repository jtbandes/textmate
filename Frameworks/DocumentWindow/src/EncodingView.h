@class OakEncodingPopUpButton;

@interface EncodingViewController : NSViewController
@property (nonatomic, readonly) NSString* currentEncoding;
- (id)initWithFirst:(char const*)firstPointer last:(char const*)lastPointer;
@end
