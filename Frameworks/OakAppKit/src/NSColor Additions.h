@interface NSColor (Creation)
+ (NSColor*)colorWithString:(NSString*)aString;
+ (NSColor*)roundedRectPatternColorWithFillColor:(NSColor*)fillColor size:(NSSize)size offset:(NSPoint)offset xRadius:(CGFloat)xRadius yRadius:(CGFloat)yRadius;
@end

@interface NSColor ()
+ (NSColor*)colorWithCGColor:(CGColorRef)aColor;
@end

@interface NSColor (OakColor)
- (BOOL)isDark;
@end
