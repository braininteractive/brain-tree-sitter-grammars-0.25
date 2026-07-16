// Availability / deprecation attribute macros on properties and methods,
// mixing the builtin spellings (API_AVAILABLE, NS_DEPRECATED_IOS) with a
// project-defined macro (AF_API_AVAILABLE) that must now be accepted too.
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeatureFlags : NSObject

@property (nonatomic, assign) NSInteger version API_AVAILABLE(ios(10));
@property (nonatomic, copy) NSString *token AF_API_AVAILABLE(ios(11), macos(10.12));
@property (nonatomic, assign) BOOL legacy NS_DEPRECATED_IOS(2_0, 9_0);

- (void)enableFast API_AVAILABLE(ios(12), tvos(12));
- (void)enableExperimental AF_API_AVAILABLE(ios(13));
- (void)oldEntryPoint NS_DEPRECATED_IOS(2_0, 8_0);
- (void)unavailableEntryPoint NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
