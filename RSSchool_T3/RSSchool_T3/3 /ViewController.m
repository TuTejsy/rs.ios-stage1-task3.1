#import "ViewController.h"

@implementation ViewController

#pragma mark -

@synthesize processButton;
@synthesize currentColorView;
@synthesize currentColorLabel;
@synthesize redTextField;
@synthesize greenTextField;
@synthesize blueTextField;

// TextFieldDelegate
- (BOOL) textFieldDidBeginEditing:(UITextField *)TextField {
    currentColorLabel.text = @"Color";
    currentColorLabel.textColor = UIColor.blackColor;
    return YES;
}

//
- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize viewSize = self.view.frame.size;
    self.view.accessibilityIdentifier = @"mainView";
    
    CGRect currentColorViewFrame = CGRectMake(viewSize.width * 0.4 - 10, 50, viewSize.width * 0.6 - 10, 50);
    currentColorView = [[UIView alloc] initWithFrame:currentColorViewFrame];
    currentColorView.backgroundColor = UIColor.whiteColor;
    currentColorView.layer.cornerRadius = 3;
    currentColorView.layer.borderWidth = 0.3f;
    currentColorView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    currentColorView.accessibilityIdentifier = @"viewResultColor";
    [self.view addSubview:currentColorView];
    
    // Labels
    CGRect currentColorLabelFrame = CGRectMake(20, 50, viewSize.width * 0.4 - 10 - 15, 50);
    currentColorLabel = [[UILabel alloc] initWithFrame:currentColorLabelFrame];
    currentColorLabel.text = @"Color";
    currentColorLabel.accessibilityIdentifier = @"labelResultColor";
    [self.view addSubview:currentColorLabel];
    
    CGRect redColorLabelFrame = CGRectMake(20, 50 + 70, 100, 30);
    UILabel *redColorLabel = [[UILabel alloc] initWithFrame:redColorLabelFrame];
    redColorLabel.text = @"RED";
    redColorLabel.accessibilityIdentifier = @"labelRed";
    [self.view addSubview:redColorLabel];
    
    CGRect greenColorLabelFrame = CGRectMake(20, 50 + 70 * 2, 100, 30);
    UILabel *greenColorLabel = [[UILabel alloc] initWithFrame:greenColorLabelFrame];
    greenColorLabel.text = @"GREEN";
    greenColorLabel.accessibilityIdentifier = @"labelGreen";
    [self.view addSubview:greenColorLabel];
    
    CGRect blueColorLabelFrame = CGRectMake(20, 50 + 70 * 3, 100, 30);
    UILabel *blueColorLabel = [[UILabel alloc] initWithFrame:blueColorLabelFrame];
    blueColorLabel.text = @"BLUE";
     blueColorLabel.accessibilityIdentifier = @"labelBlue";
    [self.view addSubview:blueColorLabel];

    // TextField
    UIView *redPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
   
    CGRect redTextFieldFrame = CGRectMake(viewSize.width * 0.3, 50 + 70, viewSize.width * 0.7 - 20, 30);
    redTextField = [[UITextField alloc] initWithFrame:redTextFieldFrame];
    redTextField.layer.borderWidth = 0.3f;
    redTextField.layer.cornerRadius = 5.0f;
    redTextField.keyboardType = UIKeyboardTypeNumberPad;
    redTextField.layer.borderColor = UIColor.blackColor.CGColor;
    redTextField.placeholder = @"0..255";
    redTextField.leftView = redPaddingView;
    redTextField.leftViewMode = UITextFieldViewModeAlways;
    redTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    redTextField.accessibilityIdentifier = @"textFieldRed";
    redTextField.delegate = self;
    
    [self.view addSubview: redTextField];
    
    UIView *greenPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    CGRect greenTextFieldFrame = CGRectMake(viewSize.width * 0.3, 50 + 70 * 2, viewSize.width * 0.7 - 20, 30);
    greenTextField = [[UITextField alloc] initWithFrame:greenTextFieldFrame];
    greenTextField.layer.borderWidth = 0.3f;
    greenTextField.layer.cornerRadius = 5.0f;
    greenTextField.keyboardType = UIKeyboardTypeNumberPad;
    greenTextField.layer.borderColor = UIColor.blackColor.CGColor;
    greenTextField.placeholder = @"0..255";
    greenTextField.leftView = greenPaddingView;
    greenTextField.leftViewMode = UITextFieldViewModeAlways;
    greenTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    greenTextField.accessibilityIdentifier = @"textFieldGreen";
    greenTextField.delegate = self;
    
    [self.view addSubview: greenTextField];
    
    UIView *bluePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    
    CGRect blueTextFieldFrame = CGRectMake(viewSize.width * 0.3, 50 + 70 * 3, viewSize.width * 0.7 - 20, 30);
    blueTextField = [[UITextField alloc] initWithFrame:blueTextFieldFrame];
    blueTextField.layer.borderWidth = 0.3f;
    blueTextField.layer.cornerRadius = 5.0f;
    blueTextField.keyboardType = UIKeyboardTypeNumberPad;
    blueTextField.layer.borderColor = UIColor.blackColor.CGColor;
    blueTextField.placeholder = @"0..255";
    blueTextField.leftView = bluePaddingView;
    blueTextField.leftViewMode = UITextFieldViewModeAlways;
    blueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    blueTextField.accessibilityIdentifier = @"textFieldBlue";
    blueTextField.delegate = self;
    
    [self.view addSubview: blueTextField];

    processButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [processButton setTitle:@"Process" forState:UIControlStateNormal];
    processButton.frame = CGRectMake(self.view.center.x - 50, self.view.center.y + 200, 100, 20);
    
    [processButton addTarget:self
              action:@selector(ButtonPressed)
    forControlEvents:UIControlEventTouchUpInside];
    processButton.accessibilityIdentifier = @"buttonProcess";
    
    [self.view addSubview: processButton];

}

- (void) ButtonPressed {
    NSString *redTextFieldValue = redTextField.text;
    NSString *greenTextFieldValue = greenTextField.text;
    NSString *blueTextFieldValue = blueTextField.text;
    
    NSString *concatString = [NSString stringWithFormat:@"%@%@%@", redTextFieldValue, greenTextFieldValue, blueTextFieldValue];
    NSCharacterSet *concatStringSet = [NSCharacterSet characterSetWithCharactersInString:concatString];
    NSCharacterSet *numericOnly = [NSCharacterSet decimalDigitCharacterSet];
    
    int redValue = [redTextFieldValue intValue];
    int greenValue = [greenTextFieldValue intValue];
    int blueValue = [blueTextFieldValue intValue];
    
    BOOL isMixedSuccessed = ([numericOnly isSupersetOfSet: concatStringSet]) && (redTextFieldValue.length > 0 && redValue >= 0 && redValue <= 255) && (greenTextFieldValue.length > 0 && greenValue >= 0 && greenValue <= 255) && (blueTextFieldValue.length > 0 && blueValue >= 0 && blueValue <= 255);
    
    if (isMixedSuccessed) {
        currentColorView.backgroundColor = [UIColor colorWithRed: redValue / 255.0 green: greenValue / 255.0 blue: blueValue / 255.0 alpha:1.00];
        
        currentColorLabel.text = [self getHexFromR: redValue G: greenValue B: blueValue];
    } else {
        currentColorLabel.text = @"Error";
        currentColorLabel.textColor = UIColor.redColor;
        currentColorView.backgroundColor = UIColor.whiteColor;
    }

    redTextField.text = @"";
    greenTextField.text = @"";
    blueTextField.text = @"";
    [redTextField resignFirstResponder];
    [greenTextField resignFirstResponder];
    [blueTextField resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    processButton.frame = CGRectMake(self.view.center.x - 50, self.view.frame.size.height - keyboardSize.height - 40, 100, 20);
}


- (void)keyboardWillHide:(NSNotification *)notification {
    processButton.frame = CGRectMake(self.view.center.x - 50, self.view.center.y + 200, 100, 20);
}

- (NSString*)getHexFromR: (int)r G:(int)g B:(int)b {
    NSString* hexString = [NSString stringWithFormat:@"0x%02lX%02lX%02lX", lroundf(r), lroundf(g), lroundf(b)];
    return hexString;
}

@end
