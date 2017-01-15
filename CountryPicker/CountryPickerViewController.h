//
//  CountryPickerViewController.h
//  CountryPickerDemo
//
//  Created by Theodore Gonzalez on 1/15/17.
//
//

#import <UIKit/UIKit.h>
@class CountryPickerViewController;
@protocol CountryPickerViewControllerDelegate

- (void)countryPickerViewController:(CountryPickerViewController *)countryPickerViewController didSelectCountryWithName:(NSString *)name code:(NSString *)code dialCode:(NSString *)dialCode;

@end
@interface CountryPickerViewController : UIViewController
@property (nonatomic, weak) id<CountryPickerViewControllerDelegate> delegate;
@end
