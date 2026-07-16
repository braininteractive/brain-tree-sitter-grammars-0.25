#import <Foundation/Foundation.h>

typedef enum {
    AFOptionNone = 0,
    AFOptionRetry = 1,
    AFOptionCache = 2,
} AFOption;

enum AFPriority {
    AFPriorityLow,
    AFPriorityNormal,
    AFPriorityHigh,
};

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property (nonatomic, assign) AFOption options;
@end

NS_ASSUME_NONNULL_END
