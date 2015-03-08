//import <UIKit/UIKit.h>
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
	if (![nameOfFont isEqualToString:@""]) {
		font = _GSFontCreateWithName(newfontname, traits, fontSize); //call original function and have fun :D
		//font = _GSFontCreateWithName(fontName, traits, fontSize); //call original function and have fun :D
		
		//NSLog(@"%@",font);
		if (font == nil) {
			//NSLog(@"--Font does not exist! Trying to load it...");
			
			
			/*NSString *dir = [[@"/Library/BytaFont/" stringByAppendingString:nameOfFont] stringByAppendingString:@".font/"];
			NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
			NSLog(@"--------1");
			NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.ttf'"]; //wirklich nur ttf??? oder auch ttc und otf und alles andere???
			NSArray *onlyFonts = [dirContents filteredArrayUsingPredicate:fltr];
			NSLog(@"--------2  ");
			NSString *fontDir;
			BOOL add;

			for (NSString *fontDirS in onlyFonts) {
				fontDir = [dir stringByAppendingString:fontDirS];
				add = GSFontAddFromFile([fontDir cStringUsingEncoding:NSASCIIStringEncoding]);// /Library/CustomFonts/Regular.ttf geht mit sandbox zusammen... // /var/mobile/Library/MyFonts/Minecraft.font/Helvetica.ttc
				NSLog(@"added:%i",add);
			}
			[dir release];
			[dirContents release];
			[fltr release];
			[onlyFonts release];
			[fontDir release];*/
			NSString *dir = [[@"/Library/BytaFont/" stringByAppendingString:nameOfFont] stringByAppendingString:@".font/"];
			NSString *fontDir = [dir stringByAppendingString:@"Regular.ttf"];
			GSFontAddFromFile([fontDir cStringUsingEncoding:NSASCIIStringEncoding]);// /Library/CustomFonts/Regular.ttf geht mit sandbox zusammen... // /var/mobile/Library/MyFonts/Minecraft.font/Helvetica.ttc
			
			
			//NSLog(@"--------3");
		}
		//CFRelease(font);
		font = _GSFontCreateWithName(newfontname, traits, fontSize);
		if (font == nil) {
			//CFRelease(font);
			//NSLog(@"--Could not load font! quitting now!");
			font = _GSFontCreateWithName(fontName, traits, fontSize);
		}
	} else {
		font = _GSFontCreateWithName(fontName, traits, fontSize);
	}
	
	return font; //return the font
}

%ctor { //when loading this tweak
//NSLog(@"------------------------------------------------------Loading BFLTM");
NSDictionary *prefs = [[[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/org.h6nry.bfltmprefs.plist"] autorelease];
nameOfFont = [prefs objectForKey:@"fontname"]; //get font name from prefs
//nameOfFont = @"Noteworthy";

MSHookFunction(GSFontCreateWithName, MSHake(GSFontCreateWithName)); //tell mobilesubstrate to hook the function with the one above

//NSLog(@"Loaded BFLTM--------");
}