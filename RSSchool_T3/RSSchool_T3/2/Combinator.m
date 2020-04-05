#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    int m = [[array firstObject] intValue];
    int n = [[array lastObject] intValue];
    
    int x = 1;
    NSUInteger nFactorial = [Combinator getFactorial:n];
    
    while (x < n) {
        NSUInteger result = nFactorial / ([Combinator getFactorial:x] * [Combinator getFactorial:(n - x)]);
        
        if (result >= m) {
            return @(x);
        }
        
        x++;
    }
    
    return nil;
}

+ (NSUInteger)getFactorial:(int)num {
    if(num < 2) {
        return(1);
    }

    NSUInteger result = 1;
    for (int i = num; i > 1; i--) {
        result *= i;
    }

    return result;
}

@end
