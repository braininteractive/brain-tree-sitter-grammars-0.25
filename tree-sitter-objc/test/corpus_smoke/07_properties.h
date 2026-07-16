#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestConfig : NSObject

@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, assign, getter=isCachingEnabled) BOOL cachingEnabled;
@property (nonatomic, strong, readonly) NSMutableDictionary<NSString *, NSString *> *headers;
@property (nonatomic, copy, nullable) void (^progressHandler)(double);
@property (readonly, nonatomic, unsafe_unretained) NSURL *sourceURL;
@property (class, nonatomic, readonly) RequestConfig *defaultConfig;

@end

NS_ASSUME_NONNULL_END
