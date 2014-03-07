//
//  TipViewController.m
//  tipcalculator
//
//  Created by Thomas Ezan on 2/18/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
#import "SAMGradientView.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIView *viewTest;


- (IBAction)onTap:(id)sender;
- (void) updateValues;
- (void) onSettingsButton;

@end

@implementation TipViewController

NSString *currencySign;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";

        // Initialize a gradient view
        SAMGradientView *gradientView = [[SAMGradientView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
        
        // Set the gradient colors
        gradientView.gradientColors = @[[UIColor orangeColor], [UIColor blueColor]];
        
        // Optionally set some locations
        // gradientView.gradientLocations = @[@0.1, @1.0];
        
        // Optionally change the direction. The default is vertical.
        gradientView.gradientDirection = SAMGradientViewDirectionVertical;
        
        // Add some borders too if you want
        gradientView.topBorderColor = [UIColor redColor];
        gradientView.bottomBorderColor = [UIColor blueColor];
        
        // Add it as a subview in all of its awesome
        [self.view addSubview:gradientView];
        [self.view sendSubviewToBack:gradientView];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    
    [self updateValues];
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    // Pull the defaut tip percentage
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipSection = [defaults integerForKey:@"default_tip"];
    int defaultCurrencySection = [defaults integerForKey:@"default_currency"];
    
    [self.tipControl setSelectedSegmentIndex:defaultTipSection];
    
    
    NSArray *currencySignValues = @[@"$", @"€", @"¥"];
    
    NSLog(@"currency section %d", defaultCurrencySection);
    
    currencySign = [currencySignValues objectAtIndex:defaultCurrencySection];
    
    [self updateValues];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues{
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.1), @(0.15),@(0.2)];
    
    float tipAmount = billAmount*[tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%@ %0.2f", currencySign, tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%@ %0.2f",currencySign, totalAmount];

}

- (void) onSettingsButton{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
