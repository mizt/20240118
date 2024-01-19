#import <Cocoa/Cocoa.h>
#import "Exit.h"

class App : public Exit  {
	
	private:
	
		NSRegularExpression *regularExpression(NSString *pattern) {
			return [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
		}
	
		const NSRegularExpression *UINT = regularExpression(@"[0-9]+");
			
		bool match(NSString *command,const NSRegularExpression *regexp) {
			NSTextCheckingResult *match;
			match = [regexp firstMatchInString:command options:0 range:NSMakeRange(0,command.length)];
			return (match&&command.length==match.range.length)?true:false;
		}
	
		bool isUINT(NSString *command) { return match(command,this->UINT); }
	
	public:
	
		App(NSArray *args) {
			
			bool err = true;
			
			if(args.count>=2) {
				
				if(this->isUINT(args[1])) {
					NSLog(@"%d",[args[1] intValue]);
					err = false;
				}
			}
			
			if(err) {
				this->exit(1);
			}
			else {
				this->exit(0);
			}
		}
		
		~App() {
		}
	
};

@interface AppDelegate:NSObject <NSApplicationDelegate> {
	App *app;
}
@end

@implementation AppDelegate
-(void)applicationDidFinishLaunching:(NSNotification*)aNotification {
	NSArray *args = [[NSProcessInfo processInfo] arguments];
	app = new App(args);
}

-(void)applicationWillTerminate:(NSNotification *)aNotification {
	int status = app->status();
	if(app) delete app;
	exit(status);
}
@end

int main(int argc, char *argv[]) {
	@autoreleasepool {
		id app = [NSApplication sharedApplication];
		id delegat = [AppDelegate alloc];
		[app setDelegate:delegat];
		[app run];
	}
}