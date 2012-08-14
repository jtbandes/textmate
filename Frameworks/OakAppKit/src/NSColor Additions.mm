#import "NSColor Additions.h"
#import <OakFoundation/OakFoundation.h>

void drawPattern(void *info, CGContextRef c);
void releasePatternInfo(void *info);
struct pattern_info_t
{
	pattern_info_t (NSColor* color, NSSize size, NSPoint offset, CGFloat xRadius, CGFloat yRadius) :
		color([color retain]), size(size), offset(offset), xRadius(xRadius), yRadius(yRadius) { }
	
	~pattern_info_t () { [color release]; }
	
	NSColor* color;
	NSSize size;
	NSPoint offset;
	CGFloat xRadius;
	CGFloat yRadius;
};

@implementation NSColor (Creation)
static BOOL hasFullCGColorSupport = NO;

+ (void)load
{
	// 10.8 provides +colorWithCGColor:
	IMP imp = [self methodForSelector:@selector(Oak_colorWithCGColor:)];
	hasFullCGColorSupport = !class_addMethod(object_getClass([self class]), @selector(colorWithCGColor:), imp, "@@:@");
}

+ (NSColor*)colorWithString:(NSString*)aString
{
	if(NSIsEmptyString(aString))
		return nil;

	unsigned int red = 0, green = 0, blue = 0, alpha = 0xFF;
	if(sscanf([aString UTF8String], "#%02x%02x%02x%02x", &red, &green, &blue, &alpha) >= 3)
		return [NSColor colorWithCalibratedRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];

	if([NSColor respondsToSelector:NSSelectorFromString(aString)])
		return [NSColor performSelector:NSSelectorFromString(aString)];

	return nil;
}

+ (NSColor*)Oak_colorWithCGColor:(CGColorRef)aColor
{
	return [NSColor colorWithColorSpace:[[[NSColorSpace alloc] initWithCGColorSpace:CGColorGetColorSpace(aColor)] autorelease] components:CGColorGetComponents(aColor) count:CGColorGetNumberOfComponents(aColor)];
}

+ (NSColor*)roundedRectPatternColorWithFillColor:(NSColor*)fillColor size:(NSSize)size offset:(NSPoint)offset xRadius:(CGFloat)xRadius yRadius:(CGFloat)yRadius
{
	if(!hasFullCGColorSupport)
		return nil;
	
	CGPatternCallbacks callbacks = { .version = 0, .drawPattern = drawPattern, .releaseInfo = releasePatternInfo };
	CGPatternRef pattern = CGPatternCreate(new pattern_info_t(fillColor, size, offset, xRadius, yRadius),
	                                       CGRectMake(0, 0, size.width, size.height),
	                                       CGAffineTransformMakeTranslation(offset.x, offset.y),
	                                       offset.x+size.width, offset.y+size.height,
	                                       kCGPatternTilingConstantSpacing, true, &callbacks);
	
	CGColorRef cgColor = CGColorCreateWithPattern(CGColorSpaceCreatePattern(NULL), pattern, (CGFloat[1]){ 1.0 });
	CGPatternRelease(pattern);
	
	NSColor* res = [self colorWithCGColor:cgColor];
	CGColorRelease(cgColor);
	
	return res;
}
@end

void drawPattern(void *info, CGContextRef ctx)
{
	pattern_info_t* patternInfo = (pattern_info_t*)info;
	
	NSGraphicsContext *gc = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:NO];
	[NSGraphicsContext setCurrentContext:gc];
	[gc saveGraphicsState];
	
	[patternInfo->color set];
	NSRect rect = NSMakeRect(0, 0, patternInfo->size.width, patternInfo->size.height);
	[[NSBezierPath bezierPathWithRoundedRect:rect xRadius:patternInfo->xRadius yRadius:patternInfo->yRadius] fill];
	
	[gc restoreGraphicsState];
}

void releasePatternInfo(void *info)
{
	delete (pattern_info_t*)info;
}

@implementation NSColor (OakColor)
- (BOOL)isDark
{
	uint32_t r(lroundf(255 * [self redComponent]));
	uint32_t g(lroundf(255 * [self greenComponent]));
	uint32_t b(lroundf(255 * [self blueComponent])); 

	uint32_t intensity = r*r*30 + g*g*59 + b*b*11;
	return intensity < 50*255*255;
}
@end

