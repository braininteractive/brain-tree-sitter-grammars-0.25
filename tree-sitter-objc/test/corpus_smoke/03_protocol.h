#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SessionDelegate <NSObject>

@required
- (void)sessionDidStart:(id)session;

@optional
- (void)session:(id)session didFailWithError:(nullable NSError *)error;
- (BOOL)sessionShouldRetry:(id)session;

@end

@protocol Cancelable;

NS_ASSUME_NONNULL_END
