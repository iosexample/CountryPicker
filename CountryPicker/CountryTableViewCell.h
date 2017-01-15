//
//  CountryTableViewCell.h
//  CountryPickerDemo
//
//  Created by Theodore Gonzalez on 1/15/17.
//
//

#import <UIKit/UIKit.h>

@interface CountryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivFlag;
@property (weak, nonatomic) IBOutlet UILabel *lbCountryCode;
@property (weak, nonatomic) IBOutlet UILabel *lbCountryName;

@end
