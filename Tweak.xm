//#import <UIKit/UIKit.h>
#import <GraphicsServices/GSFont.h>
#import <substrate.h>


NSString *nameOfFont;

MSHook(GSFontRef, GSFontCreateWithName, const char* fontName, GSFontTraitMask traits, CGFloat fontSize) { //declare the hooking function
	//NSLog(@"%s", fontName);
	GSFontRef font; //declare new gsfontref
	const char* newfontname; //declare const char newfontname but not initialise it
	if (fontName && strlen(fontName)) { //if fontName exists (everything is possible :P) and strlen != 0 then another font is already needed by the system...
		newfontname = fontName; //just fill newfontname with fontName
	} else { //else
		//NSLog(@"%@",nameOfFont);
		newfontname = [nameOfFont cStringUsingEncoding:NSASCIIStringEncoding]; //overwrite (not even existing (then, i think Helvetica Neue is needed)) fontName with your own fontname e.g. Noteworthy
	}
	
	font = _GSFontCreateWithName(newfontname, traits, fontSize); //call original function and have fun :D
	//NSLog(@"%@", font);
	if (font == nil) {
		font = _GSFontCreateWithName(fontName, traits, fontSize);
		//NSLog(@"--Font does not exist!");
	}
	return font; //return the font
}

%ctor { //when loading this tweak
NSDictionary *prefs = [[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/org.h6nry.bfltmprefs.plist"] autorelease];
nameOfFont = [prefs objectForKey:@"fontname"]; //get font name from prefs


NSString *dir = [[@"/Library/BytaFont/" stringByAppendingString:nameOfFont] stringByAppendingString:@".font/"];
NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];

NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.ttf'"]; //wirklich nur ttf??? oder auch ttc und otf und alles andere???
NSArray *onlyFonts = [dirContents filteredArrayUsingPredicate:fltr];

BOOL add;
NSString *fontDir;

for (NSString *fontDirS in onlyFonts) {
	fontDir = [dir stringByAppendingString:fontDirS];
	add = GSFontAddFromFile([fontDir cStringUsingEncoding:NSASCIIStringEncoding]);// /Library/CustomFonts/Regular.ttf geht mit sandbox zusammen... // /var/mobile/Library/MyFonts/Minecraft.font/Helvetica.ttc
	//NSLog(@"BFTM - Added Font:%i     %@",add, fontDir);
}


MSHookFunction(GSFontCreateWithName, MSHake(GSFontCreateWithName)); //tell mobilesubstrate to hook the function with the one above


[prefs autorelease];
[dir autorelease];
[fltr autorelease];
[onlyFonts autorelease];
[fontDir autorelease];
[nameOfFont autorelease];
}