#import "Downloader.h"

@interface Downloader ()
@property (nonatomic, strong) NSMutableArray *pending;
@property (nonatomic, assign) BOOL running;
@end

@implementation Downloader (Private)

- (void)start {
    self.running = YES;
    for (id task in self.pending) {
        [task performSelector:@selector(run)];
    }
}

@end
