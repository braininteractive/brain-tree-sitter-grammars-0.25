#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const AFNetworkingErrorDomain;
FOUNDATION_EXPORT NSString *const AFNetworkingOperationFailingURLResponseErrorKey;

FOUNDATION_EXPORT NSString * AFStringFromOption(NSInteger option);

@interface Logger : NSObject
+ (instancetype)sharedLogger;
- (void)logMessage:(NSString *)message level:(NSInteger)level;
@end

NS_ASSUME_NONNULL_END
