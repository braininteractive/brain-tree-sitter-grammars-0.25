#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Trimming)
- (NSString *)af_trimmedString;
- (nullable NSString *)af_stringByRemovingPrefix:(NSString *)prefix;
@end

@interface NSArray<ObjectType> (SafeAccess)
- (nullable ObjectType)af_objectOrNilAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
