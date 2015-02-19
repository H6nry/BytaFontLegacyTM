#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>

@interface bfltmprefsListController: PSListController {
}
-(NSArray*)dataFromTarget:(id)target;
-(NSArray*)titlesFromTarget:(id)target;
@end

@implementation bfltmprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"bfltmprefs" target:self] retain];
	}
	return _specifiers;
}

-(NSArray*)dataFromTarget:(id)target {
	
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/BytaFont/" error:nil];
	
	NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.font'"];
	NSArray *onlyFonts = [dirContents filteredArrayUsingPredicate:fltr];
	
	NSMutableArray *finals = [[NSMutableArray alloc] init];
	[finals addObject:@""];
	
	for (NSString *name in onlyFonts) {
		NSRange needleRange = NSMakeRange(0,name.length-5);
		
		[finals addObject:[name substringWithRange:needleRange]];
	}
	
	NSArray* array = [[NSArray alloc] initWithArray:finals];
	
	/*[dirContents autorelease];
	[fltr autorelease];
	[onlyFonts autorelease];
	[finals autorelease];
	[array autorelease];*/
	
	return array;
}

-(NSArray*)titlesFromTarget:(id)target {
	NSMutableArray *fonts = [NSMutableArray arrayWithArray:[self dataFromTarget:target]];
	[fonts replaceObjectAtIndex:0 withObject:@"Default (no theming)"];
	
	return fonts;
}

- (void)apply {
	system("killall -9 SpringBoard");
}

- (void)twitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/H6nry_/"]];
}

- (void)mail {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:henry.anonym@gmail.com"]];
}

-(void) pre {
	system("killall -9 Preferences");
	//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
}
@end

// vim:ft=objc
