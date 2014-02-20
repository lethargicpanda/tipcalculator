//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Thomas Ezan on 2/18/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipDefaultControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencyDefaultControl;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidDisappear:(BOOL)animated{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.tipDefaultControl.selectedSegmentIndex forKey:@"default_tip"];
    [defaults setInteger:self.currencyDefaultControl.selectedSegmentIndex forKey:@"default_currency"];
    
    [defaults synchronize];
    
    [super viewDidDisappear: animated];
}

- (void) viewWillAppear:(BOOL)animated{
    // Pull the defaut tip percentage
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipSection = [defaults integerForKey:@"default_tip"];
    int defaultCurrency = [defaults integerForKey:@"default_currency"];
    
    [self.tipDefaultControl setSelectedSegmentIndex:defaultTipSection];
    [self.currencyDefaultControl setSelectedSegmentIndex:defaultCurrency];
    
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
