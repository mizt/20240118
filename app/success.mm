#import <Cocoa/Cocoa.h>
#import "Exit.h"

class App : public Exit  {
	
	public:
	
		App(NSArray *args) {
			this->exit(0);
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