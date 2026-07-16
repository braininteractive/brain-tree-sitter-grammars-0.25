// A modern header wrapped in a nullability audit region. This is the exact
// shape (NS_ASSUME_NONNULL_BEGIN ... NS_ASSUME_NONNULL_END around interfaces
// and forward declarations) that used to cascade the whole file into ERRORs.
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AFHTTPSessionManager;
@protocol AFURLResponseSerialization;

@interface Downloader : NSObject

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, copy, nullable) NSString *userAgent;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (nullable NSString *)cachedTokenForKey:(NSString *)key;

@end

@interface Downloader (Convenience)
- (void)reset;
@end

NS_ASSUME_NONNULL_END
