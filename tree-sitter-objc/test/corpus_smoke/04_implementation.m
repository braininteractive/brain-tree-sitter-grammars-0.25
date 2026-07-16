#import "Downloader.h"

@implementation Downloader

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _baseURL = url;
        _userAgent = @"agent/1.0";
    }
    return self;
}

- (nullable NSString *)cachedTokenForKey:(NSString *)key {
    NSDictionary *cache = @{@"a": @1, @"b": @2};
    return [cache objectForKey:key];
}

- (void)reset {
    self.userAgent = nil;
}

@end
