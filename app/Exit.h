class Exit {
	
	private:
	
		int _status = 0;

	public:
	
		int status() {
			return this->_status;
		};
	
	protected:
	
		void exit(int n=0) {
			this->_status = n;
			dispatch_after(DISPATCH_TIME_NOW,dispatch_get_main_queue(),^{
				[[NSNotificationCenter defaultCenter] postNotificationName:NSApplicationWillTerminateNotification object:NSApp];
			});
		}
};