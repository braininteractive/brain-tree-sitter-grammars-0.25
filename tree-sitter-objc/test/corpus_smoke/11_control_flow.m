#import <Foundation/Foundation.h>

@implementation Parser

- (id)parseValue:(id)value {
    @try {
        if ([value isKindOfClass:[NSString class]]) {
            NSString *text = (NSString *)value;
            return [text stringByAppendingString:@"!"];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            return @([value integerValue] * 2);
        }
    } @catch (NSException *exception) {
        NSLog(@"parse error: %@", exception);
    } @finally {
        NSLog(@"done");
    }

    NSInteger count = 0;
    while (count < 10) {
        count += 1;
    }

    return @(count);
}

@end
