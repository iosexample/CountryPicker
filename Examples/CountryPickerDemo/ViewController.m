//
//  ViewController.m
//  CountryPickerDemo
//
//  Created by Nick Lockwood on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CountryPickerViewController.h"

@interface ViewController() <CountryPickerViewControllerDelegate>
@end

@implementation ViewController

@synthesize nameLabel, codeLabel, dailCodeLabel;

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code dailCode:(NSString *)dailCode
{
    self.nameLabel.text = name;
    self.codeLabel.text = code;
    self.dailCodeLabel.text = dailCode;
    
}

- (IBAction)showCountryPicker:(id)sender {
    CountryPickerViewController *picker = [[CountryPickerViewController alloc] init];
    picker.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:picker];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(cancel)];
    [[picker navigationItem] setLeftBarButtonItem:cancelItem];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)countryPickerViewController:(CountryPickerViewController *)countryPickerViewController didSelectCountryWithName:(NSString *)name code:(NSString *)code dialCode:(NSString *)dialCode
{
    self.nameLabel.text = name;
    self.codeLabel.text = code;
    self.dailCodeLabel.text = dialCode;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
