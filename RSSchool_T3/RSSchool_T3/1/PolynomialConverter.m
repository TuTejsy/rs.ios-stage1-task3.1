#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSMutableString *resultString = [@"" mutableCopy];
    
    int numbersLength = (int)numbers.count;
    
    if (numbersLength == 0) {
        return nil;
    }
    
    int currentNumberIndex = 1;
    
    for (NSNumber *number in numbers) {
        int intNumber = [number intValue];
        BOOL isPositive = (intNumber > 0);
        int absIntNumber = abs(intNumber);
        NSString *sign;
        
        if (currentNumberIndex == 1) {
            sign = isPositive ? @"" : @"- ";
        } else {
            sign = isPositive ? @" + " : @" - ";
        }
        
        if (absIntNumber > 1) {
            if (currentNumberIndex < numbersLength - 1) {
                [resultString appendString:[NSString stringWithFormat:@"%@%ix^%i", sign, absIntNumber, numbersLength - currentNumberIndex]];
            } else if (currentNumberIndex == numbersLength - 1) {
                [resultString appendString:[NSString stringWithFormat:@"%@%ix", sign, absIntNumber]];
            } else {
                [resultString appendString:[NSString stringWithFormat:@"%@%i", sign, absIntNumber]];
            }
        } else if (absIntNumber == 1 ) {
            if (currentNumberIndex < numbersLength - 1) {
                [resultString appendString:[NSString stringWithFormat:@"%@x^%i", sign,  numbersLength - currentNumberIndex]];
            } else if (currentNumberIndex == numbersLength - 1) {
                [resultString appendString:[NSString stringWithFormat:@"%@x", sign]];
            } else {
                [resultString appendString:[NSString stringWithFormat:@"%@%i", sign, intNumber]];
            }
        }
        
        currentNumberIndex++;
    }
    
    
    return [resultString copy];
}
@end
