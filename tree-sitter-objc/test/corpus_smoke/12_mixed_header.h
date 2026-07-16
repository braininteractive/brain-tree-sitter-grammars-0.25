// A grab-bag header exercising forward declarations, generics, availability
// macros (builtin and project-defined), and a nested nullability region.
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class Downloader;
@protocol Cancelable;

NS_ASSUME_NONNULL_BEGIN

@interface ImageCache<KeyType, ObjectType> : NSObject

@property (nonatomic, readonly) NSUInteger count;

- (nullable ObjectType)objectForKey:(KeyType)key API_AVAILABLE(ios(9));
- (void)setObject:(ObjectType)obj forKey:(KeyType)key AF_API_AVAILABLE(ios(10), macos(10.11));
- (void)removeAllObjects NS_DEPRECATED_IOS(2_0, 9_0);

@end

@interface ImageCache (Metrics)
@property (nonatomic, readonly) double hitRate;
@end

NS_ASSUME_NONNULL_END
