#import <Foundation/Foundation.h>

@implementation NetworkClient

- (void)fetch {
    void (^completion)(NSData *, NSError *) = ^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"failed: %@", error);
            return;
        }
        [self handleData:data];
    };

    NSArray *items = @[@"one", @"two", @"three"];
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%lu -> %@", (unsigned long)idx, obj);
    }];

    completion(nil, nil);
}

@end
